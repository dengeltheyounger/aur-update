This program is fairly simple. checkup.sh will automates the process of checking for
updates. If needed, it will also perform a first time setup. update.sh will go through
the process of updating each package within the repository. 

This is not a very smart script. If there are any errors, the most it will do is tell
you. Given how dumb it is, it keeps numerous logs so that in the case of an error, you
will be able to go through and see it. The logs for the AUR repositories will be kept in
a log directory within the AUR directory. The script logs will be kept within a log 
directory in the aur-update repository itself. 

I have made numerous changes since the last commit. At this point, the AUR repository 
and the aur-update repositories are independent. The bash scripts do not need them to 
to be in certain locations in relation to one another (for example, the aur-update repo
does not need to be location within the AUR directory). 

If you wish to change the location of the AUR repositories, you will need to alter 
all of the scripts so that they know the new path. Luckily, you will only need to change
the paths once, since each path is hardcoded as a variable at the beginning of the
script. Nevertheless, that's still tedious. 

For this reason, I will be planning to use a config file that will allow the user to
specify once the location of the repository. This is partially implemented, but most
of the scripts will expect the location to be "/usr/src/AUR". 

You will need to manually add checkup and update to path.
