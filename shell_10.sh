# Owner: astha more
# $USER: astiha
# Created date: 18-6-25
# modifeddate : 26-6-25
# Description: Generates a random password of a given length using alphanumeric and special characters.
#!/bin/bash
source ./lib.sh
if [ $# -eq 1 ]; then
 length=$1
else
 read -p "enter the password length you want to generate " length
fi
empty_input "$length" || exit 1
input_number_only "$length" || exit 1
if [ "$length" -le 0 ]; then
 echo "input must be integer (positive)"
 exit 1
fi
char='A-Za-z0-9!@#$%^&*()_+=<>?'

#generating password with urandom 
password=$(cat /dev/urandom | tr -cd "$char" | head -c "$length")
empty_input "$password" || exit 1
echo "generated password = $password"
