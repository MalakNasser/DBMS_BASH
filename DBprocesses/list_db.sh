#!/bin/bash
directory="/home/malak/DBMS_proj"
x=0
if [ -z "$(ls -l "$directory" | grep '^d')"  ]
then
	echo "There are no databases"
	x=1
else
	echo "Available DataBases: "
	ls -l "$directory" | grep '^d' | awk '{print $NF}'
fi
export x
