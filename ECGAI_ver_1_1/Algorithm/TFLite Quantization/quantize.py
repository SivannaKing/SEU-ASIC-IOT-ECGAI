# run in conda env Quan
import tensorflow as tf
from tensorflow import keras
import tensorflow_model_optimization as tfmot
from tensorflow.keras.optimizers import Adam

import argparse
import json
import os
import numpy as np

import load


# create ../model/"model_name"
# return 5 path
def make_model_dir():
    basic_path = '../model'
    if not os.path.exists(basic_path):
        os.makedirs(basic_path)
    fp32_model_path = os.path.join(basic_path, 'FP32_model.hdf5')
    baseline_model_path = os.path.join(basic_path, 'baseline_model.tflite')
    ptq_full_int8_model_path = os.path.join(basic_path, 'PTQ_FULL_INT8_model.tflite')
    ptq_weight_int8_model_path = os.path.join(basic_path, 'PTQ_WEIGHT_INT8_model.tflite')
    qat_model_path = os.path.join(basic_path, 'QAT_model.hdf5')
    qat_int8_model_path = os.path.join(basic_path, 'QAT_INT8_model.tflite')
    return [fp32_model_path,
            baseline_model_path,
            ptq_full_int8_model_path,
            ptq_weight_int8_model_path,
            qat_model_path,
            qat_int8_model_path]


# find best model in ../Train/saved
# return model
def find_best_model(basic_path):
    model_list = []
    model_path_list = []
    for root, dirs, files in os.walk(basic_path, topdown=False):
        if not files:
            continue
        for file in files:
            if file.endswith('.hdf5') is True:
                model_list.append(file)
                model_path_list.append(root)

    best_model_index = model_list.index(max(model_list))
    best_model_path = os.path.join(model_path_list[best_model_index], model_list[best_model_index])
    model = keras.models.load_model(best_model_path)
    return model


# 为了测定量化阈值，导入一段数据
# Use the first 300 ecgs in the quantization.
def representative_data_gen():
    # reshape input
    input_shape = (3600, 1)
    batch_input_shape = (1,) + input_shape

    # load train dataset
    train = load.load_dataset(params['train'])
    preproc = load.Preproc(*train)
    train_x, train_y = preproc.process(*train)
    train_x, train_y = load.data_shuffle(train_x, train_y, **params)

    for i in range(300):
        ecg = train_x[i].reshape(batch_input_shape)
        yield [ecg]


# converter to TFLite model
def TFLite_converter(model, Quantize='None'):
    converter = tf.lite.TFLiteConverter.from_keras_model(model)
    if Quantize == 'weights and activations':  # quantize weights and activations
        converter.optimizations = [tf.lite.Optimize.DEFAULT]
        converter.representative_dataset = representative_data_gen
        converter._experimental_new_quantizer = True  # pylint: disable=protected-access
        # to enable post-training quantization with the representative dataset
        # Ensure that if any ops can't be quantized, the converter throws an error
        converter.target_spec.supported_ops = [tf.lite.OpsSet.TFLITE_BUILTINS_INT8]
        # Set the input and output tensors to int8 (APIs added in r2.3)
        converter.inference_input_type = tf.int8
        converter.inference_output_type = tf.int8
    elif Quantize=='weights':  # quantize only weights
        converter.optimizations = [tf.lite.Optimize.OPTIMIZE_FOR_SIZE]
    elif Quantize=='None':
        print('converter baseline model')
    print('Convert TFLite model.')
    tflite_model = converter.convert()

    return tflite_model


# evaluate tflite model
# 评估TF Lite模型的准确率
# Define a helper function to evaluate the TF Lite model on the test dataset.
def TFLite_evaluate(tflite_model, ecg_ds):
    interpreter = tf.lite.Interpreter(model_content=tflite_model)
    interpreter.allocate_tensors()
    input_index = interpreter.get_input_details()[0]["index"]
    output_index = interpreter.get_output_details()[0]["index"]

    total_seen = 0
    num_correct = 0

    for dev_x, dev_y in ecg_ds:
        total_seen += 1
        interpreter.set_tensor(input_index, dev_x)
        # Run inference.
        interpreter.invoke()
        predictions = interpreter.get_tensor(output_index)
        if np.argmax(predictions) == np.argmax(dev_y.numpy()[0]):
            num_correct += 1

    accuracy = float(num_correct) / float(total_seen)

    return accuracy


