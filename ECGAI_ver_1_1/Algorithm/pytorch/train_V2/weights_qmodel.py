import network
import torch
import numpy as np
from collections import Counter
import pandas as pd

model = network.build_network()
model.load_state_dict(torch.load('./q_0.938_466_BWN.pth'))

parameters = model.parameters()

a = 0
temp = np.zeros((80576,))

for p in parameters:
    numpy_para = p.detach().cpu().numpy()

    numpy_para = np.array(numpy_para).flatten()

    temp[a:(a+numpy_para.shape[0]),] = numpy_para

    a += numpy_para.shape[0]

d = Counter(temp)

df = pd.DataFrame.from_dict(d, orient='index').reset_index()


print(df)

df.to_csv("test.csv",index=False,sep=',')

parm={}
for name,parameters in model.named_parameters():
    print(name,':',parameters.size())
    parm[name]=parameters.detach().numpy()

print(parm)

