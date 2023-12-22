#!/bin/bash
. ./DBprocesses/list_db.sh
PS3="Enter your operation: "
if [ "$x" -ne 1 ]
then
        read -p "Enter the database you want to connect: " dbname
        if [ -z "$dbname" ]
        then
                echo "Error: you cannot enter empty value.please enter a valid name."
        elif [ -d /home/malak/DBMS_proj/$dbname ]
        then
        	echo "----------------------------------------------"
		echo "          Database: ($dbname) Menu"
            	echo "----------------------------------------------"
		select choice in "Create a Table" "List Tables" "Drop a Table" "Insert In a Table" "Delete From a Table" "Update To a Table" "Select From a Table" "Exit"
	        do
			case $REPLY in
				1 )	./TBprocesses/create_tb.sh $dbname
					;;
				2 )	./TBprocesses/list_tb.sh $dbname
					;;
				3 )  	./TBprocesses/drop_tb.sh $dbname
					;;
				4 )	./TBprocesses/insert_tb.sh $dbname
					;;
				5 )  	./TBprocesses/delete_tb.sh $dbname
					;;
				6 )	./TBprocesses/update_tb.sh $dbname
					;;
				7 ) 	./TBprocesses/select_tb.sh $dbname
					;;
				8 )	echo "Exiting Database ($dbname) Menu. Goodbye!"
					exit
					;;
				* ) 	echo "($REPLY) is not on the menu"
					;;
			esac
			echo "Press enter to show the database ($dbname) menu again....."
		done
	else
		echo "The database ($dbname) does not exist"
	fi
fi
