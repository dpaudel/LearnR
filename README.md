# cheatsheet
<h5>Sum integers on 2nd column of a file</h5>
```
awk '{s+=$2} END {print s}' 454AllContigs.fna_length_distribution.txt
```
<h5>Sort filenames by date(time) with ls</h5>

```
ls -l -t
ls -l -tr #reverse
```

<h5>Change file permission</h5>

```
chmod 777 *.*
chmod 777 -R /dirname
```

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
<h5>Store stdin into a txt file and append to it</h5>
```command | tee -a log.txt```

<h5>Replace #### in vcf file with ##</h5>
```sed -i 's/####/##/' myGBSGenos_chr*.vcf```

<h5>Count number of raw reads per barcode in gbs data</h5>
```awk 'substr($1,2,9)~/TGACGCCA/' C7U82ANXX_7_fastq | wc -l```

```perl -ne 'print if( (/@/ && ($end=1))..!$end-- )' C7U82ANXX_7_fastq | grep -v "@"| awk 'substr($1,2,9)~/TGACGCCA/' | tee -a test1adapter.txt```
#Use stacks instead :)

<h5>Get names of progenies from all files to be used in STACKS</h5>
```
for i in *.fq; do echo -n " -r ./samples_7/$i"; done
```
