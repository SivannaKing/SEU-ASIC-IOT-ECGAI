import torch

pth = r'E:\ecg pytorch\train_V2\q_0.944_930.pth'
sta_dic = torch.load(pth)
print('.pth type:', type(sta_dic))
print('.pth len:', len(sta_dic))
print('--------------------------')
for k in sta_dic.keys():
    print(k, type(sta_dic[k]), sta_dic[k].shape)

print(sta_dic['conv1.weight'])
