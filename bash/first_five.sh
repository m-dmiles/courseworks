#!/bin/bash

############################
# Exercise 15 - While loop: first 5 lines containing "normal"
############################

LOG_DIR="/home/dmiles/courseworks/bash/logs19"

# Loop through all .log files
for file in "$LOG_DIR"/*.log; do
    echo "File: $file"

    # Use grep to get lines containing "normal"
    # Use head to limit to first 5 lines
    grep "normal" "$file" | head -n 5
done

