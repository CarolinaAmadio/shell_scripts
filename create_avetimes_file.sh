#!/bin/bash

start_date="19990101"
end_date="20220101"

#############  FREQ DAILY ############# 

output_file="Daily.aveTimes"
rm -f $output_file

while [ "$start_date" != "$end_date" ]; do
    echo "${start_date}-00:00:00" >> $output_file
    start_date=$(date -d "$start_date +1 day" +"%Y%m%d")
done

echo "Count of the Months"
line_count=$(wc -l < $output_file)
num_years=$((line_count / 365))
echo "The length of the file is: $line_count lines."
echo "This corresponds to approximately $num_years years."
echo "________________________________________________________"

############# FREQ MonthLY #############
start_date="19990101"
end_date="20220101"


output_file="Monthly.aveTimes"
rm -f $output_file

while [ "$start_date" != "$end_date" ]; do
    echo "${start_date}-00:00:00" >> $output_file
    start_date=$(date -d "$start_date +1 month" +"%Y%m%d")
done

echo "Count of the Months"
line_count=$(wc -l < $output_file)
num_years=$((line_count / 12))
echo "The length of the file is: $line_count lines."
echo "This corresponds to $num_years years."
echo "________________________________________________________"

