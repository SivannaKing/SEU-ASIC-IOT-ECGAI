"""
Contains functions for training and testing a PyTorch model.
"""
import numpy as np
import torch
from matplotlib import pyplot as plt
from My_Basic_Net.utils.OP_XNOR_NET1 import  WeightOperation

from typing import Dict, List, Tuple
from torch.utils.tensorboard import SummaryWriter

# Create a writer with all default settings
writer = SummaryWriter()

train_losses = []
train_acces = []
eval_losses = []
eval_acces = []
results = {"train_loss": [],
           "train_acc": [],
           "test_loss": [],
           "test_acc": []
           }


def train_step(model: torch.nn.Module,
               dataloader: torch.utils.data.DataLoader,
               loss_fn: torch.nn.Module,
               optimizer: torch.optim.Optimizer,
               device: torch.device,
               weight_op) -> Tuple[float, float]:

    # Put model in train mode
    model.train()

    # Setup train loss and train accuracy values
    train_loss, train_acc = 0, 0
    correct, total = 0, 0
    # Loop through data loader data batches
    for batch, (X, y) in enumerate(dataloader):
        # Send data to target device
        X, y = X.to(device), y.to(device)

        weight_op.WeightSave()
        weight_op.WeightBinarize()

        # 1. Forward pass
        y_pred = model(X)

        # 2. Calculate  and accumulate loss
        loss = loss_fn(y_pred, y)
        train_loss += loss.item()


        # 3. Optimizer zero grad
        optimizer.zero_grad()

        # 4. Loss backward
        loss.backward()

        # 5. Optimizer step
        weight_op.WeightRestore()
        weight_op.WeightGradient()
        optimizer.step()

        # Calculate and accumulate accuracy metric across all batches
        _, predicted = torch.max(y_pred.data, dim=1)  # 取出预测的最大值
        correct += (predicted == y).sum().cpu().item()  # 判断预测是否正确
        total += len(y)

    train_loss = train_loss / len(dataloader)
    train_acc = correct / total
    train_losses.append(train_loss / len(dataloader))
    train_acces.append(correct / total)
    return train_loss, train_acc


def test_step(model: torch.nn.Module,
              dataloader: torch.utils.data.DataLoader,
              loss_fn: torch.nn.Module,
              device: torch.device,
              weight_op) -> Tuple[float, float]:

    # Put model in eval mode
    model.eval()

    # Setup test loss and test accuracy values
    test_loss, test_acc = 0, 0
    correct, total = 0, 0

    # Turn on inference context manager
    with torch.inference_mode():
        # Loop through DataLoader batches
        for batch, (X, y) in enumerate(dataloader):
            # Send data to target device
            X, y = X.to(device), y.to(device)

            # 1. Forward pass
            test_pred_logits = model(X)

            # 2. Calculate and accumulate loss
            loss = loss_fn(test_pred_logits, y)
            test_loss += loss.item()

            # Calculate and accumulate accuracy
            _, predicted = torch.max(test_pred_logits.data, dim=1)  # 输出概率最大的标签
            total += len(y)
            correct += (predicted == y).sum().cpu().item()  # 判断是否预测准确

    # Adjust metrics to get average loss and accuracy per batch
    test_loss = test_loss / len(dataloader)
    test_acc = correct / total
    eval_losses.append(test_loss / len(dataloader))
    eval_acces.append(correct / total)
    # plt.plot(np.arange(len(eval_losses)), eval_losses, label="test loss")
    # plt.plot(np.arange(len(eval_acces)), eval_acces, label="test acc")
    return test_loss, test_acc


def create_writer(experiment_name: str,
                  model_name: str,
                  extra: str = None) -> torch.utils.tensorboard.writer.SummaryWriter():

    from datetime import datetime
    import os

    # Get timestamp of current date (all experiments on certain day live in same folder)
    timestamp = datetime.now().strftime("%Y-%m-%d")  # returns current date in YYYY-MM-DD format

    if extra:
        # Create log directory path
        log_dir = os.path.join("runs", timestamp, experiment_name, model_name, extra)
    else:
        log_dir = os.path.join("runs", timestamp, experiment_name, model_name)

    print(f"[INFO] Created SummaryWriter, saving to: {log_dir}...")
    return SummaryWriter(log_dir=log_dir)

