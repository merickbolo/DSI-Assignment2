#!/bin/bash

# Assignment 1 - Merick Bolognone

cd ~/Desktop #Changes directory to Dekstop

function fine_types {
	cut -d, -f4 < parking_data.csv | sort | uniq
} #Selects all unique variables and prints them in the terminal

function fine_stats {

lines=$(cat parking_data.csv | wc -l) #Counts number of rows in .csv #https://www.datablist.com/learn/csv/number-rows-csv-linux-mac-terminal#

cut -d, -f5 < parking_data.csv > calc_column.txt #Cuts fine data column from data and inputs it into a wokring file. Used this method for simplicity in reading one column only

calcfile=calc_column.txt #Defines the temporary file as a variable

#Calculates sum based on the fine data file for average calculation
sum=0
while read -r fine1; do sum=$(($sum+$fine1)); done < "$calcfile"

avg=$(($sum/$(($lines-1)))) #Calculates mean/average

#Calculates max based on the fine data
max=0
while read -r fine2; do 
	[ $(($fine2 -ge "$max")) ] && $((max="$fine2")) #https://www.baeldung.com/linux/bash-ternary-conditional-operator#3-equivalent-expression-using-logical-operators
done < "$calcfile"

#Calculates min based on the fine data
min=$max
while read -r fine; do 
	let min="($fine < $min) ? $fine : min" #https://www.baeldung.com/linux/bash-ternary-conditional-operator#3-equivalent-expression-using-logical-operators
done < "$calcfile"

rm calc_column.txt #Removes the temporary file used for reading the data

echo "Mean $avg; Min $min; Max $max" #Prints the mean, minimum, and maximum with the corresponding title
} #Prints the mean, minimum, and maximum for parking_data.csv

function export_type {
	file=parking_data.csv #Defines parking_data as the file
	infrac_type="STAND VEH.-PROHIBIT TIME/DAY" #Defines type of infraction to extract
	while read -r line; do
        if [[ $line == *"$infrac_type"* ]]; then
        fi
done < "$file" > infrac_list.csv
}