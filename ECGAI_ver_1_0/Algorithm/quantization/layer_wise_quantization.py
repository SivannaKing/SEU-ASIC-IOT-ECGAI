from __future__ import print_function
from __future__ import division
from __future__ import absolute_import


import os
import json
import argparse
from qkeras import *
from keras.models import load_model
import layer_ranking
import test_qmodel
import load
import warnings
import csv


warnings.filterwarnings("ignore")
os.environ["TF_CPP_MIN_LOG_LEVEL"] = "3"


def save_qmodel(model, root_dir, dirs, quant_num):
    save_dir = os.path.join(root_dir, dirs)
    file_dir = os.path.join(save_dir, "{}_bit.h5".format(quant_num))
    if not os.path.exists(root_dir):
        os.makedirs(root_dir)
    if not os.path.exists(save_dir):
        os.makedirs(save_dir)
    model_save_quantized_weights(model, file_dir)
    print("The Model is Saved in {}, Quantized Layer is {}, Quantized Bit is {}".format(file_dir, dirs, quant_num))

    return file_dir


def quant(args, params):

    csvFile = open("result.csv", "w")
    writer = csv.writer(csvFile)
    writer.writerow(["Layer_name", "7_bit", "6_bit", "5_bit", "4_bit", "3_bit", "2_bit", "binary"])
    layerwise_strategy = {}
    model = load_model(params["model_dir"])
    model.summary()
    rank, score, maximum, energy = layer_ranking.ranking(params)

    q_dictionary = {}  # create_key.create_qdict(params)
    # print(q_dictionary)

    # data preprocessing
    print("Loading training set...")
    train = load.load_dataset(params['train'])
    print("Loading dev set...")
    dev = load.load_dataset(params['dev'])
    print("Building preprocessor...")
    preproc = load.Preproc(*train)
    dev_x, dev_y = preproc.process(*dev)
    train_x, train_y = preproc.process(*train)
    print("Training size: " + str(len(train[0])) + " examples.")
    print("Dev size: " + str(len(dev[0])) + " examples.")

    for index, layer in enumerate(rank):
        print(100 * "-")
        print("{} Quantization".format(layer))
        print(100 * "-")
        default = {}
        total_dev_score = [layer]
        total_train_score = [layer]
        for quant_num in range(7, 0, -1):
            q_dictionary[layer] = {
                "kernel_quantizer": "quantized_bits({},0,1, {})".format(quant_num, maximum[index]),
                "bias_quantizer": "quantized_bits({},0,1,1)".format(quant_num)
            }

            qmodel, _ = model_quantize(model, q_dictionary, 8, transfer_weights=True)

            # Save Quantized Model
            qmodel_dir = save_qmodel(qmodel, args.save_dir, layer, quant_num)
            params.update({"qmodel_dir": qmodel_dir})

            # Validating Quantized Model
            dev_loss, dev_score = test_qmodel.train(dev_x, dev_y, params)
            train_loss, train_score = test_qmodel.train(train_x, train_y, params)
            total_dev_score.append(dev_score)
            total_train_score.append(train_score)

            default[qmodel_dir] = dev_score - params["score_ratio"]*energy[index]*quant_num
            print("Evaluation score is {}, Traning socre is {}".format(dev_score, train_score))
            print(100*"_")

        # Selecting Standard for Saving Which Quantized Model
        default = sorted(default.items(), key=lambda x: (-x[1], x[0]), reverse=False)
        print(default, '\n')
        params.update({"qmodel_dir": default[0][0]})

        layerwise_strategy[layer] = int((default[0][0]).split('/')[-1][0])
        print("Layer Strategy is: {}".format(layerwise_strategy))

        # Saving Decided Layers' Quantization Strategy
        q_dictionary[layer] = {
            "kernel_quantizer": "quantized_bits({},0,1, {})".format(int((default[0][0]).split('/')[-1][0]),
                                                                    maximum[index]),
            "bias_quantizer": "quantized_bits({},0,1,1)".format(int((default[0][0]).split('/')[-1][0]))
        }

        model = load_model(params["model_dir"])
        print(100*"_")
        writer.writerow(total_dev_score)
        writer.writerow(total_train_score)
    print("Qunatization dictionary is: ", q_dictionary)
    csvFile.close()


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("config_file", help="path to config file", default="./config.json")
    parser.add_argument("--save_dir", help="path to save qmodel", default="./qmodel_ur_957_1")
    args = parser.parse_args()
    params = json.load(open(args.config_file, "r"))
    quant(args, params)
