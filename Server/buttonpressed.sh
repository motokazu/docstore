#!/bin/sh

LOCKFILE="/tmp/copy.lock"

SCANDIR="/var/scaned/"
SCANFILE="`date +%Y-%m-%d_%H:%M:%S`.png"

case $1 in
	1)
		echo "button 1 has been pressed on $2"
		 if [ -f $LOCKFILE ]; then
		   echo "Error: Another scanning operation is currently in progress" | festival --tts
		   exit
		 fi
		 touch $LOCKFILE

		 echo "Scanning"
		 if [ -d ${SCANDIR} ] ;then
		 scanimage -p --format=tiff --resolution=100 -x 210 -y 297 > ${SCANDIR}${SCANFILE}
		 # post to couch
		 /usr/local/bin/postcouch.sh ${SCANDIR}${SCANFILE}

		 else
		 echo "Can not find directory : ${SCANDIR}"
		 fi

		 if [ $? != 0 ]; then
		 	echo "Scanning failed" 
		 	rm $LOCKFILE
		 	exit
		 fi
		 echo "The scan job has been finished"
		 rm -f $LOCKFILE
		;;
	2)
		echo "button 2 has been pressed on $2"
		;;
	3)
		echo "button 3 has been pressed on $2"
		;;
	4)
		echo "button 4 has been pressed on $2"
		;;
esac

