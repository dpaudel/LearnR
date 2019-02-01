# cheatsheet

<h5>cat lines at end of each corresponding line</h5>

```
paste -d '' file1.fas file2.fas
```

<h5>Get file structure tree in MS-DOS</h5>

```
tree > tree_structure.txt /A /F
```

 <h5>SLURM dependency submit job after previous completes </h5>
 
 ```
 sbatch --dependency=afterok:11254323 job2.sh
 ```
 
 <h5>Fix font issues with uf theme</h5>

```
library(extrafont)
loadfonts(device = "win")
windowsFonts(Arial=windowsFont("TT Arial"))
```
  
<h5>Sort based on 1st and 2nd column</h5>

```
sort -k 1,1 -k2,2n file
```

<h5>Superscript annotation in plot in R </h5>

```
p <- ggplot(cars, aes(x=speed, y=dist))+ geom_point()
p + annotate("text", x = 20, y = 125, label = "italic(R) ^ 2 == 0.75", parse=TRUE)
```

```
lb1 <- paste("R^2 == ", round(runif(1),4))
qplot(1:10, 1:10) + 
  annotate("text", x=2, y=8, label=lb1, parse=TRUE)
```
  
<h5>Extract columns on 1 file based on ids on another file</h5>

```
grep -Fwf ids.txt table.txt
```

<h5>Sort by numeric values on column 16</h5>

```
sort -nk16 newdata.txt
```

<h5>Remove duplicate fasta entries</h5>

```
awk 'NR==FNR{L[$0]=FNR; next} L[$0]==FNR' probes_FLandPM.fasta probes_FLandPM.fasta > probes_FLandPM_uniq.fasta
```

<h5>Get maximum value in a column</h5>

```
awk 'BEGIN {max = 0} {if ($5>max) max=$5} END {print max}' 6666666.283533.gff
```

<h5>Extract based on non-duplicate names on column 1</h5>

```
awk '{k=($1 FS $2 FS $3 FS $4)} {a[$1]++;b[$1]=k}END{for(x in a)if(a[x]==1)print b[x]}' oblat-FLprobes_80.out > oblat-FLprobes_80uniq.out
```

<h5>Multiple calculation using awk<h5>

```
grep -v "#" oblast_flower| awk '{if ($3 >99.9 && $4 > 100)  {print}}' | head
# && = AND; || = OR
```

<h5>Remove pattern and 1 line immediately preceeding the pattern. This is used to remove probes that are repeat masked</h5>

```
sed -s 'N;/pattern/!P;D' repeatN.fasta #for masked repeats, pattern= N
```

<h5>R set transparent points in scatterplot</h5>

```
ggplot(ld.df, aes(distance,LD.data))+
  geom_point(alpha=1/10, col="blue")
```
  
<h5>R coerce numeric factor to a numeric variable</h5>

```
ld_data$LD <- as.numeric(as.character(ld_data$LD))
```

<h5>Find how many cores is the current job using</h5>

```
squeue -o"%.7i %.9P %.8j %.8u %.2t %.10M %.6D %C" | grep "dev.p"
squeue --Format=jobid,username,account,statecompact,starttime,timelimit,numcpus | grep "dev.pa "
```

<h5>Print all columns except the first two from a file </h5>

```
awk '{$1=$2=""; print $0}' file.txt
```

<h5>Construct Incomplete Block Design in R</h5>

```
library(agricolae)
trt<-1:200
t <- length(trt)
# size block k
k<-10
# Blocks s
s<-t/k
# replications r
r <- 3
outdesign<- design.alpha(trt,k,r,serie=2)
book<-outdesign$book
plots<-book[,1]
dim(plots)<-c(k,s,r)
for (i in 1:r) print(t(plots[,,i]))
outdesign$sketch

```

<h5>Convert matrix to numeric matrix</h5>

```
mmat<- matrix(as.numeric(unlist(mat1)),nrow=nrow(mat))
```

<h5>Remove line breaks eg in fasta file</h5>

```
tr -d '\n' < file.fasta 
```

<h5>Replace special characters - use backslash </h5>

```
sed  's/\.\/\.\/\.\/\.\/\.\/\.\/\.\/\.\/\.\/\.\/\.\/\./\.\/\.\/\.\/\.\/\.\/\.\/\.\/\./g' file.txt
```

<h5>Rename fasta files with numbers per line</h5>

```
awk '//{print ">F_ngssr" ++i;}{print; next}' < forward_1926.txt > forward_1926.fasta
awk '//{print ">R_ngssr" ++i;}{print; next}' < reverse_1926.txt > reverse_1926.fasta

```

<h5>View lines from 43rd line</h5>

```
tail -n +43 file.txt
```

<h5>Convert bmp to jpg</h5>

```
module load imagemagick/6.8.8-9
convert headgeno5b.LD_D.bmp headgeno5ld.jpg
```
<h5>Case insensitive grep</h5>

```
 grep -i TGTTTCACGTGAAACA 06.fixstart.fasta
 ```
 
<h5>Change prompt display on bash to $ instead of long directory name</h5>

