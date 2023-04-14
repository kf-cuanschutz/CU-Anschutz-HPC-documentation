CellRangerRkit package installation on Alpine:
==============================================

CellRangerRkit is a Non-official Git repository for R package cellrangerRkit (currently not available elsewhere; 
The author of the repository is not affiliated with 10x).Last open issue dates from 2019. 
More information here:[page](https://github.com/hb-gitified/cellrangerRkit/issues/4). 
It requires several dependencies such as devtools, roxygen2, svd, Rtsne , DropletUtils, scran, biomaRt, scater.

Below are the following steps in order to install CellRangerRkit on Alpine:

## CellRangerRkit package installation steps.

1) Step 1: Create a token

  The first thing to do is for you to create a token, because otherwise you will exhaust the Github API rate limit which is set at 60 requests per hour. 
  
2) Step 2: Resource Allocation: 

```bash
module load slurm/alpine 
acompile --ntasks=2 --time=02:30:00 
```
3) Step 3: Load the appropriate modules and dependencies: 

Here we load the appropriate gcc compiler along with gsl jpeg and R in one line.

```bash
ml gcc gsl jpeg R anaconda
```

4) Step 4: Install the dependencies by creating a conda environment and installing harfbuzz and fribidi. 

```bash
conda create --name single-cell-rna-dependencies 

conda activate single-cell-rna-dependencies 

conda install -c conda-forge harfbuzz 

conda install -c anaconda fribidi 
```
5) Step 5: Prepare the appropriate paths & environment files

  * We create the directory containing cellrangerRkit with ```bash mkdir -p /projects/$USER/software/cellrangerRkit-install```
  * We `cd` to it with ```bash cd /projects/$USER/software/cellrangerRkit-install```
  * We create a local directory where we will install r-packages with ```bash mkdir r-packages```. 
  * We create the R environment file named `.Renviron`where you will be able to specify important paths: ```touch .Renviron```

6) Step 6: Editing the .Renviron file.
      In the .R environ file, please add the following paths: 
      (Note: remember to change `$USER` with your actual username. e.g. iamauser@xsede.org).
 
```R  
R_LIBS_USER="/projects/$USER/ software/ cellrangerRkit-install/r-packages":/projects/$USER/.conda_pkgs/harfbuzz-4.3.0-hd55b92a_0/lib:/curc/sw/install/R/4.2.2/lib64:/curc/sw/jdk/18.0.1.1/lib:/curc/sw/install/gsl/2.7/gcc/11.2.0/lib:/curc/sw/install/gcc/11.2.0/lib64:/curc/sw/install/R/4.2.2/lib64/R/lib:/projects/$USER/.conda_pkgs/fribidi-1.0.10-h7b6447c_0/lib:/curc/sw/install/jpeg/9d/gcc/11.2.0/lib 

LD_LIBRARY_PATH=/curc/sw/install/R/4.2.2/lib64:/curc/sw/jdk/18.0.1.1/lib:/curc/sw/install/gsl/2.7/gcc/11.2.0/lib:/curc/sw/install/gcc/11.2.0/lib64:/projects/$USER/.conda_pkgs/harfbuzz-4.3.0-hd55b92a_0/lib:/projects/$USER/.conda_pkgs/fribidi-1.0.10-h7b6447c_0/lib:/curc/sw/install/jpeg/9d/gcc/11.2.0/lib 

LIBRARY_PATH=/curc/sw/install/R/4.2.2/lib64:/curc/sw/jdk/18.0.1.1/lib:/curc/sw/install/gsl/2.7/gcc/11.2.0/lib:/curc/sw/install/gcc/11.2.0/lib64:/projects/$USER/.conda_pkgs/harfbuzz-4.3.0-hd55b92a_0/lib:/projects/$USER/.conda_pkgs/fribidi-1.0.10-h7b6447c_0/lib:/curc/sw/install/jpeg/9d/gcc/11.2.0/lib 

R_INCLUDE_DIR="/curc/sw/install/R/4.2.2/lib64/R/include" 

CPATH=/curc/sw/install/gsl/2.7/gcc/11.2.0/include:/usr/local/include:/projects/$USER/.conda_pkgs/harfbuzz-4.3.0-hd55b92a_0/include/harfbuzz:/usr/include/freetype2:/projects/$USER/.conda_pkgs/fribidi-1.0.10-h7b6447c_0/include/fribidi:/curc/sw/install/jpeg/9d/gcc/11.2.0/include 

PKG_CONFIG_PATH=/curc/sw/install/gsl/2.7/gcc/11.2.0/lib/pkgconfig:/curc/sw/install/gcc/11.2.0/lib64/pkgconfig:/projects/$USER/.conda_pkgs/fribidi-1.0.10-h7b6447c_0/lib/pkgconfig:/projects/$USER/.conda_pkgs/harfbuzz-4.3.0-hd55b92a_0/lib/pkgconfig:/curc/sw/install/jpeg/9d/gcc/11.2.0/lib/pkgconfig 
```

7) Step 7: Install packages: launch R by typing ```bash R```& then follow the substeps below: 
   Note if asked to update packages at any of those steps always update all of them. 
   
   7)Part-1: Load your PAT generated PAT token.
     ```R    
     credentials::set_github_pat("YOUR_PAT_Token") 
     ```
   7)Part-2: Install and update package devtools.
     ```R    
     install.packages("devtools") 
     devtools::install_github("hadley/devtools") 
     ```
   7)Part-3: Install roxygen2
      ```R    
     install.packages("roxygen2") 
     ```
   7)Part-4: Install svd
      ```R    
     install.packages("svd") 
     ```
   7)Part-5: Install r-tsne
      ```R    
     install.packages("install.packages("Rtsne") ") 
     ```
   7)Part-6: Install DropletyUtils, biomaRtand scran
     ```R 
     if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
     
     BiocManager::install("DropletUtils") 
     BiocManager::install("biomaRt")
     BiocManager::install("scran") 
     ```
   7)Part-7: Install scatter.
     ```R 
     BiocManager::install("scater") 
     ```
8) Load the devtools and roxygen depencies and install the cellrangerRkit with your actual token. 
   Note: Replace 'MY_GITHUB_USERNAME' and ‘YOURPATTOKEN’ by your actual Github username and generated token
   respectively.
   ```R 
   library(devtools) 
   library(roxygen2) 
   install_github( 'hb-gitified/cellrangerRkit', username = 'MY_GITHUB_USERNAME', auth_token = ‘YOURPATTOKEN’ ) 
    ```R 
    
 9) In case yu need to install scRNAseq.
    ```R 
    if (!require("BiocManager", quietly = TRUE)) 
        install.packages("BiocManager") 
    BiocManager::install("scRNAseq") 
    ```
