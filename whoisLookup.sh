#!/usr/bin/env bash
#Author: Matthew Riedle
#Version: 1.0

##### VARIABLE DEFINING #####
# The script needs to be executed as ./whoisLookup.sh whoisLookup.txt
# whoisLookup.txt needs to contain a list of IPs / domains separated on new lines
whoisFile=$1
whoisResults=whoisResults.txt
whoisCountryResults=whoisCountryResults.txt
whoisCount=1

# Loading the list of IPs / domains into a list
	IFS=$'\n' read -d '' -r -a list < $whoisFile

	echo "WHOIS Lookup is starting."
	echo "Number of search terms loaded for lookup: " ${#list[@]}
		
	for line in ${list[@]}; do

# Echo the current line number
		echo "Entry #"$whoisCount" -- "$line
	
# Add spacers to the beginning of the results
		echo "==========" >> $whoisResults

# Reset the timestamp to the current time and use PST
		timestamp=$(TZ=":America/Los_Angeles" date)
	
# Load the current time into the file to record what time the WHOIS Lookup was performed
		echo -e "Lookup was performed at $timestamp" >> $whoisResults

# Add the search term being queried
		echo "Lookup was performed on $line" >> $whoisResults
		echo "" >> $whoisResults
		echo "==========" >> $whoisResults

# Execute the WHOIS lookup	
		whois $line >> $whoisResults

# Add spacing
		echo "" >> $whoisResults
		echo "==========" >> $whoisResults
		echo "" >> $whoisResults
		echo "" >> $whoisResults
		
		echo ""

# Increment the counter
		(( whoisCount++ ))
		sleep 0.25

done

echo ""
echo "Script has finished."