!#/bin/bash

echo Give me a hostname to check if it is up.

read HOST

ping -c 9 $HOST

if [ "$?" -eq 0 ]; then
    echo "The host $HOST is reachable"
else
    echo "The host $HOST isn't rechable"
fi
