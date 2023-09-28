Setting up Rstudio paths on Alpine:
=========================================================

This tutorial will show you a recipe on how to set up paths on Rstudio so that you can correctly install packages on Alpine.

## Rstudio path steps.

5) Log into an Alpine shell and access a compute node:

```bash
~]$ module load slurm/alpine 
~]$ acompile --ntasks=4 --time=03:00:00
~]$ cd /projects/$USER/software 
```
6) Download spack and install it based on https://spack.readthedocs.io/en/latest/

```bash
software ]$ module load slurm/alpine
software ]$ git clone -c feature.manyFiles=true https://github.com/spack/spack.git
software ]$ . spack/share/spack/setup-env.sh
```

7) Install zlib, bzip2 and lzma.

```bash
software]$ spack install  zlib@1.3%gcc@8.4.1
software]$ spack install bzip2@1.0.8%gcc@8.4.1
software]$ spack install lzma@4.32.7%gcc@8.4.1
```
8) Note that the corresponding LD_LIBRARY_PATH and CPATH will need to be added into Rstudio. You run the following to retrieve those paths:

```bash
software]$ spack find -px  zlib@1.3%gcc@8.4.1
software]$ spack find -px bzip2@1.0.8%gcc@8.4.1
software]$ spack find -px lzma@4.32.7%gcc@8.4.1
```

9) Create a Makevars file:

```bash
software]$ touch ~/.R/Makevars
```

10) Edit the file and add variables similar to the following below. Note that you should add the paths optained on step 8

```bash
LDFLAGS+=-L/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.2.13-axwtx3dzwaqi47indh2blq72sxuqgexq/lib -L/curc/sw/install/gsl/2.7/gcc/11.2.0/lib -lgsl -lgslcblas -L/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/lib -L/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/lib

PKG_CFLAGS+=-I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.2.13-axwtx3dzwaqi47indh2blq72sxuqgexq/include -I/curc/sw/install/gsl/2.7/gcc/11.2.0/include -I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/include -I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/include -L/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.2.13-axwtx3dzwaqi47indh2blq72sxuqgexq/lib -L/curc/sw/install/gsl/2.7/gcc/11.2.0/lib -L/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/lib -L/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/lib

PKG_LIBS+=-L/usr/lib64 -L/curc/sw/install/gsl/2.7/gcc/11.2.0/lib -L/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/lib -L/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/lib

CPPFLAGS+=-I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.2.13-axwtx3dzwaqi47indh2blq72sxuqgexq/include -I/curc/sw/install/gsl/2.7/gcc/11.2.0/include -I/curc/sw/install/gcc/11.2.0/include/c++/11.2.0 -I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/include -I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/include

CFLAGS+=-I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.2.13-axwtx3dzwaqi47indh2blq72sxuqgexq/include -I/curc/sw/install/gsl/2.7/gcc/11.2.0/include -I/curc/sw/install/gcc/11.2.0/include/c++/11.2.0 -I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/include -I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/include

PATH +=/curc/sw/install/gsl/2.7/gcc/11.2.0/bin
```
10) Add the following in your Rstudio prompt:

```R
$ Sys.setenv(PATH = paste("/usr/include:/curc/sw/install/gsl/2.7/gcc/11.2.0/bin:/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz",Sys.getenv("PATH"), sep=""))
$ Sys.setenv(LIBRARY_PATH = paste("/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.2.13-axwtx3dzwaqi47indh2blq72sxuqgexq/lib:curc/sw/install/gsl/2.7/gcc/11.2.0/lib:/curc/sw/install/gcc/11.2.0/lib64:/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/lib:/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/lib:",Sys.getenv("LIBRARY_PATH"), sep=""))
$ Sys.setenv(LIB_DIR = paste("/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.2.13-axwtx3dzwaqi47indh2blq72sxuqgexq/lib:curc/sw/install/gsl/2.7/gcc/11.2.0/lib:/curc/sw/install/gcc/11.2.0/lib64:/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/lib:/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/lib:",Sys.getenv("LIB_DIR"), sep=""))
$ Sys.setenv(LD_LIBRARY_PATH = paste("/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.2.13-axwtx3dzwaqi47indh2blq72sxuqgexq/lib:/curc/sw/install/gsl/2.7/gcc/11.2.0/lib:/curc/sw/install/gcc/11.2.0/lib64:/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/lib: /projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/lib:",Sys.getenv("LD_LIBRARY_PATH"), sep=""))
$ Sys.setenv(C_INCLUDE_PATH = paste("/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.2.13-axwtx3dzwaqi47indh2blq72sxuqgexq/include:/curc/sw/install/gsl/2.7/gcc/11.2.0/include:/curc/sw/install/gcc/11.2.0/include/c++/11.2.0:/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/include:/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/lib/include",Sys.getenv("C_INCLUDE_PATH"), sep=""))
$ Sys.setenv(C_PATH = paste("/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.2.13-axwtx3dzwaqi47indh2blq72sxuqgexq/include:/curc/sw/install/gsl/2.7/gcc/11.2.0/include:/curc/sw/install/gcc/11.2.0/include/c++/11.2.0:/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/include:/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/include",Sys.getenv("C_PATH"), sep=""))
$ Sys.setenv(CPLUS_INCLUDE_PATH = paste("/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.2.13-axwtx3dzwaqi47indh2blq72sxuqgexq/include:/curc/sw/install/gsl/2.7/gcc/11.2.0/include:/curc/sw/install/gcc/11.2.0/include/c++/11.2.0:/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/include:/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/include",Sys.getenv("CPLUS_INCLUDE_PATH"), sep=""))
$ Sys.setenv(PKG_CONFIG_PATH = paste("/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.2.13-axwtx3dzwaqi47indh2blq72sxuqgexq/lib/pkgconfig:/curc/sw/install/gsl/2.7/gcc/11.2.0/lib/pkgconfig:/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/lib/pkgconfig:/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/lib/pkgconfig",Sys.getenv("PKG_CONFIG_PATH"), sep=""))
```
11) Save the variables as global variables in Rstudio

```R
$ PATH <- Sys.getenv("PATH")
$ LIBRARY_PATH <- Sys.getenv("LIBRARY_PATH")
$ LD_LIBRARY_PATH <- Sys.getenv("LD_LIBRARY_PATH")
$ LIB_DIR <- Sys.getenv("LIB_DIR")
$ C_INCLUDE_PATH <- Sys.getenv("C_INCLUDE_PATH")
```

12) If you need to install a package (e.g. rhdf5) make sure to add the installation directory with parameter lib.
```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("rhdf5", lib="/projects/kfotso@xsede.org/Rstudio_libs/4.2.2", force=TRUE)
```

13) Make sure to save your session
```R
$ q(save = "no")
```



