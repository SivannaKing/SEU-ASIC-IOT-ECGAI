from keras.optimizers import Adam
from keras.models import Model
from keras.layers import Conv1D, MaxPooling1D, GlobalAveragePooling1D
from keras.layers import Dense, Flatten, Dropout, Input,  ReLU

'''
def build_new_network(inputs):

    # block 1
    layer = Conv1D(8, 16, strides=2, padding='valid', use_bias=False, name='conv1')(inputs)
    layer = ReLU(max_value=2, name='act1')(layer)
    layer = MaxPooling1D(pool_size=7, strides=2, name='mp1')(layer)

    # block 2
    layer = Conv1D(16, 12, strides=2, padding='valid', use_bias=False, name='conv2')(layer)
    layer = ReLU(max_value=2, name='act2')(layer)
    layer = MaxPooling1D(pool_size=4, strides=2, name='mp2')(layer)

    # block 3
    layer = Conv1D(32, 8, strides=1, padding='valid', use_bias=False, name='conv3')(layer)
    layer = ReLU(max_value=1, name='act3')(layer)
    layer = MaxPooling1D(pool_size=4, strides=2, name='mp3')(layer)

    # block 4
    layer = Conv1D(64, 8, strides=1, padding='valid', use_bias=False, name='conv4')(layer)
    layer = ReLU(max_value=1, name='act4')(layer)
    layer = MaxPooling1D(pool_size=4, strides=2, name='mp4')(layer)

    # block 5
    layer = Conv1D(64, 4, strides=1, padding='valid', use_bias=False, name='conv5')(layer)
    layer = ReLU(max_value=1, name='act5')(layer)
    layer = MaxPooling1D(pool_size=2, strides=2, name='mp5')(layer)

    # block 6
    layer = Conv1D(72, 3, strides=1, padding='valid', use_bias=False, name='conv6')(layer)
    layer = ReLU(max_value=1, name='act6')(layer)
    layer = MaxPooling1D(pool_size=2, strides=2, name='mp6')(layer)

    # block 7
    # layer = Conv1D(72, 3, strides=1, padding='same', use_bias=False, name='conv7')(layer)
    # layer = ReLU(max_value=1, name='act7')(layer)
    # layer = MaxPooling1D(pool_size=2, strides=2, name='maxp7')(layer)

    return layer
'''

def build_new_network(inputs):

    # block 1
    layer = Conv1D(8, 16, strides=2, padding='same', use_bias=False, name='conv1')(inputs)
    layer = ReLU(max_value=2, name='act1')(layer)
    layer = MaxPooling1D(pool_size=8, strides=2, name='mp1')(layer)

    # block 2
    layer = Conv1D(12, 11, strides=2, padding='same', use_bias=False, name='conv2')(layer)
    layer = ReLU(max_value=2, name='act2')(layer)
    layer = MaxPooling1D(pool_size=4, strides=2, name='mp2')(layer)

    # block 3
    layer = Conv1D(32, 9, strides=1, padding='same', use_bias=False, name='conv3')(layer)
    layer = ReLU(max_value=1, name='act3')(layer)
    layer = MaxPooling1D(pool_size=4, strides=2, name='mp3')(layer)

    # block 4
    layer = Conv1D(64, 7, strides=1, padding='same', use_bias=False, name='conv4')(layer)
    layer = ReLU(max_value=1, name='act4')(layer)
    layer = MaxPooling1D(pool_size=4, strides=2, name='mp4')(layer)

    # block 5
    layer = Conv1D(64, 5, strides=1, padding='same', use_bias=False, name='conv5')(layer)
    layer = ReLU(max_value=1, name='act5')(layer)
    layer = MaxPooling1D(pool_size=2, strides=2, name='mp5')(layer)

    # block 6
    layer = Conv1D(72, 3, strides=1, padding='same', use_bias=False, name='conv6')(layer)
    layer = ReLU(max_value=1, name='act6')(layer)
    layer = MaxPooling1D(pool_size=2, strides=2, name='mp6')(layer)

    # block 7
    # layer = Conv1D(72, 3, strides=1, padding='same', use_bias=False, name='conv7')(layer)
    # layer = ReLU(max_value=1, name='act7')(layer)
    # layer = MaxPooling1D(pool_size=2, strides=2, name='maxp7')(layer)

    return layer

def add_fc_layers(layer, **params):
    # layer = Flatten(name='flatten')(layer)
    layer = Dropout(0.6, name='Dropout1')(layer)
    # layer = Dense(params["hidden_node"], name='Den1')(layer)
    # layer = ReLU(max_value=2, name='act8')(layer)

    layer = GlobalAveragePooling1D(name='GAP')(layer)

    if params.get("dropout", 0.1):
        layer = Dropout(params["dropout"], name='Dropout2')(layer)

    layer = Dense(params["num_categories"], activation='softmax', name='Den2')(layer)

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
