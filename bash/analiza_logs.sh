#!/bin/bash
############################
# Exercise 18 - Analyze log25 folder
############################

# Check if an output file argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <output_file>"
    exit 1
fi

OUTPUT_FILE=$1
LOG_DIR="/home/dmiles/courseworks/bash/logs25"

# Initialize counters
total_accesses=0
failed_attempts=0
successful_attempts=0

# Loop through all auth25_*.log files
for file in "$LOG_DIR"/auth25_*.log; do
    echo "Processing $file..."

    # Count total lines (each line = 1 access)
    total=$(wc -l < "$file")
    total_accesses=$((total_accesses + total))

    # Count failed attempts (lines containing "failed")
    failed=$(grep -ci "failed" "$file")
    failed_attempts=$((failed_attempts + failed))

    # Count successful attempts (lines containing "success")
    success=$(grep -ci "success" "$file")
    successful_attempts=$((successful_attempts + success))
done

# Print statistics
echo "Log Analysis Results:" > "$OUTPUT_FILE"
echo "Total accesses: $total_accesses" >> "$OUTPUT_FILE"
echo "Failed attempts: $failed_attempts" >> "$OUTPUT_FILE"
echo "Successful attempts: $successful_attempts" >> "$OUTPUT_FILE"

echo "Analysis complete. Results saved in $OUTPUT_FILE"
