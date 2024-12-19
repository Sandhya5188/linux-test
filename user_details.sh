#!/bin/bash

# File containing the student data
data_file="user_details.csv"

# Check if the user has provided both name and field
if [ -z "$1" ] && [ -z "$2" ]; then
  echo "Usage: $0 <Name> <Field (Address | Education | Age | E-mail)>"
  exit 1
fi

# Check if the user has provided only the name (for full details)
if [ -z "$2" ]; then
  name=$1
  # Search for the student's name in the file and print all details
  result=$(grep -i "$name" "$data_file" | awk -F '|' '{print "Name: " $1 "\nAddress: " $2 "\nEducation: " $3 "\nAge: " $4 "\nE-mail: " $5}' | sed 's/ //g')

  # Check if result was found
  if [ -z "$result" ]; then
    echo "No record found for $name"
  else
    echo -e "$result"
  fi
  exit 0
fi

# Extract the parameters
name=$1
field=$2

# Define the column numbers for each field
case $field in
  Address)
    col=2
    ;;
  Education)
    col=3
    ;;
  Age)
    col=4
    ;;
  E-mail)
    col=5
    ;;
  *)
    echo "Invalid field! Choose from Address, Education, Age, E-mail."
    exit 1
    ;;
esac

# Search for the student's name in the file and print the requested field
result=$(grep -i "$name" "$data_file" | awk -F '|' -v col="$col" '{print $col}' | sed 's/ //g')

# Check if result was found
if [ -z "$result" ]; then
  echo "No record found for $name"
else
  echo "$field for $name: $result"
fi
