#!/usr/bin/bash

file="example_people_data.tsv"

cat ${file}


echo "Question 1, How many people are there?"

cat ${file} | awk 'BEGIN{FS="\t"} {if(NF==7 && $1!="name") {print $0}}' | wc -l


echo "Question 2, How many people are aged around 30 or older?"

cat ${file} | awk 'BEGIN{FS="\t"} {if(NF==7 && $6<=1994) {print $0}}' | wc -l


echo "Question 3, How many people are called Jan?"

cat ${file} | awk 'BEGIN{FS="\t"} {if (NF==7 && $1 == "Jan") {print $0}}' | wc -l


echo "Question 4, What is the most common country of birth, and of the people from this country, how many are around 50 or older?"

cut -f7 ${file} | sort | uniq -c | sort -k1nr | head -5

cat ${file} | awk 'BEGIN{FS="\t"} {if (NF==7 && $7 == "Mozambique" && $6<1974) {print $0}}'


echo -e  "Question 5, What are the names, in reverse alphabetical order within each country of birth, of the people with \"edu\" email addresses?"
cat ${file} | awk 'BEGIN{FS="\t"} $2 ~ /edu$/ {if (NF==7) {print $0}}' | sort -k7,7 -k1,1r
