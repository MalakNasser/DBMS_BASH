#!/bin/bash
. ./TBprocesses/list_tb.sh
if [ "$x" -ne 1 ]
then
        read -p "Enter the table  you want to delete: " tbname
        if [ -z "$tbname" ]
        then
                echo "Error: you cannot enter empty value.please enter a valid name."
        elif [ -f /home/malak/DBMS_proj/$1/$tbname ]
        then
                read -p "Are you sure you want to delete this table? y/n: " choice
                case $choice in
                        [Yy]* )
                                rm /home/malak/DBMS_proj/$1/$tbname
                                echo "($tbname) has been deleted"
                                ;;
                        [Nn]* )
                                echo "Operation Canceled"
                                ;;
                        * )
                                echo "Invalid Input"
                                ;;
                esac
        else
		echo "The table ($tbname) does not exist"
        fi
fi
