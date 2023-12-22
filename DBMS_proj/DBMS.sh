#!/bin/bash
clear
echo "##############################################"
echo "#       Welcome to Database Management       #"
echo "#--------------------------------------------#"
PS3="Enter your choice: "
while true
do
	select choice in "Create a DataBase" "List DataBases" "Connect To a DataBase" "Drop a DataBase" "Exit"
	do
		case $REPLY in
			1 )  	./DBprocesses/create_db.sh
				echo "----------------------------------------------"
				;;
			2 )  	./DBprocesses/list_db.sh 
				echo "----------------------------------------------"
				;;
			3 )  	./TBprocesses/connectto.sh
				echo "----------------------------------------------"
				;;
			4 )  	./DBprocesses/drop_db.sh
				echo "----------------------------------------------"
				;;
			5 )	echo "Exiting Database Management. Goodbye!"
				exit
				;;
			* ) 	echo "($REPLY) is not on the menu"
				echo "----------------------------------------------"
				;;
		esac
		echo "Press enter to show the main menu again....."
	done
done
