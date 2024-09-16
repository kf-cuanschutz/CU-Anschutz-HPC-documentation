# Dorado Installation Guide

This guide is to demonstrate how to install Dorado as a module on Alpine. The module created is a personal one; unique to the user that installs it.

If there is enough demand for Dorado, it can be turned into a public module available to all Alpine users. For more information about Dorado on Alpine, feel free to reach out to hpcsupport@cuanschutz.edu.

## Part 1: Unpacking the tarball

The first few steps follow Dorado's own installation guide found here:
*[Dorado Github](https://github.com/nanoporetech/dorado)*

Download the linux-x64 tarball from Dorado's github above and uploading it to your /projects/ directory.
Once that's done, change directories to /projects/$USER and run the following command:
`
  tar -xvzf dorado-0.7.2-linux-x64.tar.gz ''
`
(Rename with correct tar file name if necessary)

This should create a directory called dorado-<VERSION>-linux-x64, with two subdirectories; "bin/" and "lib/".

## Part 2: Creating the Lua file

Now it's time to create the module file for dorado.
First, you need to make a directory for lua files in your /projects/$USER/ folder:
```
cd /projects/$USER
mkdir lua
cd lua
mkdir dorado
```
<br>
Once inside the dorado folder, make a file with the format <version_name>.lua. For the example from part 1, it would be 0.7.2.lua. An easy way to create the file is with the command `touch 0.7.2.lua`.

Next, add the following lines of code to the lua file:
```
-- This module loads Dorado
-- Set local variables
local PACKAGE_PREFIX = "/projects/<YOUR_USERNAME>@xsede.org/dorado_testing/dorado-0.7.2-linux-x64/"
local USER = os.getenv("USER")
-- Load dependencies
always_load("python")
-- Set Paths
prepend_path("LD_LIBRARY_PATH", pathJoin(PACKAGE_PREFIX, "lib"))
prepend_path("PATH", pathJoin(PACKAGE_PREFIX, "bin"))
prepend_path("PATH", pathJoin(PACKAGE_PREFIX, "lib"))
-- Software info:
help([[
Dorado:
Dorado is a high-performance, easy-to-use, open source basecaller for Oxford Nanopore reads.
For detailed instructions, go to:
https://github.com/nanoporetech/dorado
]])
whatis("Version: 0.7.2")
```
Be sure to replace <YOUR_USERNAME> with your Alpine username and change the version number and paths as needed.

The last part of this step is to append this new module file to your module file paths.
To do so, edit your .bash_profile (located in your /home/ directory) and add the following line:

`
module use --append /projects/<YOUR_USERNAME>@xsede.org/lua
`
Be sure to replace the <YOUR_USERNAME> portion with your Alpine username.

Dorado should now be ready to go!