# Clone and fine-tune pre-trained model with quantization aware training
# You will apply quantization aware training to the whole model and see this in the model summary.
# All layers are now prefixed by "quant".
# Note that the resulting model is quantization aware but not quantized
# (e.g. the weights are float32 instead of int8).
# The sections after show how to create a quantized model from the quantization aware one.
def retrain(model, train_x, train_y):
    # 插入伪量化节点
    quantize_model = tfmot.quantization.keras.quantize_model
    # q_aware stands for for quantization aware.
    qat_model = quantize_model(model)
    qat_model.summary()
    # 在训练集子集上重新训练，进行微调
    train_x_subset = train_x[0:500]  # out of 3216
    train_y_subset = train_y[0:500]

    # quantize_model requires a recompile.
    optimizer = Adam(lr=params["learning_rate"])
    qat_model.compile(loss='categorical_crossentropy',
                      optimizer=optimizer,
                      metrics=['accuracy'])

    qat_model.fit(
        train_x_subset, train_y_subset,
        batch_size=250,
        epochs=1,
        verbose=1,  # 1 normal 0 hide log
        validation_split=0.1)
    return qat_model


def quantize(args, params):
    print("Loading training set...")
    train = load.load_dataset(params['train'])
    print("Loading dev set...")
    dev = load.load_dataset(params['dev'])
    print("Building preprocessor...")
    preproc = load.Preproc(*train)
    print("Training size: " + str(len(train[0])) + " examples.")
    print("Dev size: " + str(len(dev[0])) + " examples.")
    train_x, train_y = preproc.process(*train)
    train_x, train_y = load.data_shuffle(train_x, train_y, **params)
    dev_x, dev_y = preproc.process(*dev)

    # make 4 models' dirs
    FP32_model_path = make_model_dir()[0]
    BaseLine_model_path = make_model_dir()[1]
    PTQ_FULL_INT8_model_path = make_model_dir()[2]
    PTQ_WEIGHT_INT8_model_path = make_model_dir()[3]
    QAT_model_path = make_model_dir()[4]
    QAT_INT8_model_path = make_model_dir()[5]

    # evaluate FP32_model
    model = find_best_model('../Train/saved')
    model.save(FP32_model_path)
    _, hdf5_model_accuracy = model.evaluate(dev_x, dev_y, verbose=0)

    # args need in evaluate model function
    ecg_ds = tf.data.Dataset.from_tensor_slices((dev_x, dev_y)).batch(1)

    # ----------------------------------------------------------------------------
    # 0 Tensorflow Lite model baseline accuracy
    BaseLine_model = TFLite_converter(model, Quantize='None')
    # 保存量化的 tflite 模型
    open(BaseLine_model_path, "wb").write(BaseLine_model)
    # You evaluate the quantized model
    BaseLine_model_accuracy = TFLite_evaluate(BaseLine_model, ecg_ds)

    # convert to PTQ model
    # ----------------------------------------------------------------------------
    # 1 Full integer quantization of weights and activations
    PTQ_FULL_INT8_model = TFLite_converter(model, Quantize='weights and activations')
    # 保存量化的 tflite 模型
    open(PTQ_FULL_INT8_model_path, "wb").write(PTQ_FULL_INT8_model)
    # You evaluate the quantized model
    PTQ_FULL_INT8_model_accuracy = TFLite_evaluate(PTQ_FULL_INT8_model, ecg_ds)

    # ----------------------------------------------------------------------------
    # 2 Only quantization of weights
    PTQ_WEIGHT_INT8_model = TFLite_converter(model, Quantize='weights')
    # 保存量化的 tflite 模型
    open(PTQ_WEIGHT_INT8_model_path, "wb").write(PTQ_WEIGHT_INT8_model)
    # You evaluate the quantized model
    PTQ_WEIGHT_INT8_model_accuracy = TFLite_evaluate(PTQ_WEIGHT_INT8_model, ecg_ds)

    '''
    # ----------------------------------------------------------------------------
    # 3 Quantization aware training
    # make quantization aware and re-train
    QAT_model = retrain(model, train_x, train_y)
    _, QAT_model_accuracy = QAT_model.evaluate(dev_x, dev_y, verbose=0)
    # save QAT model
    QAT_model.save(QAT_model_path)
    # converter to tflite model
    QAT_INT8_model = TFLite_converter(QAT_model, full_integer=True)
    # 保存量化的 tflite 模型
    open(QAT_INT8_model_path, "wb").write(QAT_INT8_model)
    # You evaluate the quantized model
    QAT_INT8_model_accuracy = TFLite_evaluate(QAT_model, ecg_ds)
    '''

    print('                             FP32 hdf5模型准确率:', hdf5_model_accuracy)
    print('                           FP32 tflite模型准确率:', BaseLine_model_accuracy)
    print('             sweights INT8 训练后量化 模型准确度:', PTQ_WEIGHT_INT8_model_accuracy)
    print('weights & activations INT8 训练后量化 模型准确度:', PTQ_FULL_INT8_model_accuracy)
    # print('                    量化感知训练(未量化) 模型准确度:', QAT_model_accuracy)
    # print('                INT8量化后的量化感知训练模型准确度:', QAT_INT8_model_accuracy)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("config_file", help="path to config file")
    parser.add_argument("--experiment", "-e", help="tag with experiment name", default="default")
    args = parser.parse_args()
    params = json.load(open(args.config_file, 'r'))
    quantize(args, params)