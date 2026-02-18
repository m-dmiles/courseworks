#!/bin/bash
############################
# Exercise 14 - For loop counting 'error'
############################

# Directory containing log files
LOG_DIR="/home/dmiles/courseworks/bash/logs19"

# Loop through all .log files
for file in "$LOG_DIR"/*.log; do
    # Get filename without path and .log suffix
    base_name=$(basename "$file" .log)
    
    # Count occurrences of 'error' (case-insensitive)
    count=$(grep -ci "error" "$file")
    
    # Print filename (without .log) and count
    echo "$base_name $count"
done

