from keras.optimizers import Adam
from keras.models import Model
from keras.layers import Conv1D, MaxPooling1D, BatchNormalization
from keras.layers import Dense, Flatten, Dropout, Input


def build_new_network(inputs):

    # block 1
    layer = Conv1D(8, 16, strides=2, padding='same', activation='relu', use_bias=True)(inputs)
    layer = MaxPooling1D(pool_size=8, strides=4)(layer)

    # block 2_plus
    layer = Conv1D(12, 12, strides=2, padding='same', activation='relu')(layer)
    layer = MaxPooling1D(pool_size=4, strides=2)(layer)
    # block 2
    layer = Conv1D(32, 9, strides=1, padding='same', activation='relu')(layer)
    layer = MaxPooling1D(pool_size=4, strides=2)(layer)
    # block 3
    layer = Conv1D(64, 7, strides=1, padding='same', activation='relu')(layer)
    layer = MaxPooling1D(pool_size=4, strides=2)(layer)
    # block4
    layer = Conv1D(64, 5, strides=1, padding='same', activation='relu')(layer)
    layer = MaxPooling1D(pool_size=2, strides=2)(layer)
    # block5
    layer = Conv1D(64, 3, strides=1, padding='same', activation='relu')(layer)
    layer = MaxPooling1D(pool_size=2, strides=2)(layer)
    # block6
    layer = Conv1D(72, 3, strides=1, padding='same', activation='relu')(layer)
    layer = MaxPooling1D(pool_size=2, strides=2)(layer)

    return layer


def add_fc_layers(layer, **params):
    layer = Flatten()(layer)
    layer = Dropout(0.6)(layer)
    layer = Dense(params["hidden_node"], activation='relu')(layer)
    if params.get("dropout", 0.1):
        layer = Dropout(params["dropout"])(layer)
    layer = Dense(params["num_categories"], activation='softmax')(layer)
    return layer


def add_compile(model, **params):
    optimizer = Adam(lr=params["learning_rate"])
    model.compile(loss='categorical_crossentropy',
                  optimizer=optimizer,
                  metrics=['accuracy'])


def build_network(**params):
    inputs = Input(shape=params['input_shape'],
                   dtype='float32',
                   name='inputs')
    layer = build_new_network(inputs)
    output = add_fc_layers(layer, **params)

    model = Model(inputs=[inputs], outputs=[output])
    add_compile(model, **params)
    return model
