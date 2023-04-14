# Alpine pipeline optimization FAQ 
  ===============================

### 1) For job arrays how many jobs can be accepted for each user in the Slurm controller queue?

   It appears that the upper max limit of jobs per array is 1000. 
   Thus, if you need more jobs than 1000 consider using GNU parallel as an alternative.
   See below:
   
   ```bash
    scontrol show config | grep -i max
    SchedulerParameters   = bf_max_job_test=1000,bf_max_job_user=20,bf_max_job_part=2000,bf_continue,max_switch_wait=604800,max_array_tasks=1000```
