#!/bin/bash

echo "Hello to cron service, this script will help you in setting a cron job in Linux"

echo "Now let's get to work. I'll give you five options, choose one of them."
echo "1. Run automatically at some intervals"
echo "2. Run automatically at a particular time"
echo "3. Run automatically on a particular day"
echo "4. Run automatically at a particular date and time"
echo "5. Run automatically on weekdays or weekends"
read -r choice
read -p  "What command do you want to set? Please enter the command:- " command


echo "Do you want this script to be executed with sudo permission or non-sudo?"
read -p "Press 1 for sudo command and 2 for non-sudo command:- " n


if [ "$n" == 1 ]; then
    case $choice in
        1)
            echo "What interval would you like to choose? Enter two values one after another. The first value is for hours, and the second is for minutes. If you don't want any of them, input 0."
            read -r h
            if [ "$h" -ge 24 ]; then
                echo "Oops, there are only 24 hours in a day. Please provide a number between 0 and 23."
                exit 1
            fi
            read -r m
            if [ "$m" -ge 60 ]; then
                echo "Oops, there are only 60 minutes in an hour. Please provide a number between 0 and 59."
                exit 1
            fi
            schedule="$h $m * * *"
            echo "Please enter your password:"
            (sudo crontab -l | grep -v "$command" ; echo "$schedule $command") | { sudo crontab - && echo "Cron job added successfully."; } || echo "Failed to add cron job."
            ;;
        2)
            read -p "Enter the time in HH:MM format" time
            if ! [[ $time =~ ^[0-9]{2}:[0-9]{2}$ ]]; then
                echo "Invalid time format"
                exit 1
            fi
            hour=${time%%:*}
            minute=${time#*:}
            schedule="$minute $hour * * *"
            echo "Please enter your password:"
            (sudo crontab -l | grep -v "$command" ; echo "$schedule $command") | { sudo crontab - && echo "Cron job added successfully."; } || echo "Failed to add cron job."
            ;;
        3)
            read -p "Which day would you like to choose? Enter a number from 1 (Sunday) to 7 (Saturday)" day
            if ((day < 1)) || ((day > 7)); then
                echo "Invalid day"
                exit 1
            fi
            schedule="* * * * $day"
            echo "Please enter your password:"
            (sudo crontab -l | grep -v "$command" ; echo "$schedule $command") | { sudo crontab - && echo "Cron job added successfully."; } || echo "Failed to add cron job."
            ;;
        4)
            read -p "For which date do you want to automate the task? Enter the input in YYYY-MM-DD HH:MM format, e.g., 2000-12-25 04:30" udate
            schedule=$(date -d "$udate" +'%M %H %d %m *')
            echo "Please enter your password:"
            (sudo crontab -l | grep -v "$command" ; echo "$schedule $command") | { sudo crontab - && echo "Cron job added successfully."; } || echo "Failed to add cron job."
            ;;
        5)
            read -p "Press 'd' for weekdays or 'e' for weekends" week
            if [ "$week" == d ]; then
                wday="1-5"
            elif [ "$week" == e ]; then
                wday="6,7"
            else
                echo "Invalid option"
                exit 1
            fi
            schedule="* * * * $wday"
            echo "Please enter your password:"
            (sudo crontab -l | grep -v "$command" ; echo "$schedule $command") | { sudo crontab - && echo "Cron job added successfully."; } || echo "Failed to add cron job."
            ;;
        *)
            echo "Invalid option"
            exit 1
            ;;
    esac

elif [ "$n" == 2 ]; then
    case $choice in
        1)
            echo "What interval would you like to choose? Enter two values one after another. The first value is for hours, and the second is for minutes. If you don't want any of them, input 0."
            read -r h
            if [ "$h" -ge 24 ]; then
                echo "Oops, there are only 24 hours in a day. Please provide a number between 0 and 23."
                exit 1
            fi
            read -r m
            if [ "$m" -ge 60 ]; then
                echo "Oops, there are only 60 minutes in an hour. Please provide a number between 0 and 59."
                exit 1
            fi
            schedule="$h $m * * *"
            (crontab -l | grep -v "$command" ; echo "$schedule $command") | crontab -
            ;;
        2)
            echo "Enter the time in HH:MM format"
            read -r time
            if ! [[ $time =~ ^[0-9]{2}:[0-9]{2}$ ]]; then
                echo "Invalid time format"
                exit 1
            fi
            hour=${time%%:*}
            minute=${time#*:}
            schedule="$minute $hour * * *"
            (crontab -l | grep -v "$command" ; echo "$schedule $command") | crontab -
            ;;
        3)
            echo "Which day would you like to choose? Enter a number from 1 (Sunday) to 7 (Saturday)"
            read -r day
            if ((day < 1)) || ((day > 7)); then
                echo "Invalid day"
                exit 1
            fi
            schedule="* * * * $day"
            (crontab -l | grep -v "$command" ; echo "$schedule $command") | crontab -
            ;;
        4)
            echo "For which date do you want to automate the task? Enter the input in YYYY-MM-DD HH:MM format, e.g., 2000-12-25 04:30"
            read -r udate
            schedule=$(date -d "$udate" +'%M %H %d %m *')
            (crontab -l | grep -v "$command" ; echo "$schedule $command") | crontab -
            ;;
        5)
            echo "Press 'd' for weekdays or 'e' for weekends"
            read -r week
            if [ "$week" == d ]; then
                wday="1-5"
            elif [ "$week" == e ]; then
                wday="6,7"
            else
                echo "Invalid option"
                exit 1
            fi
            ;;
        *)
            echo "Invalid option"
            exit 1
            ;;
    esac
else
    echo Invalid option
fi