EcholocatoR package installation on Alpine:
======================================

According to the bioconductor [page](https://github.com/RajLabMSSM/echolocatoR), EcholocatoR is "An Automated statistical and functional fine-mapping with extensive access to genome-wide datasets.".
To reference this package, please cite:

> Brian M Schilder, Jack Humphrey, Towfique Raj (2021) echolocatoR: an
> automated end-to-end statistical and functional genomic fine-mapping
> pipeline, *Bioinformatics*; btab658,
> <https://doi.org/10.1093/bioinformatics/btab658>


Below are the following steps in order to install EcholocatoR on Alpine:

## EcholocatoR package installation steps.

1) Step 1: Create token

  The first thing to do is for you to create a token, because otherwise you will exhaust the Github API rate limit which is set at 60 requests per hour. 

2) Step 2: Resource Allocation: 

```bash
module load slurm/alpine 
acompile --ntasks=2 --time=01:30:00 
```

3) Step 3: Load the appropriate modules and dependencies: 

Here we load the appropriate gcc compiler along with gsl jpeg and R in one line.

```bash
ml gcc gsl jpeg R 
```

4) Step 4: Prepare the appropriate paths & environment files

  * We create the directory containing echolocatoR inside `/projects/$USER`
  * We `cd` to it
  * We create a local directory where you will install r-packages. 
  * We create the R environment file where you will be able to specify important paths

```bash
mkdir /projects/$USER/software/echolochatoR 
cd /projects/$USER/software/echolochatoR 
mkdir r-packages 
touch .Renviron 
```

5) Step 5



