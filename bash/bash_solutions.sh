#!/bin/bash

#Bash Practice I
#Name: Daniel Miles Mugisa

#======== Exercise 1: Inspection  ========

#Show all variables
set|less

#Shows environment variables
env|less

#======== Exercise 2: Local vs Env	 ========
MI_LOCAL="hola"
echo "$MI_LOCAL"

env|grep MI_LOCAL || echo"Does not appear"

export MI_LOCAL

env|grep MI_LOCAL

#======== Exercise 3: Executable ========
mkdir -p ~/bin_demo

cat > ~/bin_demo/saludo <<'EOF'
#!/bin/bash

echo "Hello $USER, welcome to $0"
echo "Your files $(ls -l ~)"
EOF

chmod +x ~/bin_demo/saludo
~/bin_demo/saludo

#======== Exercise 4: PATH Check ========

#Check if saludo is in PATH
which saludo || echo "Not in PATH"

#Add bin_demo to PATH temporarily
export PATH="$HOME/bin_demo:$PATH"

#Verify again
which saludo

#Run Saludo without PATH
saludo


#======== Exercise 5: Precedence ========

#Create alternative directory
mkdir -p ~/bin_demo_alt

#Create alternative saludo
cat> ~/bin_demo_alt/saludo <<'EOF'
#!/bin/bash

echo "This is the ALTERNATIVE saludo"
echo "Execute from: $0"
EOF

#Make executable
chmod +x ~/bin_demo_alt/saludo

#Check current saludo
which saludo

#Add bin_demo_alt first in PATH
export PATH="$HOME/bin_demo_alt: $PATH"

#Verify precedence
which saludo

#Run saludo
saludo

#Show all saludo versions
which -a saludo


#======== Exercise 6: Symbolic links ========

#Go to home folder
cd ~

#Create a symbolic link named bin_demo_link point to bin_demo
ln -s ~/bin_demo ~/bin_demo_link

#Verify the link exists
ls -l

#Add the link folder to PATH (temporary for this season)
export PATH=$HOME/bin_demo_link:$PATH

#Show PATH to confirm
echo $PATH

#Check which saludo is used now
which saludo

#Run the saludo script
saludo

######## Exercise 7: Persistence ########

# Make PATH changes permanent by adding to ~/.bashrc
echo '' >> ~/.bashrc
echo '# Exercise 7 - persistent PATH' >> ~/.bashrc
echo 'export PATH=$HOME/bin_demo_link:$PATH' >> ~/.bashrc

# Make aliases permanent
echo '' >> ~/.bashrc
echo '# Exercise 7 - persistent aliases' >> ~/.bashrc
echo "alias ls_l='ls -l'" >> ~/.bashrc

# Reload Bash configuration so changes take effect immediately
source ~/.bashrc

# Verify
echo "PATH is now: $PATH"
which saludo
ls_l

######## Exercise 8: PS1 Prompt ########

# Change the Bash prompt
# \u = username
# \w = current working directory
# > = literal character
export PS1="\u \w > "

# Show the new prompt
echo "Your new prompt is now: $PS1"


######## Exercise 9: TZ Variable (Tokyo Time) ########

# Temporarily change the time zone to Tokyo
export TZ="Asia/Tokyo"

# Verify the time in Tokyo
echo "Current time in Tokyo:"
date

# Optional: Show Tokyo time without changing global TZ
echo "Tokyo time using a single command without changing shell:"
TZ="Asia/Tokyo" date


######## Exercise 10: Alias ls_l ########


# Create a temporary alias for the current session
alias ls_l='ls -l'

# Test the alias
echo "Testing ls_l alias:"
ls_l

# Check if the alias exists
alias | grep ls_l

###### Exercise 11: Persistance in ZSH ########

# Make PATH persistent in ZSH
echo '' >> ~/.zshrc
echo '# Exercise 11 - persistent PATH' >> ~/.zshrc
echo 'export PATH=$HOME/bin_demo_link:$PATH' >> ~/.zshrc

