#!/bin/bash

#Description: script mixes letters of random words for you to guess.


read -p "Choose your level: easy/hard: " level

game() {
file="$1"	
readarray -t words < "$file"  
length="${#words[@]}"
index="$(( RANDOM % $length ))"
random_word="${words[$index]}"

word_to_mix="$random_word"

word_split=($(echo "$word_to_mix" | grep -o .))
shuffled=$(echo "${word_split[@]}" | tr ' ' '\n' | shuf | tr -d '\n')
clear
echo "Your shuffled word is: $shuffled"
echo "---------------------------------"
read -p "Type in the word: " guess
if [[ $guess == $word_to_mix ]]
then
	echo -e "\n" 
	echo "CORRECT!"
	read -p  "Do you want to play more y/n " answer
	if [[ $answer == "y" ]]
	then
		game $easy_word
	else
		clear
		echo "Goodbye!"
	fi
else
	echo "Not correct!"
	
fi

}

easy_words="/home/marek/scripts/easy.txt"
hard_words="/home/marek/scripts/hard.txt"

case $level in
	easy)
		game $easy_words;;
	hard)
		game $hard_words;;
	*)
		echo "Wrong choice";;
esac





