import os
def Difference(filename_ori, filename_new):
    with open(filename_ori) as file1, open(filename_new) as file2:
        diff = set(file1).difference(file2)

    with open(filename_ori, 'r') as f1, open(filename_new, 'r') as f2:
        lines1 = f1.readlines()
        lines2 = f2.readlines()

    for i, (line1, line2) in enumerate(zip(lines1, lines2)):
        if line1 != line2:

            print(f"Line {i + 1} is different:")
            print(f"File 1: {line1}")
            print(f"File 2: {line2}")

    return diff


if __name__ == "__main__":
    folder_path = os.path.abspath(os.path.join(os.getcwd(),  "Compare"))
    for i in range(0,64):
        # diff = Difference(f'{folder_path}/Block2_Input_Binary_Com/B2_In_Channel_{i}_PY.txt', f'{folder_path}/Block2_Input_Binary_Com/B2_In_Channel_{i}.txt')
        # diff = Difference(f'{folder_path}/Block1_Output_Channel_Com/Output_Channel_{i}.txt',
        #                   f'{folder_path}/Block1_Output_Channel_Com/Output_channel_{i}_py.txt')
        # diff = Difference(f'{folder_path}/Block2_Slide_Data/B2_Slide_Data_{i}.txt',
        #                   f'{folder_path}/Block2_Slide_Data/B2_Slide_Data_{i}_Verilog.txt')
        diff = Difference(f'{folder_path}/Block6_Input_Binary/B6_In_Channel_{i}_Verilog.txt',
                          f'{folder_path}/Block6_Input_Binary/B6_Input_Binary_{i}_PY.txt')
        print(diff)

