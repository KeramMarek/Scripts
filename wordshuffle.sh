#!/bin/bash

# Description: This script mixes letters of random words for you to guess.

# Prompt the user to choose a difficulty level.
read -p "Choose your level: easy/hard: " level

# Function to handle the game logic.
game() {
    local file="$1" # File containing the words.

    # Read all words from the file into an array.
    readarray -t words < "$file"

    # Choose a random word from the array.
    local length="${#words[@]}"
    local index="$(( RANDOM % length ))"
    local random_word="${words[$index]}"

    # Word to be mixed.
    local word_to_mix="$random_word"

    # Split the word into individual characters and shuffle them.
    local word_split=($(echo "$word_to_mix" | grep -o .))
    local shuffled=$(echo "${word_split[@]}" | tr ' ' '\n' | shuf | tr -d '\n')

    # Clear the screen and display the shuffled word.
    clear
    echo "Your shuffled word is: $shuffled"
    echo "---------------------------------"

    # Prompt the user to guess the word.
    read -p "Type in the word: " guess

    # Check if the guess is correct.
    if [[ $guess == $word_to_mix ]]; then
        echo -e "\nCORRECT!"

        # Ask if the user wants to play again.
        read -p "Do you want to play more (y/n)? " answer
        if [[ $answer == "y" ]]; then
            game "$file" # Restart the game with the same difficulty level.
        else
            clear
            echo "Goodbye!"
        fi
    else
        echo "Not correct!"
	read -p "Do you want to play again? (y/n)" answer
	if [[ $answer == "y" ]]
	then
		game "$file" # Restart the game with the same difficulty level.
	else
		clear
		echo "Goodbye!"
	fi
    fi
}

# Paths to the word files for each difficulty level.
easy_words="/home/marek/scripts/easy.txt"
hard_words="/home/marek/scripts/hard.txt"

# Choose the file based on the selected difficulty level.
case $level in
    easy)
        game "$easy_words";;
    hard)
        game "$hard_words";;
    *)
        echo "Wrong choice";;
esac
