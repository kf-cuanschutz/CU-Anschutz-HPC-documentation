Installing Pytorch compatible with NVIDIA GPUs on Alpine:
=========================================================

This short tutorial will guide you through installing Pytorch on Alpine compatible with NVIDIA A100 acceleration.

## Pytorch installation steps.

1) After you log into the Alpine cluster, please load the slurm modules and request allocation so that you can install the packages:

```bash
module load slurm/alpine 
acompile --ntasks=4 
```

2) Load anaconda, create your environment with python 3.10 and activate it.

```bash
module load anaconda
conda create -n pytorch_env python=3.10 
conda activate pytorch_env
```
3) Install pytorch, pytorch-cuda. You could also install torchvision and torchaudio if needed for your workflow.

```bash
conda install pytorch==2.0.0 torchvision==0.15.0 torchaudio==2.0.0 pytorch-cuda=11.8 -c pytorch -c nvidia 
```

4) Install cuda-toolkit 11.8.0

```bash
conda install -c "nvidia/label/cuda-11.8.0" cuda-toolkit 
```

5) Install nvidia-cudnn

```bash
pip install nvidia-cudnn-cu11==8.6.0.163 
```

6) To test that your installation is working you will need to exit "acompile"  first and load on the NVIDIA gpu debug partition on Alpine"

```bash
conda deactivate
exit
sinteractive --partition=atesting_a100 --qos=testing --time=1:00:00 --gres=gpu:1 --ntasks=2
module load anaconda
conda activate pytorch_env
python
```

7) Finally, run the following:

```python
>>>import torch
>>>print(torch.cuda.is_available())
True
```






