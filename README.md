# cheatsheet
<h5>Extract fasta from Tassel</h5>
```
grep -v "@" ../../myAlignedMasterTags.sam|awk '$4>=56260{print}'| awk '$4<=56380{print}'| head
```
<h5>Remove spaces & blank lines in a file</h5>
```
sed -i '/^ *$/d' 3markermap.txt
```
<h5>Fix problem of head showing only 1 line </h5>
```
sed -i.bak 's/\r$//; s/\r/\n/g' 3markermap.txt
```
<h5>Stamp today's date by using today in filenames</h5>
```
nano ~/.bashrc
today=$(date +"%F")
nano file_today
```
<h5>Get number of nucleotide for each sequence in a fasta file</h5>
```
samtools faidx sample.fa
cut -f1-2 sample.fa.fai
```
<h5>R: set . and - to NA while reading data</h5>
```
read.csv("file.csv", na.strings=c(".","-"))
```

<h5>Get non-duplicate names </h5>
```
cat names.txt | uniq -u 
```

<h5>Add some name prior to 1 column </h5>
```
awk '$1="Crop_"$35' file.txt > file_named.txt
```
<h5>Combine rows when the column names are different</h5>
```
library(plyr)
mergedtest<-rbind.fill(test1,test2)
```
<h5>Transpose rows into columns</h5>
```
awk '
{ 
    for (i=1; i<=NF; i++)  {
        a[NR,i] = $i
    }
}
NF>p { p = NF }
END {    
    for(j=1; j<=p; j++) {
        str=a[1,j]
        for(i=2; i<=NR; i++){
            str=str" "a[i,j];
        }
        print str
    }
}' gatk.txt > t_gatk.txt
```

<h5>Login to a specific directory instead of home</h5>
```
nano ~/.bashrc
```
```
foo() { cd "/ufrc/group/user" ; }
foo
```
<h5>Print the lines where column 5 has a , in it </h5>
```
awk '$5 ~/,/' file.vcf'
```

<h5>Add colors to directories in bash</h5>
```
nano ~/.bashrc
```
````
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'

```
<h5>Increase java heap memory</h5>
```
export _JAVA_OPTIONS="-Xms1g -Xmx32g"
```

<h5>Convert csv to tab separated file</h5>
```
sed -e 's/,/\t/g' barcodecsv.txt > barcode_tab.txt
```
<h5>View .gz files without decompressing</h5>
```
gzip -cd file.gz | head
```

<h5>R > Store results from a loop into a dataframe</h5>
Before loop
```
d=NULL
```
Inside loop
```
d=rbind(d, data.frame(locus, name, allele1[[i]],allele2[[i]],total[[i]],group))
```

<h5>Use GUI of Rstudio on hiperGator</h5>
```
gui.hpc.ufl.edu # on mobaXterm
module load rstudio
rstudio
```


<h5>R: store output within functions</h5>

```
fn1<- function (x) { 
  result= "#work"
  dput(result)
}
```

<h5>View the size of all directories</h5>
```
du sh *
du sh * | sort -hr
```
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
