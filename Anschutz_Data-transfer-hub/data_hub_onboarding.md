**Anschutz Data transfer hub onboarding**
===============================================

The data transfer hub is a box that is accessible on the CU Anschutz Network and that is meant to facilitate data transfer over the CU Boulder DTNs. 
It happens that some labs have their data stored on Anschutz at a place of a relatively slow network speed. 
Therefore, the hub can be alternative for them to mount whatever folder they wish to copy and thus facilitate the communication to the Boulders DTN. 
The data transfer hub has globus command line is installed, but can potentially be used to transfer data to an Amazon S3 buckets or Microsoft OneDrive. 

In this guide we want to demonstrate to the reader how they can log into the system and successfully mount a drive or folder to it. 

## Globus-cli steps.

## Step 1: Requirements
   The user will make sure to be on Campus VPN if out of campus. That is, the Palo Alto Global Protect app pointing to amc-vpn.ucdenver.

## Step 2: Logging in

Open a shell of your choice and ssh to “psomdapp806.ucdenver.pvt". Your username and password should be the same as your Anschutz credentials. 
Please refer to the full command below. 

```bash
[fotsok@psomdapp806 ~]$ssh fotsok@psomdapp806.ucdenver.pvt 
```

PS: Once logged in, make sure to carefully read the Banner. It contains information on how to mount and unmount a Windows drive/folder, 
how to call for the globus-cli software etc ... 

## Step 3: Initialization

You might need to run “kinit” as shown below the first time you are logging into the system. 
It will let the system obtain all the necessary authentication information and verify your identity

```bash
[fotsok@psomdapp806 ~]$kinit 
```

## Step 4: Mount drive

Now let’s jump into the folder mounting phase. To mount a folder let’s say for Isilon, you will need to create an associated folder in your home directory 

```bash
[fotsok@psomdapp806 ~]$mkdir my_isilon_drives  
```
Then, simply run the following: 

```bash
[fotsok@psomdapp806 ~]$sudo mount.sh //data.ucdenver.pvt/dept my_isilon_files  
```

You may verify that the files have been properly mounted by running “df -h” or changing directory to the folder my_isilon_files with “cd ~/my_isilon_files;ls” 
This should automatically mount any folder that you have access to in Isilon. To mount non-Isilon drive into the hub that is still cifs,smb or windows you may 
re-use the mount command described above. Only thing is you will need to replace the incoming address and the mount  Directory as shown below. 

```bash
[fotsok@psomdapp806 ~]$sudo mount.sh //PSOMDFS821.ucdenver.pvt/FotsoTesting data_hitachi
```

PS: Due to the limitations of the hub, it is possible that you might run out of quota space in /tmp after attempting multiple mounts or globus set ups. 
Simply run ls –la /tmp to see if you own any folder there and if that is the case delete them.  

![get_globus](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Anschutz_Data-transfer-hub/Globus-cli-screenshots/23.png)



## Step 5: About the data transfer

To begin a transfer simply open a tmux or screen session. Tmux and screen will allow the user to log out of the system without interferring with any transfer. 
There is a variety of ways you can make a transfer on the hub to Alpine: Globus-cli, scp, rsync. 
Note that scp and rsync require the user to have been already enrolled in the Anschutz ssh program. 


## Step 6: Unmount drive

To unmount the system simply run  

```bash
[fotsok@psomdapp806 ~]$sudo unmount.sh my_isilon_drives 
```

## Step 7: Mount a linux filesystem (optional)

To mount a linux filesystem one will need to use sshfs. Make sure to create the associated directory as done above. 
In the example below, I want to mount a directory called “CUDNN” from a system named somdlapps01 visible from the campus internal network that is located 
on a different linux system on campus. 
Thus a create a folder “data_cudnn” and use sshfs to mount it. 

```bash
[fotsok@psomdapp806 ~]$mkdir ~/data_cudnn 
[fotsok@psomdapp806 ~]$sshfs fotsok@somdlapps01:/home/fotsok/CUDNN /home/fotsok/data_cudnn
```


 
