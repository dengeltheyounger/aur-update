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

One of the newest additions is a simpler way to move the repository if you wish. 
Included in the bash project is a file called "moverepo.sh". The proper way to use this
script is give it a path to move the AUR directory to as an argument. moverepo will do 
two things: firstly, it will move the repository. Secondly, it will amend the .aurconfig
file so that all of the other scripts know the new path of the AUR directory.

You will need to manually add checkup and update to path.
