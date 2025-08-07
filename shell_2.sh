# Owner: more astha
# $USER: astha
# Created date: 17-6-25 
# Description: checks if a given number is even or odd



#!/bin/bash
source ./lib.sh
if [ $# -eq 1 ]; then
 num1=$1
else
 read -p "Enter the number to check odd or even" num1
fi
input_number_only "$num1" || exit 1 
if (( $num1 % 2 == 0 )) 2> /dev/null
then 
 echo "number is even"
else
 echo "number is odd"
fi