def train(model: torch.nn.Module,
          train_dataloader: torch.utils.data.DataLoader,
          test_dataloader: torch.utils.data.DataLoader,
          optimizer: torch.optim.Optimizer,
          loss_fn: torch.nn.Module,
          epochs: int,
          device: torch.device,
          # writer: torch.utils.tensorboard.writer.SummaryWriter,
          weight_op) -> Dict[str, List]:

    # Create empty results dictionary
    results = {"train_loss": [],
               "train_acc": [],
               "test_loss": [],
               "test_acc": []
               }

    # Make sure model on target device
    model.to(device)

    # lr_scheduler = torch.optim.lr_scheduler.CosineAnnealingLR(optimizer, T_max=epochs, eta_min=0.05, last_epoch=-1)
    # lr_scheduler = torch.optim.lr_scheduler.CosineAnnealingLR(optimizer, T_max=epochs, eta_min=0, last_epoch=-1)  # 0.000001

    # Loop through training and testing steps for a number of epochs
    for epoch in range(epochs):
        train_loss, train_acc = train_step(model=model,
                                           dataloader=train_dataloader,
                                           loss_fn=loss_fn,
                                           optimizer=optimizer,
                                           device=device,
                                           weight_op = weight_op)
        # lr_scheduler.step()
        # weight_op.Weightclamp()
        weight_op.WeightSave()
        weight_op.WeightBinarize()

        test_loss, test_acc = test_step(model=model,
                                        dataloader=test_dataloader,
                                        loss_fn=loss_fn,
                                        device=device,
                                        weight_op = weight_op)
        weight_op.WeightRestore()


        print(
            f"Epoch: {epoch + 1} | "
            f"train_loss: {train_loss:.4f} | "
            f"train_acc: {train_acc:.4f} | "
            f"test_loss: {test_loss:.4f} | "
            f"test_acc: {test_acc:.4f}"
        )

        results["train_loss"].append(train_loss)
        results["train_acc"].append(train_acc)
        results["test_loss"].append(test_loss)
        results["test_acc"].append(test_acc)
    weight_op.WeightBinarize()
    print(model.state_dict())
    # # 绘制 loss 和 accuracy 图像
    # x = np.arange(1, epochs + 1)
    # fig, ax = plt.subplots(figsize=(10, 5))
    # ax.plot(x, results['train_loss'], color='red', label='Train Loss')
    # ax.plot(x, results['test_loss'], color='blue', label='Test Loss')
    # # plt.subplot(1, 2, 2)
    # ax.plot(x, results['train_acc'], color='green', label='Train Accuracy')
    # ax.plot(x, results['test_acc'], color='purple', label='Test Accuracy')
    # ax.set_title('Training and Testing Metrics')
    # ax.set_xlabel('Epoch')
    # ax.set_ylabel('Metrics')
    # ax.legend(loc='best')
    # plt.show()
    plt.figure(figsize=(10, 5))
    plt.subplot(1, 2, 1)
    plt.plot(np.arange(len(train_losses)), train_losses, label="train loss")
    plt.plot(np.arange(len(eval_losses)), eval_losses, label="test loss")
    plt.legend()
    plt.xlabel('epochs')
    plt.ylabel('loss')
    plt.title('Model loss')

    plt.subplot(1, 2, 2)
    plt.plot(np.arange(len(train_acces)), train_acces, label="train acc")
    plt.plot(np.arange(len(eval_acces)), eval_acces, label="test acc")
    plt.legend()
    plt.xlabel('epochs')
    plt.ylabel('accuracy')
    plt.title('Model accuracy')


    return results
