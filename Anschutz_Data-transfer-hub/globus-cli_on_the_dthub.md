**Globus cli on Anschutz HPC data transfer hub**
===============================================

The data transfer hub is a box that is accessible on the CU Anschutz Network and that is meant to facilitate data transfer over the CU Boulder DTNs. 
It happens that some labs have their data stored on Anschutz at a place of a relatively slow network speed. 
Therefore, the hub can be alternative for them to mount whatever folder they wish to copy and thus facilitate the communication to the Boulders DTN. 
The data transfer hub has globus command line is installed, but can potentially be used to transfer data to an Amazon S3 buckets or Microsoft OneDrive. 

In this guide, we focus on Globus-cli and demonstrate how to use the globus command to transfer data to the Boulder DTN. 

## Globus-cli steps.

1) Step 1: Load Globus
   To load globus, simply write “getglobus”

   ```bash
   getglobus
   ```

2) Step 2: Log into your globus account
   Once logged in, type globus login to log into your account “globus login”.
   Make sure to follow the instructions to get logged into your globus account.

   ```bash
   globus login
   ```

3) Step 3: Verify login step
  To verify that you are correctly logged in, you may type “globus session show”. 
  The output should indicate your username and your session ID as shown in the screenshot below. 

  ```bash
   globus session show
   ```
  To get more information regarding your username identity you may enter something similar to the following command: “globus  get-identities –v ‘username’”. 

  ```bash
  globus  get-identities –v 'username'
  ```

  Please refer to the screenshot below. Looking closely, at the output one can see their globus ID, their username, full name, organisation and email address associated with the account. 
  Your email address should always be the same one that is associated with your access account. 
  Your username is the same one as your access account but ends with access-ci.org in lieu of xsede.org. 

4) Step 4: Assessment of the CU Boulder DTN
   

