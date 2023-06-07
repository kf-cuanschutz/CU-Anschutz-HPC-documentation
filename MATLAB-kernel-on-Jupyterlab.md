Create a MATLAB kernel on Jupyterlab:
======================================

1) On the shell, load MATLAB and anaconda by typing the following commands:

```bash
ml anaconda matlab
```

2) Create a matlab environment with Python 3.9:

```bash
conda create -n matlab python=3.9
```

3) Activate MATLAB environment with the following:

```bash
conda activate matlab
```

4) Install the MATLAB kernel:

```bash
python -m pip install matlab_kernel; python -m matlab_kernel install –user
```

5) A message showing where the kernel specs are installed will display. Kernel specs are queried by Jupyterlab in order to launch the MATLAB kernel:

```bash
[InstallKernelSpec] Installed kernelspec matlab in
/home/kfotso@xsede.org/.local/share/jupyter/kernels/matlab
```
6) Modify the json kernel file in to show the path of the python belonging to the conda environment:
   /home/kfotso@xsede.org/.local/share/jupyter/kernels/matlab/kernel.json
   
Note: Inside the kernel.json file, the structure should look similar to this:

```bash
{"argv": ["/projects/kfotso@xsede.org/software/anaconda/envs/matlab/bin/python", "-m", 
"matlab_kernel", "-f", "{connection_file}"], "display_name": "Matlab", "language": "matlab", 
"mimetype": "text/x-octave", "name": "matlab”}
```
7) Downgrade the setuptools to 36.2.2

```bash
pip install -U pip setuptools==36.2.2
```

8) Create a MATLAB build directory in your project folder:

```bash
mkdir –p /projects/kfotso@xsede.org/MATLAB_build
```

9) Change directory (cd) to the Matlab root:
```bash
cd /curc/sw/matlab/R2021b/extern/engines/python/
```

10) Build the matlab engine: 
```bash
python setup.py build -b /projects/kfotso@xsede.org/MATLAB_build
```

11) Copy the build to the anaconda environment
```bash
cp -R /projects/kfotso@xsede.org/MATLAB_build/lib/matlab/ /projects/kfotso@xsede.org/software/anaconda/envs/matlab/lib/python3.9/site-packages/matlab
```

12) Launch Jupyter lab kernel session

## References:
[1] https://docs.dkrz.de/blog/2021/matlab_kernel.html




