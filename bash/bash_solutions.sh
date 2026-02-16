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
