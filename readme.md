This is a simple bash script that is designed to automate certain 
aspects of AUR package maintenance.

At this point, it is mostly usable, although there are a few things
that will need to be developed. For example, the bash scripts
should use pwd to reference their location. That way, it won't
matter if they are contained in the AUR directory, or another
directory.

Secondly, the repositories should be maintained in /usr/local/src/AUR.

Thirdly, I plan to add another bash script that configures checkup and
update so that they are added to path (I'm new to bash, so I'm not 
entirely familiar with the terminology). In other words, all you would
need to do is type in "checkup" and "update". To that extent, ignore
checkup.sh, because it is wrong when it tells you that you can simply
run update.

Another possible update may include cases where an empty repository is
cloned. This would indicate that the name of the package does not match
the repository name (I have seen this happen in rare cases).

Finally, I plan to add some more comments in order to better explain some
aspects of the scripts.

Finally, there are a few words about usage:
Currently, the update directory must be within the AUR directory. The 
program won't work properly otherwise.

In addition, the primary means of getting the html information (this is
done in order to get version info) is through wget. I also have a commented
line that uses curl instead of wget. If one wishes to use curl instead, they
can find the instruction in "getsiteversion.sh".

As far as running the program is concerned, it is designed so that only two 
scripts need to be called by the user: "checkup.sh" and "update.sh". No
arguments need to be supplied.

That being said, this isn't a very smart program. There are many different
ways that it can fail. For that reason, update will tee any makepkg
information to the appropriate directory in log (the name of the file will
be based on the date). If something breaks, you can find information there.
In addition, all of the information that the scripts themselves provide by
way of echo are sent into logs in the update directory (affectionately 
referred to as "updatelogs"). 

I believe that should be everything you need to know. Have fun and let me
know if there's anything I should improve.

