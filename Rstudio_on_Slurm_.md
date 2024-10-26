Run your Rstudio related Environment with Slurm on Alpine:
=========================================================

This guide if users who have already installed their libraries and dependencies from [here](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/tree/main/Rstudio_related_scripts;
and simply wish to re-use them in a slurm script. There could be quite a few compelling reasons to that. For instance, on Alpine Rstudio users are limited to only 16 cores, thus for people
that wish to appy more ambitious runs that need either more memory or cores without having to re-install all the Rstudio components all over again with LMOD R or anaconda, this is might be
the way to go. In addition, for users that need to run long Rstudio jobs (>6 hours) and that are worried of experiencing interruptions, this is the ways to go as well. All the files related 
to this guide are located [here](https://github.com/kf-cuanschutz/Rcontainer_slurm_)


## Slurm testing steps steps.

1) Log into Alpine and go to either your /projects or /scratch directory and clone the Rcontainer repository.

```bash
cd /scratch/alpine/$USER
git clone https://github.com/kf-cuanschutz/Rcontainer_slurm_.git
```
