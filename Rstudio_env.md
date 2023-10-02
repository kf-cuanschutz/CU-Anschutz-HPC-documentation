Setting up Rstudio paths on Alpine:
=========================================================

This tutorial will show you a recipe on how to set up paths on Rstudio so that you can correctly install packages on Alpine.

## Rstudio path steps.
1) Log into Ondemand and locate the tab reserved for Intereactive apps and select Rstudio server custom as shown below

![R_studio_server](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Rstudio/1_server_selection.png)

2) Adjust the server parameters. Make sure that your "Account" is listed as "amc-general". Note that your partition is always "ahub".
   Also, note that your /home directory should not be full always you will not be granted the resource.

![R_studio_server](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Rstudio/2_server_params.png)

3) Wait until you are granted the resources and connect to Rstudio server according to the image below

![R_studio_server](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Rstudio/3_server_access.png)

4) Select the correct tab to configure your global working directory:

![R_studio_server](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Rstudio/3_b_tab_for_global_working_dir_.png)

5) Change your working directory path following the image below. Make sure to have all the options selected the same way they appear on the screenshot.
   Select the option "Browse" as shown below.

   ![R_studio_server](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Rstudio/pre_6_get_to_project_dir.png)

6) Now, you will need to manually modify your working directory path. Click on the 3 dots as shown in the picture below.

   ![R_studio_server](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Rstudio/6-select_project_dir.png)

7) Finally, enter your project directory path as shown below (e.g. /projects/foo@xsede.org/Rdata)

   ![R_studio_server](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Rstudio/pre_middle_6_get_to_project_dir.png)
     
8) Important note: If you need to use your scratch space with Rstudio, it will be located under **"/gpfs/alpine1/scratch/$USER"** .
   Your final working directory path should look something like the screenshot below.

![R_studio_server](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Rstudio/4_Rstudio_default_working_dir.png)

9-a) Context: some packages such as zlib are not available in the Rstudio system paths. Thus some additional package installation might be needed before going back to Rstudio.
   Open an Alpine Shell from Ondemand as shown in the screenshots below:

   ![R_studio_server](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Rstudio/Shell-1.png)

   ![R_studio_server](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Rstudio/Shell-2.png)

9-b) Access a compute node as shown below:

```bash
~]$ module load slurm/alpine 
~]$ acompile --ntasks=4 --time=03:00:00
~]$ cd /projects/$USER/software 
```
10) Download spack and install it based on https://spack.readthedocs.io/en/latest/

```bash
software ]$ module load slurm/alpine
software ]$ git clone -c feature.manyFiles=true https://github.com/spack/spack.git
software ]$ . spack/share/spack/setup-env.sh
```

11) Install zlib, bzip2 and lzma.

```bash
software]$ spack install  zlib
software]$ spack install bzip2
software]$ spack install lzma
```
12) Note that the corresponding LD_LIBRARY_PATH and CPATH will need to be added into Rstudio.
    For instance, in my case zlib was installed under /projects/kfotso@xsede.org/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.3-25ghirelomgkzb4dclggcqljk6ldn2yl.

   Thus the path associated with LD_LIBRARY_PATH will be /projects/kfotso@xsede.org/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.3-25ghirelomgkzb4dclggcqljk6ldn2yl/lib
   
    The path associated with CPATH will be /projects/kfotso@xsede.org/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.3-25ghirelomgkzb4dclggcqljk6ldn2yl/include.

    You may run the following to retrieve those paths:

```bash
software]$ spack find -px  zlib@1.3%gcc@8.4.1
software]$ spack find -px bzip2@1.0.8%gcc@8.4.1
software]$ spack find -px lzma@4.32.7%gcc@8.4.1
```

13) Create a Makevars file:

```bash
software]$ touch ~/.R/Makevars
```

14) Edit the file and add variables similar to the following below. Note that you should add the paths optained on step 8
    We had to add the gsl path (/curc/sw/install/gsl/2.7/gcc/11.2.0) as gsl is a requirements for some of the R packages installation. 

```bash
LDFLAGS+=-L/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.2.13-axwtx3dzwaqi47indh2blq72sxuqgexq/lib -L/curc/sw/install/gsl/2.7/gcc/11.2.0/lib -lgsl -lgslcblas -L/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/lib -L/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/lib

PKG_CFLAGS+=-I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.2.13-axwtx3dzwaqi47indh2blq72sxuqgexq/include -I/curc/sw/install/gsl/2.7/gcc/11.2.0/include -I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/include -I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/include -L/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.2.13-axwtx3dzwaqi47indh2blq72sxuqgexq/lib -L/curc/sw/install/gsl/2.7/gcc/11.2.0/lib -L/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/lib -L/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/lib

PKG_LIBS+=-L/usr/lib64 -L/curc/sw/install/gsl/2.7/gcc/11.2.0/lib -L/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/lib -L/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/lib

CPPFLAGS+=-I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.2.13-axwtx3dzwaqi47indh2blq72sxuqgexq/include -I/curc/sw/install/gsl/2.7/gcc/11.2.0/include -I/curc/sw/install/gcc/11.2.0/include/c++/11.2.0 -I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/include -I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/include

CFLAGS+=-I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/zlib-1.2.13-axwtx3dzwaqi47indh2blq72sxuqgexq/include -I/curc/sw/install/gsl/2.7/gcc/11.2.0/include -I/curc/sw/install/gcc/11.2.0/include/c++/11.2.0 -I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/xz-5.4.1-5veudn435wo5uhsigq6uaeoetpwzufoz/include -I/projects/kefo9343/software/spack/opt/spack/linux-rhel8-zen/gcc-8.4.1/bzip2-1.0.8-x3sbg3owccshbzku5meq7ovgy75hzcf2/include

PATH +=/curc/sw/install/gsl/2.7/gcc/11.2.0/bin
```
15) Add the following in your Rstudio prompt:

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
16) Save the variables as global variables in Rstudio

```R
$ PATH <- Sys.getenv("PATH")
$ LIBRARY_PATH <- Sys.getenv("LIBRARY_PATH")
$ LD_LIBRARY_PATH <- Sys.getenv("LD_LIBRARY_PATH")
$ LIB_DIR <- Sys.getenv("LIB_DIR")
$ C_INCLUDE_PATH <- Sys.getenv("C_INCLUDE_PATH")
```

17) If you need to install a package (e.g. rhdf5) make sure to add the installation directory with parameter lib.
```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("rhdf5", lib="/projects/kfotso@xsede.org/Rstudio_libs/4.2.2", force=TRUE)
```

18) Make sure to save your session
```R
$ q(save = "yes")
```



