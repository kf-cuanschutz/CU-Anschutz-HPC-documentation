Installing DeepLabCut compatible with NVIDIA GPUs on Alpine:
============================================================

This short tutorial will guide you through installing DeepLabcut on Alpine compatible with NVIDIA A100 acceleration.

## References

According to the DeepLabCut [page](https://github.com/DeepLabCut/DeepLabCut), DeepLabCut is a toolbox for state-of-the-art 
markerless pose estimation of animals performing various behaviors. As long as you can see (label) what you want to track, 
you can use this toolbox, as it is animal and object agnostic.

For citation, If you use code or data related to DeepLabCut it is kindly asked that you please [cite Mathis et al, 2018](https://www.nature.com/articles/s41593-018-0209-y) 
and, if you use the Python package (DeepLabCut2.x) please also cite [Nath, Mathis et al, 2019](https://doi.org/10.1038/s41596-019-0176-0). 
If you utilize the MobileNetV2s or EfficientNets please cite [Mathis, Biasi et al. 2021](https://openaccess.thecvf.com/content/WACV2021/papers/Mathis_Pretraining_Boosts_Out-of-Domain_Robustness_for_Pose_Estimation_WACV_2021_paper.pdf). 
If you use versions 2.2beta+ or 2.2rc1+, please cite [Lauer et al. 2022](https://www.nature.com/articles/s41592-022-01443-0).

DOIs (#ProTip, for helping you find citations for software, check out [CiteAs.org](http://citeas.org/)!):

- Mathis et al 2018: [10.1038/s41593-018-0209-y](https://doi.org/10.1038/s41593-018-0209-y)
- Nath, Mathis et al 2019: [10.1038/s41596-019-0176-0](https://doi.org/10.1038/s41596-019-0176-0)
- Lauer et al 2022: [10.1038/s41592-022-01443-0](https://doi.org/10.1038/s41592-022-01443-0)


## DeeplabCut installation steps on Alpine:
Below are the following steps in order to install EcholocatoR on Alpine:

1) After you log into the Alpine cluster, please load the Slurm modules and request allocation so that you can install the packages:

```bash
module load slurm/alpine 
acompile --ntasks=4 --time=02:30:00
```
2) Load anaconda, change directory to the /projects/$USER/software path and create a deeplabcut directory:

```bash
module load anaconda
cd  /projects/$USER/software
mkdir deeplabcut
cd deeplabcut
```
3) Clone the repository and cd to path that contains the DeepLabCut YAML file:
```bash
git clone https://github.com/DeepLabCut/DeepLabCut.git
cd DeepLabCut/conda-environments
```

4) Create the DeeplabCut environment, then update it and then activate it:
```bash
conda env create -f DEEPLABCUT.yaml
conda env update -f DEEPLABCUT.yaml
conda activate DEEPLABCUT
```
5) Install cudnn 8.6.0

```bash
pip install nvidia-cudnn-cu11==8.6.0.163 
```

6) Install cuda-toolkit 11.8.0

```bash
conda install -c "nvidia/label/cuda-11.8.0" cuda-toolkit 
```

7) Export the correct paths by following this guide here: https://www.tensorflow.org/install/pip

```bash
mkdir -p $CONDA_PREFIX/etc/conda/activate.d
echo 'CUDNN_PATH=$(dirname $(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)"))' >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
echo 'export LD_LIBRARY_PATH=$CONDA_PREFIX/lib/:$CUDNN_PATH/lib:$LD_LIBRARY_PATH' >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
source $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
export LD_LIBRARY_PATH=$CONDA_PREFIX/lib/python3.8/site-packages/nvidia/cudnn/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$CONDA_PREFIX/lib:$LD_LIBRARY_PATH
export PATH=$CONDA_PREFIX/bin:$PATH
export XLA_FLAGS=--xla_gpu_cuda_data_dir=$CONDA_PREFIX
```

8) Install Tensorrt and export PATH:

```bash
pip install nvidia-tensorrt==8.4.1.5
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/python3.8/site-packages/tensorrt
```
9) We link libnvinfer.so.8  to libnvinfer.so.7 :

```bash
ln -s $CONDA_PREFIX/lib/python3.8/site-packages/tensorrt/libnvinfer.so.8 $CONDA_PREFIX/lib/python3.8/site-packages/tensorrt/libnvinfer.so.7
ln -s $CONDA_PREFIX/lib/python3.8/site-packages/tensorrt/libnvinfer_plugin.so.8  $CONDA_PREFIX/lib/python3.8/site-packages/tensorrt/libnvinfer_plugin.so.7 
```

10) To test that your installation is working you will need to exit "acompile"  first and load on the NVIDIA GPU debug partition on Alpine"

```bash
conda deactivate
exit
sinteractive --partition=atesting_a100 --qos=testing --time=00:05:00 --gres=gpu:1 --ntasks=2
module load anaconda
conda activate tf_env
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
```





