#!/bin/bash
directory="/home/malak/DBMS_proj/$1"
x=0
if [ -z "$(ls "$directory")"  ]
then
        echo "There are no tables"
        x=1
else
	echo "Tables available in the database ($1):  "
        ls  "$directory"
fi
export x
