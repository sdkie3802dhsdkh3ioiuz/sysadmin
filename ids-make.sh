#!/bin/ksh
DSTDIR=$1
SEED=$2
HOST=`/bin/hostname | /usr/bin/cut -d. -f1`
DATE=`/bin/date +%Y-%m-%d-%H-%M`
DIR=$DSTDIR/$HOST/mtreedatabase/$DATE
for i in etc bin sbin usr/bin usr/sbin usr/local ; \
	do /bin/mkdir -p $DIR/$i && \
	/bin/chmod 700 $DIR/$i && \
	/usr/bin/touch $DIR/$i/mtree && \
	/bin/chmod 400 $DIR/$i/mtree && \
	/usr/sbin/mtree -c -K \
	cksum,sha1digest,rmd160digest,sha256digest,flags -s $SEED \
	-p /$i >$DIR/$i/mtree && \
	/usr/bin/touch $DIR/$i/mtree.sha256 && \
	/bin/chmod 400 $DIR/$i/mtree.sha256 && \
	/bin/sha256 $DIR/$i/mtree >$DIR/$i/mtree.sha256 ; \
	done 
