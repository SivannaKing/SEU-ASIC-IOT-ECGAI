import os

# def txt_to_coe(txt_file_path):
#     # with open(txt_file_path, 'r') as f:
#     #     bits = f.read().replace('\n', '').replace('_', '')
#     # coe_str = "memory_initialization_radix=2;\nmemory_initialization_vector=\n"
#     # for i in range(0, len(bits), len(bits) // 2):
#     #     coe_str += bits[i:i+len(bits) // 2] + ",\n"
#     with open(txt_file_path, 'r') as f:
#         lines = f.readlines()
#     with open(txt_file_path, 'w') as f:
#         # 写入coe文件头部
#         f.write('memory_initialization_radix=2;\n')
#         f.write('memory_initialization_vector=\n')
#
#         # 逐行处理数据并写入coe文件
#         for line in lines:
#             # 去除行尾换行符和空格
#             line = line.strip()
#
#             # 将每个字符写入coe文件
#             for c in line:
#                 f.write(c)
#                 f.write(',')
#
#         # 写入coe文件结尾
#         f.write(';')
#     return
#
#
#
#
#
# def convert_txt_to_coe(txt_dir_path, coe_dir_path):
#     for file_name in os.listdir(txt_dir_path):
#         if file_name.endswith(".txt"):
#             txt_file_path = os.path.join(txt_dir_path, file_name)
#             coe_file_path = os.path.join(coe_dir_path, file_name[:-4] + ".coe")
#             with open(coe_file_path, 'w') as f:
#                 txt_to_coe(txt_file_path)
#
# txt_dir_path = "/home/mrpp/my_work/ECG/ECG_BNN_IPcore_verison/Data/Threhold"
# coe_dir_path = "/home/mrpp/my_work/ECG/ECG_BNN_IPcore_verison/Data/Threhold_COE"
# convert_txt_to_coe(txt_dir_path, coe_dir_path)
# import os

def txt_to_coe(input_folder, output_folder):
    for filename in os.listdir(input_folder):
        if filename.endswith(".txt"):
            with open(os.path.join(input_folder, filename), "r") as txt_file:
                data = txt_file.read()
                data = data.replace("_", "")
                data = data.replace("\n", "")
                coe_filename = filename.replace(".txt", ".coe")
                with open(os.path.join(output_folder, coe_filename), "w") as coe_file:
                    coe_file.write("memory_initialization_radix=2;\nmemory_initialization_vector=\n")
                    for i in range(0, len(data), 28):
                        coe_file.write(data[i:i+28] + ",\n")
                    coe_file.write(";")

input_folder = "/home/mrpp/my_work/ECG/ECG_BNN_IPcore_verison/Data/Weight"
output_folder = "/home/mrpp/my_work/docker_test"
txt_to_coe(input_folder, output_folder)
