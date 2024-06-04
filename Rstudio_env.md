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

5-a) Open an Alpine Shell as  shown in the screenshots below. Then Create a new working directory folder for your 
     project directory (see below).
   ![R_studio_server](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Rstudio/Shell-1.png)

   ![R_studio_server](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Rstudio/mkdir_project_Rdata.png)

5-b) Back in your Rstudio console, change your working directory path following the image below. 
     Make sure to have all the options selected the same way they appear on the screenshot.
     Select the option "Browse" as shown below.

   ![R_studio_server](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Rstudio/pre_6_get_to_project_dir.png)

8) Now, you will need to manually modify your working directory path. Click on the 3 dots as shown in the picture below.

   ![R_studio_server](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Rstudio/6-select_project_dir.png)

9) Finally, enter your project directory path as shown below (e.g. /projects/foo@xsede.org/Rdata)

   ![R_studio_server](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Rstudio/pre_middle_6_get_to_project_dir.png)
     
10) Important note: If you need to use your scratch space with Rstudio, it will be located under **"/gpfs/alpine1/scratch/$USER"** .
   Your final working directory path should look something like the screenshot below.

![R_studio_server](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Rstudio/4_Rstudio_default_working_dir.png)

