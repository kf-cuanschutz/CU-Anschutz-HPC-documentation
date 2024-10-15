export ALPINE_SCRATCH=/gpfs/alpine1/scratch/$USER
export APPTAINER_TMPDIR=$ALPINE_SCRATCH/apptainer/tmp
export APPTAINER_CACHEDIR=$ALPINE_SCRATCH/apptainer/cache
mkdir -pv $APPTAINER_CACHEDIR $APPTAINER_TMPDIR

export r_app_version="4.4.1"
apptainer -d shell --bind /projects,/scratch/alpine,$CURC_CONTAINER_DIR_OOD --fakeroot --overlay /projects/$USER/.rstudioserver/rstudio-${r_app_version}/rstudio-server-${r_app_version}_overlay.img /curc/sw/containers/open_ondemand/rstudio-server-${r_app_version}.sif

