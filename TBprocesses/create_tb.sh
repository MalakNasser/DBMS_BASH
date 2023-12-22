#!/bin/bash
read -p "Enter Table Name: " tbname

if [ -z "$tbname" ] || [[ "$tbname" =~ [/.:\|\-] ]]
then
        echo "Error: table name cannot be empty or have special characters. Please enter a valid name."

elif [[ -f //home/malak/DBMS_proj/$1/$tbname ]]
then
	echo "Table ($tbname) already exists"
else
	touch /home/malak/DBMS_proj/$1/$tbname
	read -p "Enter No of columns: " n

	for (( i = 1; i <= n; i++ )) 
	do
		if [[ i -eq 1 ]]
		then
			echo "The first column is the primary key"
		fi
		read -p "Enter column $i name : " name
		read -p "Enter column datatype : [string/int] " dtype
		while [[ ! "$dtype" =~ "string" && ! "$dtype" =~ "int" ]] || [ -z "$dtype" ]
	       	do
			echo "Invalid datatype"
			read -p "Enter column datatype: [string/int] " dtype
		done
	if [[ $i -eq $n ]]
	then
    		echo "$name-$dtype" >> "/home/malak/DBMS_proj/$1/$tbname"
	else
    		echo -n "$name-$dtype:" >> "/home/malak/DBMS_proj/$1/$tbname"
	fi
	done
	
	echo "($tbname) table has been created in the ($1) database"
fi
