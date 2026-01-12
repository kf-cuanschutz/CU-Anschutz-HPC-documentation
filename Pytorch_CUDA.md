Installing Pytorch compatible with NVIDIA GPUs on Alpine:
=========================================================

This short tutorial will guide you through installing Pytorch on Alpine compatible with the NVIDIA A100 and L40 chips.

## Pytorch installation steps.

1) After you log into the Alpine cluster, please load the slurm modules and request allocation so that you can install the packages:

```bash
module load slurm/alpine 
acompile --ntasks=4 --time=02:00:00
```

2) Load anaconda, create your environment with python 3.11 and activate it.

```bash
module load miniforge
conda create -n pytorch_env python=3.11 
conda activate pytorch_env
```
3) Install torch and torchvision as shown below. Please refer to this [table](https://pytorch.org/get-started/locally/) for more details.

```bash
pip3 install torch torchvision
```

4) To test that your installation is working you will need to exit "acompile"  first and load on the NVIDIA gpu debug partition on Alpine"

```bash
conda deactivate
exit
sinteractive --partition=atesting_a100 --qos=testing --time=00:05:00 --gres=gpu:1 --ntasks=4 --nodes=1
module load miniforge
conda activate pytorch_env
python
```

7) Finally, run the following:

```python
>>>import torch
>>>print(torch.cuda.is_available())
True
```

8) Make sure to exit the GPU debug node partition after testing the installation.
   
```bash
$ exit
exit
```







