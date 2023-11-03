Guide to use mamba on Alpine:
=========================================================

Mamba is a fast, robust, and cross-platform package manager according to this
[page](https://mamba.readthedocs.io/en/latest/), 
This short guide will show you how to utilize Mamba for your package installation.

## Mamba utilization steps.

1) Make sure that you follow this step described in the Boulder guide in order to configure
   your [condarc file](https://curc.readthedocs.io/en/latest/software/python.html?highlight=condarc#configuring-conda-with-condarc).

2) Copy your .condarc to .mambarc, as shown below:
   ```bash
   cp ~/.condarc ~/.mambarc
   ```

3)  To build packages you may access acompile as show below. Here we used 4 cores for 1 hour. The maximum of cores you may use with acompile is 4 while
    the wall time is 12 hours.
    ```bash
    acompile --ntasks=4 --time=01:00:00
    ```

4) Load mamba forge as done below:
   ```bash
   module load mambaforge/23.1.0-1
   ```

5) You may look at both your mamba and conda environments as done below:
   ```bash
   mamba info -e
   ```

6) If you will use pip make sure that you export your scratch directory to the scratch filesystem as done below:
   ```bash
   export PIP_CACHE_DIR=/scratch/alpine/$USER
   ```

7) Finally,always make sure to export all your TMP related dir as done below:
   ```bash
   export TMP=/scratch/alpine/$USER
   export TEMP=/scratch/alpine/$USER
   export TMPDIR=/scratch/alpine/$USER
   export TEMPDIR=/scratch/alpine/$USER
   ```
