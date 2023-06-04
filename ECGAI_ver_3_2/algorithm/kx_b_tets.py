import torch
import os
# def convert_to_14bit_signed_integers(tensor, filename):
#     # Convert tensor to 14-bit signed integers
#     tensor = tensor.clamp(-2**13, 2**13-1).int()
#     # Convert tensor to bytes
#     bytes_tensor = tensor.numpy().tobytes()
#     # Convert bytes to binary string
#     binary_string = ''.join(format(byte, '014b') for byte in bytes_tensor)
#     # Write binary string to file
#     with open(filename, 'w') as f:
#         f.write(binary_string)

def int_to_signed_bit(n, num_of_bits):
    if n < -2 ** (num_of_bits - 1) or n > (2 ** (num_of_bits - 1) - 1):
        raise ValueError("Integer out of range")
    if n < 0:
        # Two's complement of negative number
        binary = bin((1 << num_of_bits) + n)[2:]
    else:
        binary = bin(n)[2:].zfill(num_of_bits)
    return binary


def tensor_to_signed_bits_file(tensor, filename, num_ot_bits):
    with open(filename, 'w') as file:
        for n1 in tensor.to(torch.int16).tolist():
            binary_1 = int_to_signed_bit(n1, num_of_bits=num_ot_bits)
            file.write(binary_1+'\n')


threhold_path = os.path.abspath(os.path.join(os.getcwd(), "Data", "9160", "k_ak_b"))
a = torch.tensor([399., 711., 651., 671., 1066., 142., 253., 231., 238.,
                                                              379., 2672., 2937., -1557., -8191., -7765.])

tensor_to_signed_bits_file(a, filename=f'{threhold_path}/k_ak_b.txt', num_ot_bits=14)
# convert_to_14bit_signed_integers(a, filename=f'{threhold_path}/k_ak_b_1.txt')