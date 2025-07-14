Running hail interactively on Alpine:
============================================================

This short tutorial shows you how to run [hail](https://hail.is/references.html)  on Alpine. Hail has been installed from this page: https://hail.is/docs/0.2/install/linux.html
Note that at the moment you have to open a ticket on Alpine so that Hail can be installed into your filesystem. Here, we see how to run hail interactively using a script of modified from the hail website, but hail can also be run non-interactively.
The hail installation that we use for our example is located in "/pl/active/CCPM/software".

[Hail](https://hail.is/references.html) is a genomic analysis tool that enables distributed parallel computing over multiple computer nodes.
In this guide, we plan to demonstrate how to run hail on Alpine interactively. The python script that we use to demonstrate it was downloaded from [here](https://hail.is/docs/0.2/install/other-cluster.html). Note that the code "slurm-spark-submit" was adapted from the original code "pbs-spark-submit" from the [UNM CARC HPC center](https://lobogit.unm.edu/CARC/tutorials/-/blob/master/spark/pbs-spark-submit).

## Hail utilization steps.

1) Make sure to clone the hail repository that we implemented and go into that directory.
   We choose to this in the scratch directory.

   ```bash
   cd /scratch/alpine/$USER
   git clone https://github.com/kf-cuanschutz/Hail_support_cu_anschutz.git
   cd Hail_support_cu_anschutz
   ```

3) Now for this demonstration, we want to request 2 cores per nodes and 2 nodes to demonstrate the parallel distribution.
   The CPU partition to demonstrate testing on Alpine is called "atesting". Please refer to the CU Boulder [page](https://curc.readthedocs.io/en/latest/clusters/alpine/alpine-hardware.html) for more information.
   We request the partition for a walltime of 10 minutes.

   ```bash
   sinteractive --partition=atesting --qos=testing --nodes=2 --ntasks=2 --time=00:10:00
   ```

4) Now we want to export all the TMP related variables to scratch:

   ```bash
   export TMP=/gpfs/alpine1/scratch/$USER/cache_dir
   mkdir -pv $TMP
   export TEMP=$TMP
   export TMPDIR=$TMP
   export TEMPDIR=$TMP
   export PIP_CACHE_DIR=$TMP
   ```

5) If you need to use hail please submit a request by emailing hpcsupport@cuanschutz.edu and we will install Hail for your lab.
   For this demonstration, we are using an already existing hail install path that belongs to a lab.

   ```bash   
   module use --append /pl/active/CCPM/software/lmod-files
   module load hail
   ```

6) We want to make sure that we save the name of the nodes we requested inside a text file that we will later call.

   ```bash
   scontrol show hostname > $SLURM_SUBMIT_DIR/nodelist.txt
   export SLURM_NODEFILE=$SLURM_SUBMIT_DIR/nodelist.txt
   ```
7) We may now execute the python script.

   ```bash
   python slurm-spark-submit \
   --jars $HAIL_HOME/backend/hail-all-spark.jar \
   --conf spark.driver.extraClassPath=$HAIL_HOME/backend/hail-all-spark.jar \
   --conf spark.executor.extraClassPath=./hail-all-spark.jar \
   --conf spark.serializer=org.apache.spark.serializer.KryoSerializer \
   --conf spark.kryo.registrator=is.hail.kryo.HailKryoRegistrator \
   --work-dir $SLURM_SUBMIT_DIR \
   hail-script.py --temp_dir $TMP
   ```
8) As one can see below we launch the command and run our master node on node c3cpu-a2-a3-1.rc.int.colorado.edu.
   ![launch_command](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Hail_tutorial_folder/1.png)
   ![master_node](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Hail_tutorial_folder/2.png)

9) This in return spawns a daemon process on that same Master node as shown below:
    ![daemon](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Hail_tutorial_folder/3.png)

10) A Spark worker process then starts, still on that Master node.
    ![worker_spark_process](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Hail_tutorial_folder/4.png)
    ![registration](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Hail_tutorial_folder/5.png)

11) Then finally a Spark service works strarts on worker node c3cpu-a2-a3-2.rc.int.colorado.edu
    ![worker_node](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Hail_tutorial_folder/6.png)

 12) Finally, Hail can start the processing, on top of the Spark infrastructure.
     ![Hail](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Hail_tutorial_folder/7.png)
     ![Spark+Hail in overall](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Hail_tutorial_folder/8.png) 

    






