# cheatsheet

<h5>
Copy file from windows commandline to hipergator </h5>

```pscp source_file_name paudel@gator.hpc.ufl.edu:/lfs/scratch/paudel/flowering2``` #from local to server

```pscp paudel@gator.hpc.ufl.edu:/lfs/scratch/paudel/flowering2/*.* .``` #from server to local
This works in both directions

<h5>
Merge the 2 files but keep header from only first file. </h5>

```awk 'FNR==1 && NR!=1{next;}{print}' *.txt > myGBSProject_key.txt```

<h5>Replace characters</h5>

```sed -i 's/old/new/g' filename.fasta``` # replaces old with new

```sed -i 's/old//g' filename.fasta``` # removes old

<h5> Using variables in bash </h5>
```
#!/bin/bash
STR="Hello World!"
echo $STR 
```
<h5>grep for multiple patterns</h5>
``` grep "early\|late" filename.txt > pattern.txt```
<h5>Find number of columns in a file</h5>
```awk '{print NF}' filename.txt | sort -nu | tail -n 1```
