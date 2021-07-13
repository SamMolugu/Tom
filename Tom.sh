#Aurthor: Sadruth Molugu
# Last Updated: 1/11/2017
#!/bin/bash
################################################################################
#Program name Tom.sh

#Purpose is to make some basic functions on linux os convenient for the user.

#current implement functions:: 
#introduction 
#Check function, read function, close function, open function, shutdown functions, nickname function, scan function, task manager, install function, remove functioin
###############################################################################
# Lists all the functionality of application
function tom
{
	echo "Seems like you are lost"
	echo "Let me give you a list of the current functions I have"
	echo " "
	echo "check--------------"
	echo "weather::gmail::hotmail::gmumail::calender::weather"
	echo "process------------------"
	echo "display(task manager)::end(an application)::pewpew(close by clicking running application)"
	echo "close-----------------"
	echo "close everything then log-out"
	echo "scan---------------"
	echo "read a file without opening"
	echo "shutdown----------------"
	echo "turn off computer"
	echo "nickname-----------------"
	echo "if you want me to call you something else"
	echo "install--------------------"
	echo "to install a file"
	echo "remove--------------------"
	echo "to remove a file and all its contents"
	echo "quit--------------------"
	echo "exit program"
}
# All functions that involve opening another application
function check  
{
echo What would you like to check?
read ANS 
case $ANS in
	gmail)
		 (firefox https://www.google.com/gmail/about/ &> /dev/null &);;
	hotmail)
		(firefox https://login.live.com/login.srf?wa=wsignin1.0&rpsnv=13&ct=1487634557&rver=6.4.6456.0&wp=MBI_SSL_SHARED&wreply=https:%2F%2Fmail.live.com%2Fdefault.aspx&lc=1033&id=64855&mkt=en-us&cbcxt=mai &> /dev/null &);;		
	calender)
		cal;;
	weather)
		(firefox https://weather.com/weather/today/l/USVA0137:1:US &> /dev/null &);;
	*)
		echo "Sorry, I can't do that"
esac
}

# Simple function to end all running processes and to log-out
function closeAll
{
	killall5 -9
}

# Read a file without opening (.txt, pdf,ex..)
function scan 
{
	echo "Enter name of file:"
	read fileName
	echo "--------------------------------------------------------"
		locate $fileName | xargs cat
	echo "--------------------------------------------------------"	
	echo "Do you want to add to this file?"
        read reply
        if [ "$reply" == "yes" ]; then
		vim "$(locate $fileName)"
	else 
		echo "Hope I helped"
        fi
}

# Start an application
function open 
{
	echo Which application would you like to open?
	read ANS
	case $ANS in 
		ps2)
			(PCSX2 &> /dev/null &);;
		chess)
			(pychess &> /dev/null &);;
		$ANS)
			($ANS &> /dev/null &);;

		*) 
			echo "Sorry, I coudn't find that application"
	esac	
}

# System shutdown
function shutDown 
{
	shutdown -h now
}

# Task manager function 
function taskMan
{
	declare -i lie=0
	#rough implementaion of a task manager, made from scratch
	echo "Do you need me to list your current running processes?"
	read reply
	if [ "$reply" == "yes" ]; then
		$lie=1
		htop #top
	fi
	if [ "$reply" == "no" ]; then
	{
	echo "Ok, then what would you like to do?"
	read ANS
	case $ANS in 
		display)
			if [ "$lie" -eq "0" ]; then
				echo "Could have said that the first time."
			fi	
			htop;;
		end)
			echo "What program do you want to end?"
			read target
			pkill $target;;
		pewpew)
			echo "Press ctrl + c to stop.."
			xkill;;
		*)
			echo "Sorry, I can't do that"
	esac
	}
fi
}

# Function to change current username
function nickName
{
	echo Enter a new username: 
	read nUSER
	usermod -l $nUSER $USER
	usermod -d /home/newHomeDir -m $nUSER
}

#Function to insatall an file/application
function install
{
	echo "What file do you want to install?"
	read fileName
	sudo apt install $fileName
	#try catch if filename is not found
}

#Function to remove a file/application
function remove
{
	echo "What would you like to remove?"
	read fileName
	sudo apt-get --purge remove $fileName
	#try catch if filename is not found
}

echo "Hello I am tom, welcome $USER"
echo "What can I do for you today?"
declare -i fCounter=0
declare -i counter=0
while true
do
read ANS
counter=$counter+1
	case $ANS in
		check)
			check;;
		close)
			closeAll;;
		scan)
			scan;;
		open)
			open;;
		shutdown)
			shutDown;;
		nickname)
			nickName;;
		install)
			install;;
		remove)
			remove;;
		youtube)
			(firefox www.youtube.com &> /dev/null &);;
		process) 
			taskMan;;
		quit)
			echo "Goodbye, $USER"
		break;;
		*)
			echo "Sorry, I can't do that"
			fCounter=$fCounter+1
			if [ "$fCounter" -eq "3" ]; then
				echo " "
				tom
				fCounter=0
				echo " "
			fi 		
	esac
	echo "Anything else?"
done
#echo total number of uses: $counter
