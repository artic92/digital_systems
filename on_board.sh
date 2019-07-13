#!/bin/bash

BOARD=Nexys2

case $1 in
	"init")
		djtgcfg enum
		djtgcfg init -d $BOARD
		;;
	"prog")
		djtgcfg prog -i 0 -d $BOARD -f $2
		;;
	"all")
		djtgcfg enum
		djtgcfg	init -d $BOARD
		djtgcfg prog -i 0 -d $BOARD -f $2
		;;
	*)
		echo "Please select an option (init, prog, all)!" ;;
esac
