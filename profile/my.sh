#!/bin/bash
#echo hi
if  [ ${UID} = 0 ]; then
	#fortune > /etc/motd
	echo>/dev/null
else
	export PATH=~/sh:/usr/sbin:/sbin:$PATH
fi

export LESSCOLOR=yes
