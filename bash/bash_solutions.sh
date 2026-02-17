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
 
