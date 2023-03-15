ALDEx2 package installation on Alpine:
======================================

According to the bioconductor [page](https://www.globus.org/globus-connect-personal), AldeX2 is "A differential abundance analysis for the comparison of two or more conditions".
To reference this package, one can use the following dev [page](https://github.com/ggloor/ALDEx2_dev).
Below are the following steps in order to install AldeX2 on Alpine:

## AldeX2 package installation steps.

1) After you log into the Alpine cluster, please load the slurm modules and request allocation so that you can install the package:

```bash
module load slurm/alpine 
acompile --ntasks=2 --time=01:30:00
```

2) Then change directory to your project path where you will have enough space to install your package (250GB total).
```bash
cd /projects/$USER
```
3) You will need to load the appropriate gcc compiler as well as the scientific library GSL before loading R
```bash
ml gcc gsl 
module load R 
```

4) Create a local directory where you will install r-packages as well as an R environment file where you will be able to specify important paths:
```bash
mkdir r-packages 
touch .Renviron 
```

5) In the .R environ file, please add the following paths: (Note: remember to change `$USER` with your actual username.

R_LIBS_USER=/projects/$USER/r-packages:/curc/sw/install/R/4.2.2/lib64:/curc/sw/jdk/18.0.1.1/lib:/curc/sw/install/gsl/2.7/gcc/11.2.0/lib:/curc/sw/install/gcc/11.2.0/lib64:/curc/sw/install/R/4.2.2/lib64/R/lib 
R_INCLUDE_DIR=/curc/sw/install/R/4.2.2/lib64/R/include 
CPATH=/curc/sw/install/gsl/2.7/gcc/11.2.0/include:/usr/local/include  

6) Finally, launch R by typing `R`, and copy and paste the following commands:
```R
install.packages("devtools") 
install.packages("Rfast") 
 

if (!require("BiocManager", quietly = TRUE)) 
    install.packages("BiocManager") 
 
BiocManager::install("ALDEx2") 
```


