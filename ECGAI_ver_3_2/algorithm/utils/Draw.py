import torch
import copy
import itertools
import numpy as np
import torch.nn as nn
import matplotlib.pyplot as plt

from torch.optim import Adam
from mpl_toolkits import mplot3d
from prettytable import PrettyTable
from scipy.interpolate import make_interp_spline


# import loss_landscapes
# import loss_landscapes.metrics


def plot_confusion_matrix(cm, classes, cmap, normalize=False, title='Confusion matrix'):
	cm_nor = cm.astype('float') / cm.sum(axis=0)
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
	plt.title('Normalized confusion matrix, with Acc=%.2f' % (100*acc), fontsize=13)

def confusion_matrix(preds, labels, conf_matrix):
	for p, t in zip(preds, labels):
		conf_matrix[p, t] += 1

	return conf_matrix


def plot_cfm(model, test_loader, classes, mode, cnt, clt, seed, best_test_acc):
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
	print(acc_val)
	attack_types = classes
	plt.tight_layout()
	plt.figure(figsize=(6, 6))
	plt.rcParams['font.sans-serif'] = ['Times New Roman']
	plot_confusion_matrix(
		conf_matrix.numpy(), classes=attack_types, cmap=plt.cm.Blues, normalize=True)

	plt.savefig(fname="./image_for_17/%s,Confusion-matrix,%d,%d,%d,%.4f.pdf" % (mode, cnt, clt, seed, best_test_acc), format="pdf", bbox_inches='tight')


def plot_loss_acc(acc_list, loss_list, mode, cnt, clt):
	fig = plt.figure()
	x = np.arange(1, len(acc_list) + 1)
	a1 = fig.add_axes([0, 0, 1, 1])
	a1.plot(x, acc_list, 'tab:blue', label='acc')
	a1.set_ylabel('acc')
	a2 = a1.twinx()
	a2.plot(x, loss_list, 'tab:orange', label='loss')
	a2.set_ylabel('loss')
	plt.title('acc & loss')
	a1.set_xlabel('Epoch')
	a1.legend()
	a2.legend()
	plt.savefig(fname="../image/%s,Acc-Loss,%d,%d.pdf" % (mode, cnt, clt), format="pdf", bbox_inches='tight')
	plt.show()

# class Landscape():
# 	def __init__(self, mode, model_ini, model_fin, train_loader, lr=0.001, step=40):
# 		self.mode = mode
# 		self.model_ini = copy.deepcopy(model_ini)
# 		self.model_fin = copy.deepcopy(model_fin)
# 		self.train_loader = train_loader
# 		self.optimizer = Adam(model_ini.parameters(), lr=lr)
# 		self.criterion = nn.CrossEntropyLoss()
# 		self.step = step
# 		self.x, self.y = iter(train_loader).__next__()
# 		self.metric = loss_landscapes.metrics.Loss(self.criterion, self.x, self.y)
# 		self.loss_data_1d = loss_landscapes.linear_interpolation(
# 			model_ini, model_fin, self.metric, self.step, deepcopy_model=True)
# 		self.loss_data_23d = loss_landscapes.random_plane(
# 			self.model_fin, self.metric, 10, self.step, normalization='filter', deepcopy_model=True)
#
# 	def draw(self):
# 		if self.mode == 1:
# 			x = np.linspace(0, 1, self.step)
# 			x_smooth = np.linspace(x.min(), x.max(), 1000)
# 			y_smooth = make_interp_spline(x, self.loss_data_1d)(x_smooth)
# 			plt.plot(x_smooth, y_smooth)
# 			plt.xlabel('Interpolation Coefficient')
# 			plt.ylabel('Loss')
# 			axes = plt.gca()
# 			plt.show()
# 			return self.loss_data_1d
# 		elif self.mode == 2:
# 			plt.contour(self.loss_data_23d, levels=50, cmap=plt.cm.viridis)
# 			plt.title('Loss Contours around Trained Model')
# 			plt.show()
# 			return self.loss_data_23d
# 		else:
# 			ax = plt.axes(projection='3d')
# 			X = np.array([[j for j in range(self.step)] for i in range(self.step)])
# 			Y = np.array([[i for _ in range(self.step)] for i in range(self.step)])
# 			ax.plot_surface(X, Y, self.loss_data_23d, rstride=1, cstride=1, cmap=plt.cm.Spectral_r)
# 			plt.axis('off')
# 			plt.show()
# 			plt.savefig(fname="../image/landscape.pdf", format="pdf", bbox_inches='tight')
# 			return self.loss_data_23d
