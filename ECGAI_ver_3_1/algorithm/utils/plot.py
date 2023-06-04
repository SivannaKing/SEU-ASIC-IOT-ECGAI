import torch
import copy
import itertools
import numpy as np
import torch.nn as nn
import matplotlib.pyplot as plt
from prettytable import PrettyTable
def plot_confusion_matrix(cm, classes, cmap, normalize=False, title='Confusion matrix'):
	cm_nor = cm.astype('float') / cm.sum(axis=0)# 将每列的元素都除以该列的样本总数
	# cm_nor = cm.astype('float')
	sum_TP = 0
	for i in range(len(classes)):
		sum_TP += cm[i, i]
	acc = sum_TP / np.sum(cm)
	print("the model accuracy is ", acc)

	table = PrettyTable()
	table.field_names = ["", "ACC", "SEN", "SPE", "PPR", "F1"]
	TP_SUM, FP_SUM, FN_SUM, TN_SUM = 0, 0, 0, 0
	for i in range(len(classes)):
		TP = cm[i, i]
		FP = np.sum(cm[i, :]) - TP
		FN = np.sum(cm[:, i]) - TP
		TN = np.sum(cm) - TP - FP - FN
		TP_SUM += TP
		FP_SUM += FP
		FN_SUM += FN
		TN_SUM += TN

		ACC = round((TP + TN) / (TP + FP + TN + FN), 3) if TP + FP + TN + FN != 0 else 0.
		SEN = round(TP / (TP + FN), 3) if TP + FN != 0 else 0.
		SPE = round(TN / (TN + FP), 3) if TN + FP != 0 else 0.
		PPR = round(TP / (TP + FP), 3) if TP + FP != 0 else 0.
		F1 = round(2 * TP / (2 * TP + FP + FN), 3) if TP + FP != 0 else 0.
		table.add_row([classes[i], ACC, SEN, SPE, PPR, F1])
	ACC_SUM = round((TP_SUM + TN_SUM) / (TP_SUM + FP_SUM + TN_SUM + FN_SUM),
					3) if TP_SUM + FP_SUM + TN_SUM + FN_SUM != 0 else 0.
	SEN_SUM = round(TP_SUM / (TP_SUM + FN_SUM), 3) if TP_SUM + FN_SUM != 0 else 0.
	SPE_SUM = round(TN_SUM / (TN_SUM + FP_SUM), 3) if TN_SUM + FP_SUM != 0 else 0.
	PPR_SUM = round(TP_SUM / (TP_SUM + FP_SUM), 3) if TP_SUM + FP_SUM != 0 else 0.
	F1_SUM = round(2 * TP_SUM / (2 * TP_SUM + FP_SUM + FN_SUM), 3) if TP_SUM + FP_SUM != 0 else 0.
	table.add_row(['SUM', ACC_SUM, SEN_SUM, SPE_SUM, PPR_SUM, F1_SUM])
	print(table)
	plt.imshow(cm_nor, interpolation='nearest', cmap=cmap)
	plt.title(title)
	plt.colorbar(fraction=0.046, pad=0.05)
	tick_marks = np.arange(len(classes))
	plt.xticks(tick_marks, classes, rotation=45)
	plt.yticks(tick_marks, classes)
	thresh = cm_nor.max() / 2.
	length = len(classes)
	if length == 5:
		fontsize = 13
	elif length == 17:
		fontsize = 6
	for i, j in itertools.product(range(cm_nor.shape[0]), range(cm_nor.shape[1])):
		plt.text(j, i, format(cm_nor[i, j], '.2f'), horizontalalignment="center",
				 color="white" if cm_nor[i, j] > thresh else "black", fontsize=fontsize)
	plt.tight_layout()
	plt.ylabel('Predicted Labels', fontsize=fontsize)
	plt.xlabel('True Labels', fontsize=fontsize)


def confusion_matrix(preds, labels, conf_matrix):
	for p, t in zip(preds, labels):
		conf_matrix[p, t] += 1

	return conf_matrix


def plot_cfm(model, test_loader, classes, mode, cnt, clt):
	length = len(classes)
	conf_matrix = torch.zeros(length, length)
	acc_val = 0
	model.eval()
	total = 0
	correct = 0
	for data in test_loader:
		images, labels = data
		total += len(labels)
		out = model(images)
		prediction = torch.max(out, 1)[1]
		conf_matrix = confusion_matrix(
			prediction, labels=labels, conf_matrix=conf_matrix)
		correct += (prediction == labels).sum().item()
	acc_val = 100 * correct / total

	attack_types = classes
	plt.tight_layout()
	plt.figure(figsize=(6, 6))
	plt.rcParams['font.sans-serif'] = ['Times New Roman']
	plot_confusion_matrix(
		conf_matrix.numpy(), classes=attack_types, cmap=plt.cm.Blues, normalize=True)
	plt.title('Normalized confusion matrix, with OA=%.2f' % (acc_val), fontsize=13)
	plt.savefig(fname="./picture/%s,Confusion-matrix,%d,%d.pdf" % (mode, cnt, clt), format="pdf", bbox_inches='tight')
