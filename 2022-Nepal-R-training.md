# Introductory Data Analysis in R
Date: Friday, March 18, 2022, 8:30 PM EST - 10:30 PM EST 
### Instructors: Dr. Anil Adhikari, Dr. Dev Paudel
---
## Setup Instructions

Before the class, download and install the following two software in order:
1. R (https://cloud.r-project.org/)
2. Rstudio (https://www.rstudio.com/products/rstudio/download/#download)

Install R completely before installing Rstudio.

Create a folder / directory on your _Desktop_ and name it _RLab_.

Download the files wheatc.csv (https://raw.githubusercontent.com/dpaudel/LearnR/master/wheatc.csv) and Wheat_91.txt (https://raw.githubusercontent.com/dpaudel/LearnR/master/Wheat_91.txt) save them inside _RLab_ folder.

To download these files: 
1. Click on the link
2. Once the file opens on your browser, right-click on your mouse/trackpad and click _Save as_ and save to the _RLab_ folder.

Installation of packages:
Open RStudio

On the _console_ type the following and press _Run_
```
install.packages("dplyr")
install.packages("ggplot2")
install.packages("agricolae")
```

For future use
```
install.packages("tidyverse")
install.packages("readxl")
```
Installed packages can be loaded by calling ```library```
```
library(readxl)
```
or by using ```::```
```
readxl::read_excel("excelfile.xlsx")
```
