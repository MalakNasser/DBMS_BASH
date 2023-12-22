#!/bin/bash
. ./TBprocesses/list_tb.sh
PS3="What do you want to select: "
if [ "$x" -ne 1 ]
then
	read -p "Enter table name: " selecttb
        if [[ -f /home/malak/DBMS_proj/$1/$selecttb ]]
	then
		typeset -i nf=$(awk -F: '{if(NR==1){print NF}}' "/home/malak/DBMS_proj/$1/$selecttb")

		select choice in "Select all" "Select Column" "Select Record" "Done"
		do
                case $REPLY in
                        1 )	for (( i = 1; i <= nf; i++ ))
 		               	do
					field=`awk -F: -v"i=$i" '{if(NR==1){print $i}}' "/home/malak/DBMS_proj/$1/$selecttb";`
                        		colname=$(echo "$field" | awk -F- '{print $1}')
					if [[ $i -eq $nf ]]
 			       		then
              					echo "$colname"
        				else
               			 		echo -n "$colname:"
        				fi
				done
			   	awk 'NR > 1' "/home/malak/DBMS_proj/$1/$selecttb" 
				;;

                        2 )	read -p "Enter column name you want to select: " col

				for (( i = 1; i <= nf; i++ ))
 		                do
	
        	        	        field=`awk -F: -v"i=$i" '{if(NR==1){print $i}}' "/home/malak/DBMS_proj/$1/$selecttb";`
                	         	colname=$(echo "$field" | awk -F- '{print $1}')
					var=0
					if [[ "$colname" ==  "$col" ]]
                	        	then
						echo $col
						cut -f$i -d: "/home/malak/DBMS_proj/$1/$selecttb" | sed '1d' 
						var=1
						break
					fi
				done
				if [[ $var != 1 ]]
				then
					echo "($col) is not a valid column"	
				fi
				;;
                       	 3 )
				read -p "Enter column name you want to search with: " col
             			var=0
                		for (( i = 1; i <= nf; i++ ))
                		do
                		        field=`awk -F: -v"i=$i" '{if(NR==1){print $i}}' "/home/malak/DBMS_proj/$1/$selecttb";`
                      			colname=$(echo "$field" | awk -F- '{print $1}')
                		        if [[ "$colname" ==  "$col" ]]
                        		then
                               		 	var=$i
                                	break
                        	fi
                		done

                		if [ $var -eq 0 ]
                		then
					echo "($col) is not a valid column"
                		else
			        	read -p "Enter value to select its record: " val

                       			typeset -i nr=$(($(wc -l < "/home/malak/DBMS_proj/$1/$selecttb")))
					flag_found=0
                        		
					for (( i = 2; i <= nr; i++ ))
                        		do
                                		if [[ "$val" = $(sed -n "${i}p" "/home/malak/DBMS_proj/$1/$selecttb" | cut -f "$var" -d ":") ]]
                               			then
                                			sed -n "${i}p" "/home/malak/DBMS_proj/$1/$selecttb"
							flag_found=1

                                		fi
                       		 	done
					if [[ $flag_found != 1 ]]
					then
						echo "$val is not in the table"
					fi	
                		fi

				;;
			4 )	exit
				;;
                        * )
                                echo Invalid input
 		esac
		done
	else
		"echo The table ($selecttb) is not there"
	fi

fi
