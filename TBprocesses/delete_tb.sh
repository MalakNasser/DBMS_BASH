#!/bin/bash
. ./TBprocesses/list_tb.sh
if [ "$x" -ne 1 ]
then
        read -p "Enter table name: " deletetb
        if [[ -f /home/malak/DBMS_proj/$1/$deletetb ]]
        then
		typeset -i nf=$(awk -F: '{if(NR==1){print NF}}' "/home/malak/DBMS_proj/$1/$deletetb")
		read -p "Enter the column you want to search in:  " del_col;
		
		var=0
                for (( i = 1; i <= nf; i++ ))
                do
			field=`awk -F: -v"i=$i" '{if(NR==1){print $i}}' "/home/malak/DBMS_proj/$1/$deletetb";`
          	     	colname=$(echo "$field" | awk -F- '{print $1}')
			if [[ "$colname" ==  "$del_col" ]]
			then
				var=$i
				break
			fi	
		done

		if [ $var -eq 0 ]
		then
               	echo "$del_col is not a valid column"
		else
			read -p "Enter value to delete its record: " del_val

			typeset -i nr=$(($(wc -l < "/home/malak/DBMS_proj/$1/$deletetb")))
			typeset -i count=0;

			for (( i = 2; i <= nr; i++ ))
			do
       		     		if [[ "$del_val" = $(sed -n "${i}p" "/home/malak/DBMS_proj/$1/$deletetb" | cut -f "$var" -d ":") ]]
				then
				
				sed -n "${i}p" "/home/malak/DBMS_proj/$1/$deletetb"

				read -p "Is that the record you want to delete? y/n: " choice
                		case $choice in
                        	[Yy]* )
                        	        sed -i "${i}d" "/home/malak/DBMS_proj/$1/$deletetb"
					((count++))
					((i--))
					;;
                        	[Nn]* )
                               		echo "Operation Canceled"
                                	;;
                       		 * )
                                	echo "Invalid Input"
                                	;;
                		esac
				fi
       		done
			cat "/home/malak/DBMS_proj/$1/$deletetb"
			echo $count record'(s)' has been deleted
		fi
	else
		echo "$deletetb does not exist"
	fi
fi