# Make aliases persistent in ZSH
echo '' >> ~/.zshrc
echo '# Exercise 11 - persistent aliases' >> ~/.zshrc
echo "alias ls_l='ls -l'" >> ~/.zshrc

# Reload ZSH configuration (if you are currently in ZSH)
[ -f ~/.zshrc ] && source ~/.zshrc

# Verify
echo "PATH in ZSH is now: $PATH"
alias | grep ls_l

######## Exercise 12: Persistent PS1 Prompt ########

# Add custom PS1 prompt to ~/.bashrc
echo '' >> ~/.bashrc
echo '# Exercise 12 - persistent PS1 prompt' >> ~/.bashrc
echo 'export PS1="\u \w > "' >> ~/.bashrc

# Reload Bash configuration to apply immediately
source ~/.bashrc

# Verify the prompt (PS1 variable)
echo "Your PS1 prompt is now: $PS1"

######## Exercise 13: HISTSIZE Variable ########

# Set HISTSIZE to 1000 commands for this session
export HISTSIZE=1000

# Make HISTSIZE persistent in Bash
echo '' >> ~/.bashrc
echo '# Exercise 13 - persistent history size' >> ~/.bashrc
echo 'export HISTSIZE=1000' >> ~/.bashrc

# Verify HISTSIZE
echo "Current HISTSIZE: $HISTSIZE"

# Instructions: Use Ctrl+R to search previous commands
echo "Use Ctrl+R to search your command history."

######## Exercise 14: For loop counting .error ########
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

#RESULT;
##  log19_a 20
### log19_b 0

######## Exercise 15:  While loop: first 5 lines containing: NORMAL ########

LOG_DIR="/home/dmiles/courseworks/bash/logs19"

# Loop through all .log files
for file in "$LOG_DIR"/*.log; do
    echo "File: $file"

    # Use grep to get lines containing "normal"
    # Use head to limit to first 5 lines
    grep "normal" "$file" | head -n 5
done

#File: /home/dmiles/courseworks/bash/logs19/log19_a.log
# Jan 28 10:01 info normal 1
# Jan 28 10:02 info normal 2
# Jan 28 10:04 info normal 4
# Jan 28 10:05 info normal 5
# Jan 28 10:07 info normal 7
#File: /home/dmiles/courseworks/bash/logs19/log19_b.log
# Jan 28 10:01 info normal 1
# Jan 28 10:02 info normal 2
# Jan 28 10:04 info normal 4
# Jan 28 10:05 info normal 5
# Jan 28 10:07 info normal 7

####### Exercise 16 ########

######## Exercise 16: buscar script #########

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

######## Exercise 17: grep /admin URLs ########

# Directory with logs
LOG_DIR="/home/dmiles/courseworks/bash/logs23"

# 1️⃣ Extract all /admin accesses and save to urls-admin.log
grep -E "/admin($|/|\.php)" "$LOG_DIR"/web23_*.log > "$LOG_DIR"/urls-admin.log

echo "Step 1: Extracted /admin accesses into urls-admin.log"

# 2️⃣ Optional: Capture the next "info access" line after /admin
# This will create urls-admin-info.log containing info access numbers related to /admin
grep -E -A1 "/admin($|/|\.php)" "$LOG_DIR"/web23_*.log | grep "info access" > "$LOG_DIR"/urls-admin-info.log

echo "Step 2: Extracted 'info access' lines into urls-admin-info.log"

# 3️⃣ Count the number of /admin accesses per file
echo "Step 3: Number of /admin accesses per file:"
grep -E "/admin($|/|\.php)" "$LOG_DIR"/web23_*.log | cut -d':' -f1 | sort | uniq -c

echo "Exercise 17 completed."


######## Exercise 18: Analyze log25 folder #############
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
