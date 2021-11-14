#! /bin/bash

# Author: Nik Delgado

# Summary: This scrip counts file types in a directory and prints the
# leading athletes from a data file of athletes, sports, and score. 

# Arguments:
#	1: Directory to count file types
#	2: File path to athlete data

# Usage: hw6.sh directory-to-count athlete-data-file
# Example: ./hw6.sh /home/tvirgo/hw6_test /home/tvirgo/hw6_test


# Set Variables

dir=$1
file=$2
directories=0
soft_links=0
files_w_content=0
empty_files=0
file_dir=${dir##/*/}

# Loop through directory

for file in $dir/*
do
	if [ -d $file ]; then directories=$((directories+1)); fi 
	if [ -L $file ]; then soft_links=$((soft_links+1)); fi
	if [ -s $file ] ; then
		files_w_content=$((files_w_content+1))
	else
		empty_files=$((empty_files+1))

	fi
done


# Print Results

echo "===== HOMEWORK 6 ====="
echo "------- FILE TYPES"
echo "files in directory:" $file_dir
echo "Directories:" $directories
echo "SoftLinks:" $soft_links
echo "Files w/ content:" $files_w_content
echo "Empty files:" $empty_files


# Set Leader Variables

luge_leader=""
luge_score=0
skiing_leader=""
skiing_score=0
cycling_leader=""
cycling_score=0

# Cycle through each line of text file and set score and leader if score is greater than existing score variable

while read name sport score;
do
	case $sport in
	skiing)
		if (( score > skiing_score )); then
			skiing_score=$score
			skiing_leader=${name#*-}
		fi ;;
	luge)
		if (( score > luge_score )); then
			luge_score=$score
			luge_leader=${name%-*}
		fi ;;
	cycling)
		if (( score > cycling_score )); then
			cycling_score=$score
			cycling_leader=${name%-*}
		fi ;;
		
	*)	
		echo Error ;;
	esac

done < /home/tvirgo/hw6_test/athlete_data.txt

# Print the results

echo ------- LEADER BOARD
echo -e "Luge leader:" $luge_leader '\t' "Score:" $luge_score
echo -e "Skiing leader:" $skiing_leader '\t' "Score:" $skiing_score
echo -e "Cycling leader:" $cycling_leader '\t' "Score:" $cycling_score

exit
