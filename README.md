# cheatsheet

<h5>
Copy file from windows commandline to hipergator </h5>

```pscp source_file_name paudel@gator.hpc.ufl.edu:/lfs/scratch/paudel/flowering2```

This works in both directions

<h5>
Merge the 2 files but keep header from only first file. </h5>

```awk 'FNR==1 && NR!=1{next;}{print}' *.txt > myGBSProject_key.txt```
