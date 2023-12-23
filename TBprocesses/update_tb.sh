. ./TBprocesses/list_tb.sh
PS3="What do you want to update: "
if [ "$x" -ne 1 ]
then
        read -p "Enter table name: " updatetb
        if [[ -f /home/malak/DBMS_proj/$1/$updatetb ]]
        then
                typeset -i nf=$(awk -F: '{if(NR==1){print NF}}' "/home/malak/DBMS_proj/$1/$updatetb")
                read -p "Enter the column you want to search in: " update_col;

                var=0
                for (( i = 1; i <= nf; i++ ))
                do
                        field=`awk -F: -v"i=$i" '{if(NR==1){print $i}}' "/home/malak/DBMS_proj/$1/$updatetb";`
                        colname=$(echo "$field" | awk -F- '{print $1}')
                        if [[ "$colname" ==  "$update_col" ]]
                        then
                                var=$i
                                break
                        fi
                done

                if [ $var -eq 0 ]
                then
                   	echo "$update_col is not a valid column"
                else

                	read -p "Enter the value to search with: " val
			flag_found=0
			typeset -i nr=$(($(wc -l < "/home/malak/DBMS_proj/$1/$updatetb")))

                	select choice in "Update all" "Update specific record"
			do
				case $REPLY in        
				1 )	

					field_num=0
					for (( i = 2; i <= nr; i++ ))
                        		do
						if [[ "$val" = $(sed -n "${i}p" "/home/malak/DBMS_proj/$1/$updatetb" | cut -f "$var" -d ":") ]]
                                		then
                                			flag_found=1
                                                
					        	if [[ $field_num -eq 0 ]]
							then
								read -p "Enter the field you want to update: " field_name
								flag_stp=1
							fi

							for (( j = 1; j<= nf; j++ ))
							do
								field=`awk -F: -v"j=$j" '{if(NR==1){print $j}}' "/home/malak/DBMS_proj/$1/$updatetb";`
								if [[ $field_name == $(echo "$field" | awk -F- '{print $1}') ]]
								then
									field_num=$j
									break
								fi
							done
							if [ $field_num != 0 ]
							then
								field=`awk -F: -v"i=$field_num" '{if(NR==1){print $i}}' "/home/malak/DBMS_proj/$1/$updatetb";`
								colname=$(echo "$field" | awk -F- '{print $1}')
								coltype=$(echo "$field" | awk -F- '{print $2}')
								flag=0;
                        					while [[ $flag -eq 0 ]]
                        					do
                                					if [[ $field_num -eq 1 ]]
									then
										echo "$field_name is a primary key you can not update all"
										break 2

									elif [[ $flag_stp -eq 1 ]]
									then
                                						read -p "Enter the new value: " new_val
										flag_stp=0

									fi

                               						if [[ $coltype = "int" && "$new_val" = +([0-9]) || $coltype = "string" && "$new_val" = +([a-zA-Z]) ]]
                                					then
										old_val=$(sed -n "${i}p" "/home/malak/DBMS_proj/$1/$updatetb" | cut -f$field_num -d:)
										sed -i "${i}s/$old_val/$new_val/" "/home/malak/DBMS_proj/$1/$updatetb"
										flag=1
                                					fi
                        					done
							else
								echo "Invalid field"
							fi
						fi	
					done
					if [[ $flag_found != 1 ]]
                        		then
                                		echo "$val is not in the table"
                        		fi
                        		if [[ $flag -eq 1 ]]
                        		then
                                		echo "The Table is updated successfully"
                        		fi
					exit
					;;
				2 )
			
					for (( i = 2; i <= nr; i++ ))
                			do
						if [[ "$val" = $(sed -n "${i}p" "/home/malak/DBMS_proj/$1/$updatetb" | cut -f "$var" -d ":") ]]
        	                        	then
							sed -n "${i}p" "/home/malak/DBMS_proj/$1/$updatetb"
                	                		flag_found=1
					
							read -p "Is that the record you want to update in? y/n: " choice
	
	                                		case $choice in
        	                       			[Yy]* )
                                                
						    		read -p "Enter the field you want to update: " field_name
								field_num=0
								for (( j = 1; j<= nf; j++ ))
								do
									field=`awk -F: -v"j=$j" '{if(NR==1){print $j}}' "/home/malak/DBMS_proj/$1/$updatetb";`
									if [[ $field_name == $(echo "$field" | awk -F- '{print $1}') ]]
									then
										field_num=$j
										break
									fi
								done
								if [ $field_num != 0 ]
								then
									field=`awk -F: -v"i=$field_num" '{if(NR==1){print $i}}' "/home/malak/DBMS_proj/$1/$updatetb";`
									colname=$(echo "$field" | awk -F- '{print $1}')
									coltype=$(echo "$field" | awk -F- '{print $2}')
									flag=0;
                		        				while [[ $flag -eq 0 ]]
                        						do
                        	        					if [[ $field_num -eq 1 ]]
										then
											read -p "Enter the new value: " new_val

                                      							if grep -q "^$new_val:" "/home/malak/DBMS_proj/$1/$updatetb"
                                	        					then
                                        				        		echo "Error: Value for $colname (primary key)is already present. Choose a different value."
                                                						continue
											fi
										else
                                							read -p "Enter the new value: " new_val
		
										fi

                        	       						if [[ $coltype = "int" && "$new_val" = +([0-9]) || $coltype = "string" && "$new_val" = +([a-zA-Z]) ]]
                    	        		    				then
											old_val=$(sed -n "${i}p" "/home/malak/DBMS_proj/$1/$updatetb" | cut -f$field_num -d:)
											sed -i "${i}s/$old_val/$new_val/" "/home/malak/DBMS_proj/$1/$updatetb"
											flag=1
			
        	        	                				fi
                	        					done
								else
									echo "Invalid field"
								fi
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
					if [[ $flag_found != 1 ]]
                       			then
                                		echo "$val is not in the table"
                        		fi
                      			if [[ $flag -eq 1 ]]
                       			then
                               			 echo "The Table is updated successfully"
                        		fi
					exit
					;;
				* ) 
					echo "Invalid Input"
					;;
				esac
			done
	fi
        else
                echo "$updatetb does not exist"
        fi
fi
