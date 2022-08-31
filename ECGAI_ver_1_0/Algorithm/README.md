##文件结构
    - MLII                              分割后的数据
        - - 1 NSR
        - - 2 APB
        
        ...
        
        - - 17 PR
        
    - model
        - - 957_1.hdf5                  未量化的权重1
        - - 957_2.hdf5                  未量化的权重2
        - - q_957_1_8.hdf5              量化为8bit的权重1
        - - q_957_2_8.hdf5              量化为8bit的权重2
        
    - train
        - - load.py                     载入数据
        - - util.py                     生成保存数据的文件夹
        - - data_build.py               生成dev_32.json和train_32.json文件
        - - network.py                  网络结构
        - - train.py                    训练网络
        - - config.json                 网络配置文件
        - - dev_32.json                 测试数据位置目录
        - - train_32.json               训练数据位置目录
        
    - quantizaiton
        - - config.json                 网络配置文件
        - - dev_32.json                 测试数据位置目录
        - - train_32.json               训练数据位置目录
        - - load.py                     载入数据
        - - network.py                  网络结构
        - - keras_turnto_qkeras.py      将keras模型转为qkeras模型
        - - layer_ranking.py            网络层排序
        - - layer_wise_quantizaiton.py  分层量化
        - - test_qmodel.py              测试分层量化后网络的精度
        
    - qkeras.zip                        qkeras安装包

## Be modified by wzx

    - train

	- - train.py
		new function	        layers_outputs & its packages
		26 78	                val_acc -> val_accuracy
		106 func train new      model.save 

	- - data_build.py
		55 change		data_dir = "./MLII" -> data_dir = "../MLII"

	- - config.json
		new

        - - dev_32.json
		new

	- - network.py
		change_activation       relu -> ReLU(max_value = ...)
		new			layer_name	

    
    - plot_layer_output.py

	new				to plt density of layer_outputs


	











