Run your Rstudio related Environment with Slurm on Alpine:
=========================================================

This guide if users who have already installed their libraries and dependencies from [here](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/tree/main/Rstudio_related_scripts;
and simply wish to re-use them in a slurm script. There could be quite a few compelling reasons to that. For instance, on Alpine Rstudio users are limited to only 16 cores, thus for people
that wish to appy more ambitious runs that need either more memory or cores without having to re-install all the Rstudio components all over again with LMOD R or anaconda, this is might be
the way to go. In addition, for users that need to run long Rstudio jobs (>6 hours) and that are worried of experiencing interruptions, this is the ways to go as well. All the files related 
to this guide are located [here](https://github.com/kf-cuanschutz/Rcontainer_slurm_) .


## Slurm testing steps steps.

1) Log into Alpine and go to either your /projects or /scratch directory and clone the Rcontainer repository.

```bash
cd /scratch/alpine/$USER
git clone https://github.com/kf-cuanschutz/Rcontainer_slurm_.git
cd Rcontainer_slurm_
```

2) The Slurm file "R_container_slurm.slurm"  contains a header that is suitable for the Alpine CPU partition.

```bash

#!/bin/bash
#SBATCH --nodes=1 # Number of nodes requested. Please always request 1 node, unless you are using a protocol or software that takes advantages of distributing computing.
# This means MPI or Gnu parallel or Sparkcluster or Dask.

#SBATCH --time=00:00:05 # The walltime requested. Here we are requesting only 5 seconds because the R script we are launching is not very computationally complex.
#SBATCH --qos=normal # This means that we are requesting for a quality of service of a walltime up to 24 hours. 

#For a walltime > 24 hours one will have to request "--qos=long" and to acess the memory partition, one will request "--qos=mem": https://curc.readthedocs.io/en/latest/running-jobs/job-resources.html

#SBATCH --partition=amilan # CPU partition, also known as the General purpose partition.
#SBATCH --ntasks=1 # Number of CPU cores requested. For this run, there is no parallelism at all so I am just requesting 1 core. I get 3.8G memory per core on a CPU partition: https://curc.readthedocs.io/en/latest/clusters/alpine/alpine-hardware.html#alpine-hardware

#SBATCH --account=amc-general # The account name for a CU Anschutz user on Alpine
#SBATCH --job-name=R_job # Name of the job, if I wish to monitor it or study its efficiency later on. 

#For more infor on job efficiency please refer to here -> https://curc.readthedocs.io/en/latest/compute/monitoring-resources.html

#SBATCH --output=Rjob.%j.out # Name of the file where all the benign outputs and logs related to the run will be redirected. %j is the variable that will capture the jobID
#SBATCH --error=Rjob.%j.err # Name of the file where all the errors related to the run will be redirected. 
#SBATCH --mail-user=foo@cuanschutz.edu # My email address where I wish to get all the notifications.
#SBATCH --mail-type=BEGIN,END,FAIL # I get the Slurm notification in my email inbox when it begins, ends and fails.
```
