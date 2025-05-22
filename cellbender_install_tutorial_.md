Cellbender package installation on Alpine:
======================================

According to the cellbender [page](https://github.com/broadinstitute/CellBender/tree/master), "CellBender is a software package for eliminating technical artifacts from high-throughput single-cell RNA sequencing (scRNA-seq) data."
To reference this package, please cite:

Citing CellBender
-----------------

If you use CellBender in your research (and we hope you will), please consider
citing our paper in Nature Methods:

Stephen J Fleming, Mark D Chaffin, Alessandro Arduini, Amer-Denis Akkad,
Eric Banks, John C Marioni, Anthony A Phillipakis, Patrick T Ellinor,
and Mehrtash Babadi. Unsupervised removal of systematic background noise from
droplet-based single-cell experiments using CellBender.
`Nature Methods`, 2023. https://doi.org/10.1038/s41592-023-01943-7

See also `our preprint on bioRxiv <https://doi.org/10.1101/791699>`_.

Below are the following steps in order to install CellBender on Alpine:

## CellBender package installation steps.

1) Step 1: Always make sure that you have a .condarc file configured as [here](https://curc.readthedocs.io/en/latest/software/python.html#configuring-conda-with-condarc)

2) Step 2: Log into an Alpine compute node. We typically use the acompile partition to install packages. For more info on acompile please refer to [here](https://curc.readthedocs.io/en/latest/clusters/alpine/important-notes.html#important-notes)
   Below, we are requesting 4 cores to slurm and a walltime of 4 hours. For more information about cores please refer to pages 3 to 5 [here](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Workshops/Entry_level_workshop_030524_v2.pdf)

```bash
acompile --ntasks=4 --time=04:00:00
```

3) Step 3: Make sure to export your cache and tmp related directory to the scratch filesystem in order to not fill out your home and /tmp filesystems, which are very small in size.

```bash
export TMP=/gpfs/alpine1/scratch/$USER/cache_dir
mkdir -pv $TMP
export TEMP=$TMP
export TMPDIR=$TMP
export TEMPDIR=$TMP
export PIP_CACHE_DIR=$TMP
```

4) Step 4: For installation speed purpose, we typically use miniforge, as anaconda tends to be very slow on Alpine. However, later to actually use the Cellbender, feel free to load anaconda.
           Please run all the commands below

```bash
module load miniforge
conda create -n cellbender  conda-forge::python=3.7 -y
conda activate cellbender
conda install conda-forge::pytables -y
pip install torch
cd /projects/$USER/software
git clone https://github.com/broadinstitute/CellBender.git
pip install -e CellBender
```
5) Step 5: We verify the installation by calling Cellbender as done below.

```bash
(cellbender) [foo@xsede.org@c3cpu-a2-u32-1 cellblender]$ cellbender
usage: cellbender [-h] [-v] {remove-background} ...
CellBender is a software package for eliminating technical artifacts from
high-throughput single-cell RNA sequencing (scRNA-seq) data.
optional arguments:
  -h, --help           show this help message and exit
  -v, --version        show program's version number and exit
sub-commands:
  valid cellbender commands
  {remove-background}
    remove-background  Remove background ambient RNA and barcode-swapped reads
                       from a count matrix, producing a new count matrix and
                       determining which barcodes contain real cells.


(cellbender) [foo@xsede.org@c3cpu-a2-u32-1 cellblender]$ exit

```


6) Step 6: We need to make sure that CellBender can see the A100 NVIDIA GPU so we are going to log into an NVIDIA GPU debug nodes. NVIDI GPU debug nodes on Alpine belong to the partition
   called atesting_a100. It have a max walltime of 1 hour. The atesting_a100 is a partition intended to install gpu related software, test bug in codes etc ... It is **NOT** intended
   at all to actually run your full pipeline. For more information about that partition please refer to [here](https://curc.readthedocs.io/en/latest/clusters/alpine/alpine-hardware.html#partitions).
   Below, one can see that we are requesting 10 min walltime, 4 cpu cores with "--ntasks=4" and 1 gpu with "--gres=gpu:1".

   ```bash
   sinteractive --partition=atesting_a100 --qos=testing --time=00:10:00 --gres=gpu:1 --ntasks=4
   export TEMP=$TMP
   export TMPDIR=$TMP
   export TEMPDIR=$TMP
   export PIP_CACHE_DIR=$TMP
   module load anaconda
   conda activate cellbender
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

## CellBender module file creation and loading

We may now create the .lua file associated to CellBender so that we can load it at will. This section of the tutorial follows the same pattern as this [dorado part 2 guide](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/edit/main/Dorado_installation_tutorial.md)
To do that, we will need to create a directory containing all our lua package, that will get added retrospectively inside /projects/$USER/ folder:
```
cd /projects/$USER
mkdir -p lua
cd lua
mkdir cellbdender
```
<br>
Inside the CellBender folder, we will create a file with the format <version_name>.lua. In this case, the CellBender version was 0.3.2.lua. An easy way to create the file is with the command `touch 0.3.2.lua`.

Now you may use the editor of your choice (e.g. nano, vim etc ...) in order to add the and save the scropt below:

```lua
-- This module loads Cellbender

-- Set local variables
local PACKAGE_PREFIX = "/projects/.xsede.org/foo/software/anaconda/envs/cellbender/"
local USER = os.getenv("USER")

-- Load dependencies
always_load("anaconda")

-- Set environment variables
setenv("TMP", pathJoin("/gpfs/alpine1/scratch", USER))
setenv("TEMP", os.getenv("TMP"))
setenv("TMPDIR", os.getenv("TMP"))
setenv("TEMPDIR", os.getenv("TMP"))
setenv("PIP_CACHE_DIR", os.getenv("TMP"))

-- Activate conda environment
execute{cmd="conda activate /projects/.xsede.org/foo/software/anaconda/envs/cellbender/",modeA={"load"}}

-- Software info:
help([[


CellBender is a software package for eliminating technical artifacts from
high-throughput single-cell RNA sequencing (scRNA-seq) data.

]])

-- Software citations

whatis("If you use CellBender in your research (and we hope you will), please consider citing our paper in Nature Methods: Stephen J Fleming, Mark D Chaffin, Alessandro Arduini, Amer-Denis Akkad, Eric Banks, John C Marioni, Anthony A Phillipakis, Patrick T Ellinor, and Mehrtash Babadi. Unsupervised removal of systematic background noise from droplet-based single-cell experiments using CellBender. Nature Methods, 2023. https://doi.org/10.1038/s41592-023-01943-7. See also our preprint on bioRxiv <https://doi.org/10.1101/791699>" )
```

You may replace "foo" with your Alpine username and change the version number and paths as needed.

The last part of this step is to append this new module file to your module file paths.
To do so, edit your .bash_profile (located in your /home/$USER) and add the following line:


module use --append /projects/foo@xsede.org/lua

OR

module use --append /projects/.xsede.org/foo/lua


Be sure to replace the "foo" portion with your Alpine username.



