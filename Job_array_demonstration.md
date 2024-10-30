Learn how to run a job array with Slurm on Alpine:
-------------------------------------------------

Have you ever on Alpine worked on a pipeline where you had to apply the same code on multiple samples in an [embarrasingly parallel](https://webhome.phy.duke.edu/~rgb/Beowulf/beowulf_book/beowulf_book/node30.html) way?
If that is case, this guide may be helpful to you. Let us introduce job [arrays](https://mesocentre.pages.centralesupelec.fr/user_doc/ruche/06_slurm_jobs_management/). Unlike [gnu parallel](https://blog.ronin.cloud/gnu-parallel/)
slurm job arrays are fairly easy to implement, with very little change to your initial slurm script.

## What are job arrays?
-----------------------

Slurm job arrays is an implementation that allows you submit a range of job indexes to the slurm controller. Each job index correspond to the same slurm job, applied to a unique array task ID.
Hence, if one needs to run the same operation on multiple fasta files, thus each fasta file will correspond to a job array index. Let us review an example below:

## Original example:
--------------------
Here, we are using [cellbender](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/cellbender_install_tutorial_.md) on a gpu and we have a total of 72 samples. See the full repo [here](https://github.com/kf-cuanschutz/slurm-job-arrays/tree/main ).
Here is the original [code](https://github.com/kf-cuanschutz/slurm-job-arrays/blob/main/cellbender_cuda_slurm.sh) running on the gpu aa100 partition. One can see the loop running on 72 samples.

```bash
#!/bin/bash

#SBATCH --nodes=1 # Number of nodes or computers. Should always be 1 for now.
#SBATCH --ntasks=10 # Number of CPU cores. As you request more CPU cores, you are also getting more CPU memory. You have about 3.8G per core
#SBATCH --time=03:00:00 # Walltime
#SBATCH --partition=aa100 # This is the name of the NVIDIA GPU partition. Made of nodes containing 3x A100 gpus.
#SBATCH --gres=gpu:1 # Here we are requesting 1 gpu
#SBATCH --job-name=cellbender_gpu # Name of the job that will be submitted.
#SBATCH --output=cellbender_gpu.%j.out # Name of the file where all the benign outputs and logs related to the run will be redirected. %j is the variable that will capture the jobID
#SBATCH --error=cellbender_gpu.%j.err # Name of the file where all the errors related to the run will be redirected.
#SBATCH --mail-type=BEGIN,FAIL,END # I get the Slurm notification in my email inbox when it begins, ends and fails.
# Whom to send the email to
#SBATCH --mail-user=foo.foo@cuanschutz.edu # My email address where I wish to get all the notifications.

# /home is very small so we need to redirect tmp and cache related files to the scratch filesystem.
export TMP=/gpfs/alpine1/scratch/$USER/cache_dir
export TEMP=$TMP
export TMPDIR=$TMP
export TEMPDIR=$TMP
export PIP_CACHE_DIR=$TMP
mkdir -pv $TMP

# Loading my anaconda module and activating my conda ENV
module load anaconda
conda activate cellbender

# Loop through samples from RESULT_1 to RESULT_72
for i in {1..72}
do
    # Create the sample name (e.g., RESULT_1, RESULT_2...)
    SAMPLE="RESULT_${i}"
    # Create a directory for each sample
    mkdir $SAMPLE
    # Run cellbender remove-background for each sample
    cellbender remove-background \
        --cuda \
        --fpr 0.1 \
        --input /pl/active/foolab/shared/$SAMPLE/raw_feature_bc_matrix.h5 \
        --output $SAMPLE/output.h5
done
```

## Fix:
--------------------

Now to fix it all we have to do is to add into the slurm header which correspond to the number of samples. 

```bash
#SBATCH --array=1-72
```

Then, we fetch the array task index corresponding to the slurm array subjobID:

```bash
export PatientID=$SLURM_ARRAY_TASK_ID
```

Finally, we remove the loop that we had when calling for cellbender.

This is what is was before:

```bash
# Loop through samples from RESULT_1 to RESULT_72
for i in {1..72}
do
    # Create the sample name (e.g., RESULT_1, RESULT_2...)
    SAMPLE="RESULT_${i}"
    # Create a directory for each sample
    mkdir $SAMPLE
    # Run cellbender remove-background for each sample
    cellbender remove-background \
        --cuda \
        --fpr 0.1 \
        --input /pl/active/foolab/shared/$SAMPLE/raw_feature_bc_matrix.h5 \
        --output $SAMPLE/output.h5
done
```

This is the **final fix**:

```bash
SAMPLE="RESULT_${PatientID}"
# Create a directory for each sample
mkdir $SAMPLE
cellbender remove-background \
       --cuda \
       --fpr 0.1 \
       --input /pl/active/foolab/shared/$SAMPLE/raw_feature_bc_matrix.h5 \
       --output $SAMPLE/output.h5
```
