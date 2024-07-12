export APPTAINER_TMPDIR=/projects/$USER/.rstudioserver
export APPTAINER_CACHEDIR=/projects/$USER/.rstudioserver
apptainer -d shell --bind /projects,/scratch/alpine,$CURC_CONTAINER_DIR_OOD --fakeroot --overlay /projects/$USER/.rstudioserver/rstudio-server-4.2.2_overlay.img /curc/sw/containers/open_ondemand/rstudio-server-4.2.2.sif

