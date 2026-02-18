#!/bin/bash
############################
# Exercise 16 - buscar script (fixed for your logs)
############################

# Check for correct number of arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <hour> <minute>"
    exit 1
fi

HOUR=$1
MIN=$2

# Calculate time window ±5 minutes
START_MIN=$((MIN - 5))
END_MIN=$((MIN + 5))

# Adjust boundaries
if [ $START_MIN -lt 0 ]; then
    START_MIN=0
fi
if [ $END_MIN -gt 59 ]; then
    END_MIN=59
fi

# Directory with logs
LOG_DIR="/home/dmiles/courseworks/bash/logs19"

echo "Searching events from $HOUR:$START_MIN to $HOUR:$END_MIN..."

# Count normal events ("info normal")
normal_count=$(grep -E "\[$HOUR:([0-5][0-9])\]" "$LOG_DIR"/*.log | \
               grep "info normal" | \
               awk -v start=$START_MIN -v end=$END_MIN '{ 
                   split($1,time,"[:\\]]"); 
                   if(time[2]>=start && time[2]<=end) print 
               }' | wc -l)

# Count error events ("error events")
error_count=$(grep -E "\[$HOUR:([0-5][0-9])\]" "$LOG_DIR"/*.log | \
              grep "error events" | \
              awk -v start=$START_MIN -v end=$END_MIN '{ 
                  split($1,time,"[:\\]]"); 
                  if(time[2]>=start && time[2]<=end) print 
              }' | wc -l)

echo "Normal events: $normal_count"
echo "Error events: $error_count"

