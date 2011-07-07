#!/bin/sh

cd `dirname $0`
F=`pwd |sed -e "s#$HOME/\?##"`

for P in *
do
   # skip setup
   if [ "$P" = "setup.sh" ]; then continue; fi

   # ensure permissions
   chmod -R o-rwx,g-rwx $P

   # skip existing links
   if [ -h "$HOME/.$P" ]; then continue; fi

   # move existing dir out of the way
   if [ -e "$HOME/.$P" ]; then
       if [ -e "$HOME/__$P" ]; then
           echo "want to override $HOME/.$P but backup exists"
           continue;
       fi

       echo -n "Backup "
       mv -v "$HOME/.$P" "$HOME/__$P"
   fi

   # create link
   echo -n "Link "
   ln -v -s "$F/$P" "$HOME/.$P"
done

