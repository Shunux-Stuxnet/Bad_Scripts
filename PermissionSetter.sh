#!/bin/bash

echo "Welcome to the chmod permissions script!"
echo "Please select the permissions you want to assign:"

options=("Read" "Write" "Execute")
permissions=("r" "w" "x")
chosen_permissions=""

PS3="Enter the number corresponding to the permission you want to assign (or 'q' to quit): "

select option in "${options[@]}"; do
  case $REPLY in
    1)
      chosen_permissions+="r"
      ;;
    2)
      chosen_permissions+="w"
      ;;
    3)
      chosen_permissions+="x"
      ;;
    q)
      echo "Exiting..."
      exit
      ;;
    *)
      echo "Invalid option. Please try again."
      continue
      ;;
  esac

  read -p "Do you want to assign more permissions? (y/n): " more_permissions

  if [[ $more_permissions != "y" ]]; then
    break
  fi
done

read -p "Enter the file/directory path: " file_path

chmod +${chosen_permissions} "$file_path"

echo "Permissions successfully assigned!"

