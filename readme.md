This program is fairly simple. aur-update.sh is the script that is intended to be
executed. This program will allow you to check for updates, move the AUR respositories,
and update. The -C option checks for updates. The -M moves the repositories, but will
need a destination parameter. -U performs the updates. 

By default, the AUR repositories will be maintained in /usr/local/src/AUR. This is
specifically defined in .aurconfig, which is created by checkup.sh The location of the
repositories can be changed after the first time setup using the -M option.
Alternatively, you can alter checkup.sh before the first time run in order to define 
where the AUR repositories are to be first created (or where to find them if you already
maintain the repositories yourself).

I have not implemented the verbose option yet. This will come in a future commit.

Some future plans:
I plan to have two different versions of this project. One will have only the ability to
check for updates and update. There will be no aur-update.sh script. Instead, the user
will have to run checkup and update manually. This version will give up functionality 
in order to stay simple and lightweight.

The version that I am currently working towards is designed to be scalable. It will be
more heavy weight but will also have the capacity to feature many different options. I 
may add options to download packages from the AUR as well as error handling features. 

Finally, I plan to add an installer in a future version. The installer will consolidate
all of the scripts into a single one, and then will move the consolidated script into
/usr/bin. The aur-update repository and scripts will remain, however, in case the user
would like to examine the source code. Moreover, I intend for the program to runnable
with or without the installer. This is intended to allow some flexibility for the user.
If there are any issues or expansions in functionality you would like to see, let me 
know.

Change log:
03/01/2020
	Made heavy revisions to lastupdate.sh and getsiteversion.sh. Instead of using curl, 
	they pull from the PKGBUILD. getsiteversion does a git pull. If the repo is already 
	up to date, the check is much quicker than with curl. It'll take longer if the repo
	is out of date. This will be fine for most users, however, since they will want to 
	update anyway.

06/04/2020
	getsiteversion.sh had some bugs in it that I removed.
	