```
PS1="$"
```

<h5>Open display on windows bash</h5>

```
Open Xming
export DISPLAY=:0
java -jar -Xms1024m -Xmx1024m jspecies1.2.1.jar
```

<h5>Convert tab to csv</h5>

```
perl -lpe 's/"/""/g; s/^|$/"/g; s/\t/","/g' < input.tab > output.csv
```

<h5>Get unique values in 2 files</h5>

```
grep -F -x -v -f file_1 file_2 
```

<h5>Google form number of words regex</h5>

```
new
^(?:\b\w+\b[\s\r\n!"#$%&'()*+,-./:;<=>?@\[\]^_`{|}~]*){1,300}$


^\W*(\w+(\W+|$)){1,300}$

[\s]{1,299}

Final
^[-\w]+(?:\W+[-\w]+){1,300}\W*$
```

<h5>Get only top blast hit</h5>

```
blastn -db trop -query blast.fa -outfmt "6 qseqid sseqid" -max_target_seqs 1 -out results.txt
sort -u results.txt > singlehit.txt
```

```
blastn -db trop -query blast.fa -outfmt "6 qseqid sseqid" -max_target_seqs 1 | sort -u > singlehit.txt
```

<h5>Extract uniquely mapped reads from bam files </h5>
<h6>bwa-aln</h6>
If you read the SAM format, every tag starting with X,Y,Z is reserved to the particular tool. And in bwa-aln, Heng Li decided to assign XT:R to reads multi-mapping. So you filter for unique ones (XT:A:U) and still some reads would have very few alternative sites (so you filter out those ones having XA alternative sites), leaving you with unique reads.

```
samtools view -F 4 bwa_4c11aln.sam | grep "XT:A:U" | grep -v "XA:" | wc -l
```

<h6>bwa-mem</h6>
Bwa-mem is a bit different. XT:R doesn't exist and you map with -M to get backwards compatibility to Picard. Picard does not support the newest 2048 flag but the 256 one for secondary alignments. So you first do the same samtools view filter, getting rid of not mapped reads and secondary alignments. But in bwa-mem, the tags have changed!
XA: to report alternative sites and SA is a new flag to tag so-called split alignments for chimera reads.

```
samtools view -F 4 bwa_4c11mem.sam | grep -v "XA:Z" | grep -v "SA:Z" | wc -l
```

BWA-SW was designed for long-reads and has been superseded by bwa-mem.

<h6>bowtie2</h6>

```
grep -E "@|NM:" 4c11_bt2_vsl.sam | grep -v "XS:" | grep -v "@"| wc -l
```

<h5>Check if bam file is sorted or not</h5>

```
zcat rd_36c20.bam.gz | samtools view -H
IF sorted: @HD     VN:1.5  SO:coordinate
IF unsorted: @HD    VN:1.0    SO:unsorted

```


<h5>Blast output tabular headers</h5>

```
queryId, subjectId, percIdentity, alnLength, mismatchCount, gapOpenCount, queryStart, queryEnd, subjectStart, subjectEnd, eVal, bitScore
```

<h5>Rename uneak tags to give a number to each tag</h5>

```
 awk '{print NR,$0}' napiergrass_uneaktagsc.fa |awk '{print ">"$1"\n"$2}'>napiergrass_uneaktags_count.fa
 ```
 
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
```
head file.fasta -n 2| grep -v ">" | wc | awk '{print $3-$1}'
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
du -sh *
du -sh * | sort -hr
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

<h5>Merge the 2 files but keep header from only first file. </h5>

```
awk 'FNR==1 && NR!=1{next;}{print}' *.txt > myGBSProject_key.txt
```

<h5>Replace characters</h5>replaces old with new

```
sed -i 's/old/new/g' filename.fasta
```

```
sed -i 's/old//g' filename.fasta
``` 
# removes old

<h5> Using variables in bash </h5>

```
#!/bin/bash
STR="Hello World!"
echo $STR 
```
<h5>grep for multiple patterns</h5>

``` 
grep "early\|late" filename.txt > pattern.txt
```

<h5>Find number of columns in a file</h5>

```
awk '{print NF}' filename.txt | sort -nu | tail -n 1
```

<h5>Store stdin into a txt file and append to it</h5>

```
command | tee -a log.txt
```

<h5>Replace #### in vcf file with ##</h5>

```
sed -i 's/####/##/' myGBSGenos_chr*.vcf
```

<h5>Count number of raw reads per barcode in gbs data</h5>

```
awk 'substr($1,2,9)~/TGACGCCA/' C7U82ANXX_7_fastq | wc -l
```

```
perl -ne 'print if( (/@/ && ($end=1))..!$end-- )' C7U82ANXX_7_fastq | grep -v "@"| awk 'substr($1,2,9)~/TGACGCCA/' | tee -a test1adapter.txt
```
#Use stacks instead :)

<h5>Get the names of progenies from all files to be used in STACKS</h5>

```
for i in *.fq; do echo -n " -r ./samples_7/$i"; done
```
