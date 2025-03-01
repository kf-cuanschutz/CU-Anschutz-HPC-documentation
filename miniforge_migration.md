Guide to use mamba on Alpine:
=========================================================

[Miniforge](https://github.com/conda-forge/miniforge) is a minimal version of anaconda that is supposed to natively fetch its packages from the conda-forge channel.
Miniforge is supposed to be lightweight and quite fast. On Alpine, it will serve as a replacement for mambaforge, which will no longer be supported starting on March 10,2025.
Miniforge is identical to Mambaforge in functionality (it provides access to both conda and mamba). Additionally, the newest version of Miniforge we have installed is more stable and does not result in issues when deactivating and removing environments. 
Any environments created while using the Anaconda or Mambaforge modules will be accessible when you load the Miniforge module. 

## Miniforge utilization steps.

1) Open an Alpine OpenOndemand shell following this [guide](https://github.com/tbrunetti/Alpine_HPC_Docs/blob/main/docs/source/login_shell_app.rst).
   If you need access to ssh on Alpine, please fill out this [form](https://ucdenverdata.formstack.com/forms/alpine_ssh_request_form) and email hpcsupport@cuanschutz.edu.


2) As expplained [here](https://curc.readthedocs.io/en/latest/software/python.html?highlight=condarc#configuring-conda-with-condarc) When loading the Anaconda or Mamba modules, a .condarc file will be created for you in your /home/$USER directory, if the file does not exist. Please copy and paste the following block below into $HOME/$USER/.condarc so that
 miniforge points to your /projects/$USER directory instead. The last line of the block below should also allow you to fetch the system conda environments as well.

```bash
pkgs_dirs:
- /projects/.xsede.org/kfotso/.conda_pkgs
envs_dirs:
- /projects/.xsede.org/kfotso/software/anaconda/envs
  /curc/sw/anaconda3/2023.09/envs
```

4)  To build packages you may access acompile as show below. Here we used 4 cores for 1 hour. The maximum of cores you may use with acompile is 4 while
    the wall time is 12 hours.
    ```bash
    acompile --ntasks=4 --time=01:00:00
    ```

5) Let's check if Miniforge is available:

  ```bash
  [kefo0001_amc@c3cpu-a2-u32-1 kefo0001_amc]$ module avail miniforge
                                                                                                                                                                                                                  
-------------------------------------------------------------------------------------------- Independent Applications --------------------------------------------------------------------------------------------
   miniforge/24.11.3-0 (D)                                                                                                                                                                                        
                                                                                                                                                                                                                  
  Where:                                                                                                                                                                                                          
   L:  Module is loaded                                                                                                                                                                                           
                                                                                                                                                                                                                  
If the avail list is too long consider trying:                                                                                                                                                                    
                                                                                                                                                                                                                  
"module --default avail" or "ml -d av" to just list the default modules.                                                                                                                                          
"module overview" or "ml ov" to display the number of modules for each name.                                                                                                                                      
                                                                                                                                                                                                                  
Use "module spider" to find all possible modules and extensions.                                                                                                                                                  
Use "module keyword key1 key2 ..." to search for all possible modules matching any of the "keys".                                                                                                                 
                                                                                                                                                                                                                  
                                                                                                                                                                                                                  
[kefo0001_amc@c3cpu-a2-u32-1 kefo0001_amc]$     
   ```

  One can see that the available version of miniforge is 24.11.3-0. 

5) Now let's load miniforge as shown below:
   
   ```bash
   module load miniforge/24.11.3-0
   ```

6) Let's see if we have preserved our previous environments from mamba or conda.
   ```bash
   conda info --envs
   # conda environments:
   #
   base         /curc/sw/install/miniforge3/24.11.3-0
   ATOC_NWP     /curc/sw/anaconda3/2023.09/envs/ATOC_NWP
   bash_spr23   /curc/sw/anaconda3/2023.09/envs/bash_spr23
   pyomp_2022   /curc/sw/anaconda3/2023.09/envs/pyomp_2022
   synoptic_f23 /curc/sw/anaconda3/2023.09/envs/synoptic_f23
   cmake_env    /projects/.xsede.org/kfotso/software/anaconda/envs/cmake_env
   cupy_env_2   /projects/.xsede.org/kfotso/software/anaconda/envs/cupy_env_2
   ```
   As we can see, all locally installed environments from anaconda or mambaforge were preserved.

7) Note that, if you will use pip make sure that you export your scratch directory to the scratch filesystem as done below:
   ```bash
   export PIP_CACHE_DIR=/scratch/alpine/$USER
   ```

8) Finally,always make sure to export all your TMP related directories to the scratch filesystem as done below:
   ```bash
   export TMP=/scratch/alpine/$USER
   export TEMP=/scratch/alpine/$USER
   export TMPDIR=/scratch/alpine/$USER
   export TEMPDIR=/scratch/alpine/$USER
   ```

9) Now let's install [snakemake](https://github.com/snakemake/snakemake)

    ```bash
    (base) [kefo0001_amc@c3cpu-a2-u32-1 kefo0001_amc]$ conda create -c bioconda -n snakemake snakemake
   Channels:
   - bioconda
   - conda-forge
   Platform: linux-64
   Collecting package metadata (repodata.json): done
   Solving environment: done


    ==> WARNING: A newer version of conda exists. <==
    current version: 24.11.3
    latest version: 25.1.1

    Please update conda by running

    $ conda update -n base -c conda-forge conda

    Package Plan 

     environment location: /projects/.xsede.org/kfotso/software/anaconda/envs/snakemake

     added / updated specs:
     -  snakemake
                                                                                                                                                                             
                                                                                                                                                                                                                 
     To activate this environment, use                                                                                                                                                                               
                                                                                                                                                                                                                 
     conda activate snakemake                                                                                                                                                                                  
                                                                                                                                                                                                                 
      To deactivate an active environment, use                                                                                                                                                                        
                                                                                                                                                                                                                 
      conda deactivate                  
    ```

10) Note that it should be able to fetch automatically the conda-forge channel.
    We may now activate it:

    ```bash
    (base) [kefo0001_amc@c3cpu-a2-u32-1 kefo0001_amc]$ conda activate snakemake
    ```
