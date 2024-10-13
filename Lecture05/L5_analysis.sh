#!/usr/bin/bash
file="example_people_data.tsv"
IFS=$'\t'


echo "Go through the file showing an index counter and the country"

counter=0
while read name email city day month year country
	do
		((counter++))
		echo -e "${counter}\t${country}"
	done < ${file}




echo "Go through the file showing an index counter, name, city and the country, but without the header and blanks lines this time"

counter=0
while read name email city day month year country
do
	if test -z ${name}
	then
	:
	elif test ${name} == "name"
	then
	:
	else
		((counter++))
		echo -e "${counter}\t${name}\t${city}\t${country}"
	fi
done < ${file}


echo "Put people into separate files: a different file for each country"
rm ./country_details/*txt
counter=0
while read name email city day month year country
do
       if test -z ${name} || test ${name} == "name"
       then
       continue
       else
               ((counter++))
               echo -e "${counter}\t${name}\t${city}\t${country}" >> ./country_details/${country// /_}.txt
       fi
done < ${file}

echo "Work out how many people were born in October, and where are they from, output the list of people"
rm ./born_in_october.txt
counter=0
while read name email city day month year country
do
       if test -z ${name} || test ${name} == "name"
       then
       continue
       elif test ${month} == "10"
	then
		((counter++))
		echo -e "${name}\t${month}\t${city}\t${country}" >> born_in_october.txt
       fi
done < ${file}
echo "There are a total of ${counter} people that were born in october."


echo "Work out how many people were born in October, and where are they from, output as multiple lists"
rm ./born_october/*.txt
counter=0
while read name email city day month year country
do
       if test -z ${name} || test ${name} == "name"
       then
       continue
       elif test ${month} == "10"
       then
               ((counter++))
               echo -e "${name}\t${month}\t${city}\t${country}" >> ./born_october/${name}.txt
       fi
done < ${file}

echo "Using an array to process the Mozambique data (have not told you how to do this, it's just something for those who want more...)"
rm Mozambique_details.txt
unset my_array
declare -A my_array
counter=0 ; count=0
while read name email city day month year country
do
	((counter++))
       if test -z ${name} || test ${name} == "name"
       then
       continue
       elif test ${country} == "Mozambique"
       then
               ((count++))
               my_array[${count}]="${counter}\t${name}\t${country}"
	       echo -e "${my_array[${count}]}"
	fi
done < ${file}

for i in ${my_array[@]} ; do echo -e "$i" >> Mozambique_details.txt; done
