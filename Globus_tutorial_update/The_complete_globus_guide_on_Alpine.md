# Globus transfer demonstration.

Here, we demonstrate how to initiate a globus transfer from a local system to Alpine using Globus.
Thus, this means that we will show how to log into Globus, create a personal endpoint on a MacBook Pro,
identify the Alpine collection name and initiate the transfer.

Finally, we also have an FAQ section at the very bottom of the page.

### Step 1: Download Globus Personal Package.

* If you have a Macbook Pro, go to the following [link](https://docs.globus.org/how-to/globus-connect-personal-mac/) to download Globus and click on 
"Download Globus Connect Personal" to download the package as shown on the picture below. ![image](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Globus_tutorial_update/1.png)

Note:
   * The following tutorial addresses the issue on Windows [machines](https://docs.globus.org/how-to/globus-connect-personal-windows/)
   * Finally, the following tutorial addesses the issue on Linux [machines](https://docs.globus.org/how-to/globus-connect-personal-linux/)

### Step 2: Log into Globus

* Under "Use your existing organizational login" select "ACCESS CI(formely XSEDE)" and hit "Continue" as shown below. ![image](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Globus_tutorial_update/2.png)

* The next page will ask you for your ACCESS-CI ID and password. Please make sure to enter the exact username that you use on Alpine.
  Your password should be the same as the one you use on Alpine as well. Refer to the screenshot below for more illustration.  ![image](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Globus_tutorial_update/3.png)


* Then, you will need to use an authentication method. We strongly recommedn DUO push, as shown below.  ![image](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Globus_tutorial_update/4.png)


### Step 3: Download Globus Connect Personal application

* Select "Download Globus Connect Personal for Mac" and confirm that it was downloaded as shown below. ![image](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Globus_tutorial_update/5.png)


* Confirm that you want to download that package. ![image](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Globus_tutorial_update/6.png)
  
 ![image](https://github.com/kf-cuanschutz/AMC-HPC-documentation/blob/main/Globus-local-entry-point-files/7.png)
  

### Step 4: Install Globus personal 

* Drag the Globus icon to the Application folder as shown below: ![image](https://github.com/kf-cuanschutz/AMC-HPC-documentation/blob/main/Globus-local-entry-point-files/8.png)

* Double click on the Globus icon to launch the Application:   ![image](https://github.com/kf-cuanschutz/AMC-HPC-documentation/blob/main/Globus-local-entry-point-files/9.png)


### Step 5: Log in and create and endpoint 

* Click on the button shown below to login.
  
  
  ![image](https://github.com/kf-cuanschutz/AMC-HPC-documentation/blob/main/Globus-local-entry-point-files/10.png)


* A page will open on the Browser so that you create a label for future reference: ![image](https://github.com/kf-cuanschutz/AMC-HPC-documentation/blob/main/Globus-local-entry-point-files/11.png)

* Once you login then your screen on the browser should look similar to this![image](https://github.com/kf-cuanschutz/AMC-HPC-documentation/blob/main/Globus-local-entry-point-files/12.png)

* Create your collection personal endpoint as shown here: ![image](https://github.com/kf-cuanschutz/AMC-HPC-documentation/blob/main/Globus-local-entry-point-files/13.png)

* Once your endpoint collection name setup is successful your screen should look something similar to this ![image](https://github.com/kf-cuanschutz/AMC-HPC-documentation/blob/main/Globus-local-entry-point-files/14.png)

* On the Globus website, you can go to the following tab to verify the end point.
  Here, the endpoint is called “My-MacBook-station-local”. Make sure that the filter tab “Aministered by you” is selected in order to view it ![image](https://github.com/kf-cuanschutz/AMC-HPC-documentation/blob/main/Globus-local-entry-point-files/15.png)

* Note: Again, you can also refer to the original [Globus](https://docs.globus.org/how-to/globus-connect-personal-mac/) page for more reference.


### Step 6: Confirm that you are logged into Globus with the common credentials

* Under the "Settings" tab, your Identity should follow the follow this format: myalpineusername@access-ci.org.
  With "myalpineusername" being the actual username that you use to log into Alpine. ![image](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Globus_tutorial_update/7.png)


### Step 7: Reopen your Personal endpoint and select the local folder that you wish to transfer.

* Go back to your personal endpoint by selecting on the left side of the screen "Collections" and then "Administered by you"


* Select "Open in File Manager". ![image](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Globus_tutorial_update/8.png)


* This will open a File Manager window. From there, confirm that your are using your personal endpoint/Collection and select the folder that you wish to transfer.
  The screenshot below shows that we are trying to transfer a local folder called "CUDNN".  ![image](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Globus_tutorial_update/9.png)


### Step 8: Open the Alpine Collection and make the transfer


* On the right side of the screen, select "Transfer or Sync to.." ![image](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Globus_tutorial_update/10.png)



* Then click on the search bar on the right to look for the Alpine endpoint ![image](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Globus_tutorial_update/11.png)



* Under Collection, enter "CU Boulder Research Computing" ![image](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Globus_tutorial_update/12.png)


* Finally, enter the Alpine path where you wish to transfer the dataset. Here, we are transfering the dataset to /projects/myalpineusername@xsede.org.org.
  With "myalpineusername" being the actual username that you use to log into Alpine. ![image](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Globus_tutorial_update/13.png)


* To begin the transfer, select the blue "Start" button on the left, as here we are transferring data from our local system to Alpine.
  If we wished to do the opposite, we would have selected the the blue "Start" button on the right.


### FAQ:

#### How can I share my folder on Alpine with someone from another institution?

   In order to achieve that one will have to create a guest collection. Make sure that the collaborator who wants to access your path has access to Globus.
   This methods works for Petalibrary allocations. Please follow the procedure [here](https://github.com/kf-cuanschutz/CU-Anschutz-HPC-documentation/blob/main/Globus-guest-collection-files/Presentation_Globus_guest_collection_v2.pdf)
   in order to create a guest collection on Alpine.





 
