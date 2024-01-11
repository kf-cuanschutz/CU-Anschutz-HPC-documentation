export APPTAINER_TMPDIR=/projects/$USER/.rstudioserver
export APPTAINER_CACHEDIR=/projects/$USER/.rstudioserver
apptainer shell --fakeroot --overlay /projects/$USER/.rstudioserver/rstudio-server-4.2.2_overlay.img /curc/sw/containers/open_ondemand/rstudio-server-4.2.2.sif

