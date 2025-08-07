# Owner: Astha more
# $USER: astha
# Created date: 16-06-25 
# Description: Take two numbers as input and perform +,-,*,/.


#!/bin/bash
#import library
source ./lib.sh
if [ $# -eq 2 ]; then
 num1=$1
 num2=$2
else
 read -p "Enter number 1" num1
 read -p "Enter number 2" num2
fi
input_number_only "$num1" || exit 1
input_number_only "$num2" || exit 1
sum=$(( num1 + num2 ))
product=$(( num1 * num2 ))
divide=$(echo "scale=2; $num1/ $num2" | bc)
subtract=$(( num1 - num2))
echo -e "the sum of $num1 + $num2 is = $sum"
echo -e "the product of $num1 * $num2 is = $product"
echo -e "the divide of $num1 / $num2 is = $divide"
echo -e "the subtract of $num1 - $num2 is = $subtract"

