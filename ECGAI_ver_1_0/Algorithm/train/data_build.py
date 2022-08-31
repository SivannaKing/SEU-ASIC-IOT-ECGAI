import os
import json
import random
from sklearn.model_selection import train_test_split


def load_dataset(data_path, args, split_ratio=0.3):
    count = 0
    seed = 32
    labels = []
    tr_samps = []
    te_samps = []
    for root, dirs, files in os.walk(data_path, topdown=False):
        if len(files) == 0:
            continue
        label = root.split("/")[-1]
        count += 1
        print(count)
        samps = [os.path.abspath(os.path.join(root, i)) for i in files]
        tr_samp, te_samp = train_test_split(samps, test_size=split_ratio, random_state=seed)
        labels.append(label)
        tr_samps.append(tr_samp)
        te_samps.append(te_samp)

    max_len = 0
    for index, item in enumerate(labels):
        # data[item] = [tr_samps[index], te_samps[index]]
        if len(tr_samps[index]) > max_len:
            max_len = len(tr_samps[index])

    for index, i in enumerate(tr_samps):
        repeat = max_len // len(i)
        tr_samps[index] = i*repeat
        print("{}: before_num:{}, after_num:{}".format(labels[index], len(i), len(tr_samps[index])))

    return labels, tr_samps, te_samps, seed


def make_json(save_path, label, train):
    with open(save_path, 'w') as fid:
        for index, d in enumerate(label):
            for item in train[index]:
                datum = {'label': d,
                         'samp_dir': item}
                json.dump(datum, fid)
                fid.write('\n')


if __name__ == "__main__":
    # parser = argparse.ArgumentParser()
    # parser.add_argument("class", default=17, type=int, choices=[13, 15, 17], help="number of class")
    # args = parser.parse_args()
    random.seed(2018)
    split_ratio = 0.3
    data_dir = "../MLII"
    label, train, test, seed = load_dataset(data_dir, split_ratio)
    make_json("train_{}.json".format(seed), label, train)
    make_json("dev_{}.json".format(seed), label, test)
