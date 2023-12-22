#!/bin/bash
. ./TBprocesses/list_tb.sh
if [ "$x" -ne 1 ]
then
	read -p "Enter the table name: " inserttb
	if [[ -f /home/malak/DBMS_proj/$1/$inserttb ]]
	then
		cat "/home/malak/DBMS_proj/$1/$inserttb" 
		typeset -i nf=$(awk -F: '{if(NR==1){print NF}}' "/home/malak/DBMS_proj/$1/$inserttb")
		for (( i = 1; i <= nf; i++ ))
		do
			field=`awk -F: -v"i=$i" '{if(NR==1){print $i}}' "/home/malak/DBMS_proj/$1/$inserttb";`
			colname=$(echo "$field" | awk -F- '{print $1}')
            		coltype=$(echo "$field" | awk -F- '{print $2}')
			flag=0

	 		while [[ $flag -eq 0 ]]
			do
	 			if [[ $i -eq 1 ]]
				then
					read -p "Enter ($colname) value (must not be repeated): " value
                    			if grep -q "^$value:" "/home/malak/DBMS_proj/$1/$inserttb"
					then
						echo "Error: Value for $colname (primary key) is already present. Choose a different value."
                        			continue
                    			fi
                		else
					read -p "Enter ($colname) value: " value
                		fi

		 		if [[ $coltype = "int" && "$value" = +([0-9]) || $coltype = "string" && "$value" = +([a-zA-Z]) ]]
				then
					if [[ $i != $nf ]]
					then
		 				echo -n $value: >> /home/malak/DBMS_proj/$1/$inserttb
		 			else	
		 				echo $value >> /home/malak/DBMS_proj/$1/$inserttb
					fi
		 			flag=1
				fi
	 		done
		done
	else
		echo "The table ($inserttb) does not exist"
	fi
fi
