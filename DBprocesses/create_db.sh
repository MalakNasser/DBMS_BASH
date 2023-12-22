#!/bin/bash
read -p "Enter DBname: " dbname
if [ -z "$dbname" ] || [[ "$dbname" =~ [/.:\|\-] ]]
then  
      	echo "Error: Database name cannot be empty or have special characters. Please enter a valid name."
elif [ -d /home/malak/DBMS_proj/$dbname ] 
then 
	echo "The Database ($dbname) already exists"
else	
	mkdir /home/malak/DBMS_proj/$dbname
	echo "The database ($dbname) is created successfully"
fi
