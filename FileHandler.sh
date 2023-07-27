!#/bin/bash
echo Hello, I am here to help you with dealing your file.
echo Please give the file name from current directory only
read filename

echo Lemme check if the file exists...
sleep 2

if [ -e $filename ]; then
    echo "File Exists"
fi

if [ -f $filename ]; then
    echo "File exists and is a regular file"
fi

if [ -s $filename ]; then
    echo "I see.. the file isn't empty"
fi

if [ -w $filename ]; then
    echo "File is writable"
fi

if [ -r $filename ]; then
    echo "File is readable"
fi

if [ -x $filename ]; then
    echo "File is executable"
fi

sleep 3

echo Hello, I want to write this file in another file so gimme 2 numbers to decide the filename

echo enter first num
read a

echo enter second num
read b

sum=$((a+b))
mul=$((a*b))
sub=$((a-b))
echo $sum

echo You have six name options
echo "Press 1 for ${sum}${mul}${sub}.sh"
echo "Press 2 for ${mul}${sum}${sub}.sh"
echo "Press 3 for ${sub}${mul}${sum}.sh"
echo "Press 4 for ${sum}${sub}${mul}.sh"
echo "Press 5 for ${mul}${sub}${sum}.sh"
echo "Press 6 for ${sub}${sum}${mul}.sh"
echo "Press 7 if you want to give a custom name"
read opt

ex="${filename##*.}"

case $opt in
    1)
    mv $filename ${sum}${mul}${sub}.$ex
    ;;

    2)
    mv $filename ${mul}${sum}${sub}.$ex
    ;;

    3)
    mv $filename ${sub}${mul}${sum}.$ex
    ;;

    4)
    mv $filename ${sum}${sub}${mul}.$ex
    ;;

    5)
    mv $filename ${mul}${sub}${sum}.$ex
    ;;

    6)
    mv $filename ${sub}${sum}${mul}.$ex
    ;;
    7)
    echo Tell me the name you want to give
    read fname
    mv $filename $fname.sh

esac
