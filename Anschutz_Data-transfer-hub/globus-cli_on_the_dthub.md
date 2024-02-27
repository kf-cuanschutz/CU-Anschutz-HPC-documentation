**Globus cli on Anschutz HPC data transfer hub**
===============================================

The data transfer hub is a box that is accessible on the CU Anschutz Network and that is meant to facilitate data transfer over the CU Boulder DTNs. 
It happens that some labs have their data stored on Anschutz at a place of a relatively slow network speed. 
Therefore, the hub can be alternative for them to mount whatever folder they wish to copy and thus facilitate the communication to the Boulders DTN. 
The data transfer hub has globus command line is installed, but can potentially be used to transfer data to an Amazon S3 buckets or Microsoft OneDrive. 

In this guide, we focus on Globus-cli and demonstrate how to use the globus command to transfer data to the Boulder DTN. 

## Globus-cli steps.

## Step 1: Load Globus
   To load globus, simply write “getglobus”

   
![get_globus](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Anschutz_Data-transfer-hub/Globus-cli-screenshots/1.png)

## Step 2: Log into your globus account
   Once logged in, type globus login to log into your account “globus login”.
   Make sure to follow the instructions to get logged into your globus account.

   ```bash
   globus login
   ```

## Step 3: Verify login step
  To verify that you are correctly logged in, you may type “globus session show”. 
  The output should indicate your username and your session ID as shown in the screenshot below. 

 ![get_globus](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Anschutz_Data-transfer-hub/Globus-cli-screenshots/3.png)

  ```diff
  !To get more information regarding your username identity you may enter something similar to the following command: “globus  get-identities –v ‘username’”. 
  ```
 ![get_globus](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Anschutz_Data-transfer-hub/Globus-cli-screenshots/5.png)

  
  ```diff
  !Please refer to the screenshot below. Looking closely, at the output one can see their globus ID, their username, full name, organisation and email address associated with the   account. 
  !Your email address should always be the same one that is associated with your access account. 
  !Your username is the same one as your access account but ends with access-ci.org in lieu of xsede.org.
  ```


## Step 4: Assessment of the CU Boulder DTN

  Now we want to get a closer look at the DTN that we wish to transfer the data to, that is the CU Boulder DTN node, that can be identified as “CU Boulder Research Computing”.
  We want to be able to fetch the identifier associated with that DTN.
  To do so, one will have to enter the following command “globus endpoint search ‘CU Boulder Research Computing’”

![get_globus](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Anschutz_Data-transfer-hub/Globus-cli-screenshots/8.png)


  After entering the command, we get pele-mele many display name. 
  For instance, “CU Boulder Research computing DTN23” that corresponds an Endpoint while “CU Boulder indicates a Global Mapped Collection (GCS). 
  It is important for the reader to distinguish those two terms. According to Globus 5 an endpoint is solely used for information purpose such as collection listing whereas a GCS is used for management and data transfer. Also, refer to the screenshot below. For more information, on those terms please refer to these sources [[1](https://docs.globus.org/cli/collections_vs_endpoints/)] , [[2](https://docs.globus.org/globus-connect-server/v5/reference/collection/)].

### Details regarding the DTN23 endpoint
![get_globus](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Anschutz_Data-transfer-hub/Globus-cli-screenshots/9.png)

### Details regarding the CU Boulder GCS
![get_globus](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Anschutz_Data-transfer-hub/Globus-cli-screenshots/10.png)


## Step 5: List directories from an Alpine filesystem

  We shall now because of the reasons indicated above focus on the GCS. 
  First thing that we want to do is to see if we can list our files from that collection thanks to its globus ID.

  ![get_globus](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Anschutz_Data-transfer-hub/Globus-cli-screenshots/11.png)

  As the reader will notice, writing the collection’s ID is quite dull, thus let’s assign it to a variable as shown on the globus [guide](https://docs.globus.org/cli/environment_variables/). We shall name our variable as “ep2” since it    represents the destination identity. 

  ![get_globus](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Anschutz_Data-transfer-hub/Globus-cli-screenshots/12.png)


   PS: To get all the parameters possible with the globus command, simply enter “globus list-commands" 

## Step 6: Create an Anschutz endpoint

  Now for the transfer to effectively happen, one will need to create an endpoint on the data transfer hub. We shall demonstrate below how to create and activate it for the reader. 
 
  ```bash
  globusconnect –setup
  ```
  
  Note: If the command above does not work, try the command below:

  ```bash
  globusconnectpersonal –setup
  ```

  The command above should print some kind of URL. The user will kindly copy it and paste into one of your browser, assuming they are already logged into Globus with their correct    access ID. The output should look similar to what is below. 

### screenshot of the setup command and its output
![get_globus](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Anschutz_Data-transfer-hub/Globus-cli-screenshots/15_b.png)

### screenshots showing the steps in the browser necessary for the authentication of the endpoint
![get_globus](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Anschutz_Data-transfer-hub/Globus-cli-screenshots/13.png)

![get_globus](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Anschutz_Data-transfer-hub/Globus-cli-screenshots/14.png)


Then once on the browser the user may copy the authorization code and paste it back into the browser. 

## Step 7: Activate endpoint

  They will be prompted for an Endpoint Name and will be given an endpoint ID. To start the endpoint, they will simply type “globusconnect -start &”. 
  Finally, similarly to what was done for the destination variable ID they may create a variable for the sender ID as show below.  
  
![get_globus](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Anschutz_Data-transfer-hub/Globus-cli-screenshots/16.png)


## Step 8: Mount folder of interest and initiate the transfer.

 Once that is done, mount your folder of interest either with mount.sh if a Windows filesystem or sshfs if a linux filesystem. Please refer to the other guide on the data transfer hub setup. 

![get_globus](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Anschutz_Data-transfer-hub/Globus-cli-screenshots/18.png)
 
Once that is done, we can make the transfer happen with the command:

```bash
globus transfer $ep1:~/data_cudnn $ep2:/scratch/alpine/kfotso@xsede.org  --recursive --label "Test 1" 
```
It will ask you to enter a “globus session content” command. Once entered, please copy the URL to the browser, select your identifier, and copy back the authorization token to the terminal as shown below. 

### Steps in the shell
![get_globus](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Anschutz_Data-transfer-hub/Globus-cli-screenshots/21_b.png)

### screenshots showing the steps in the browser necessary for the authentication of the endpoint
![get_globus](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Anschutz_Data-transfer-hub/Globus-cli-screenshots/20.png)

For more information on globus-cli in general please refer to this [link](https://docs.globus.org/cli/). 

  


   

