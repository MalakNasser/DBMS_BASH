#!/bin/bash
. ./DBprocesses/list_db.sh
if [ "$x" -ne 1 ]
then 
	read -p "Enter the database you want to delete: " dbname
	if [ -z "$dbname" ]
	then
        	echo "Error: you cannot enter empty value.please enter a valid name."
	elif [ -d /home/malak/DBMS_proj/$dbname ]
	then
		read -p "Are you sure you want to delete this database? y/n: " choice
		case $choice in
			[Yy]* ) 
				rm -r /home/malak/DBMS_proj/$dbname  
				echo "The database ($dbname) has been deleted"
				;;
			[Nn]* ) 
				echo "Operation Canceled"
				;;
			* ) 
				echo "Invalid Input"
				;;
		esac	
	else
		echo "The database ($dbname) does not exist"
	fi
fi
