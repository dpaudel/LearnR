######################################
## INTRODUCTION TO R SOFTWARE       ##
## AGR 5266C: Field Plot Techniques ##
## FALL 2018                        ##
## rramadeu at ufl dot edu          ##  
######################################

## Before Start
## Create a folder for your project
## Example: ~/Desktop/RLab
## Open RStudio
## Create an R script (.R extension)

print("Hello World!")

## Save it

## Programming practices

## Comments!


## Working Directory
getwd()
setwd("?") ##fill with your path to archives

## RStudio: Session -> Set Working Directory -> ...
## Linux =/= Windows =/= Mac


## Sum
3+3 #I can comment or annotate my scripts by writing after the # sign

## Division
(3+3)/3

## Multiplication
3*3*3

## Potence
3^3

## Square Root
9^0.5
sqrt(9)

## Logarithm
log(10) # base = natural log base ~  2.718 (irrational number)
log(10,base = 10)
log(10,base = 2)                            
log(exp(3))

## Need help?
?sqrt
?log

## Function within a function
log( sqrt(9) )
log(3)

## CREATING OBJECTS
## Object classes
x = 1
y = "treatment_A"
z = 1<0

class(x)
class(y)
class(z)

## Creating vectors
dice = c( 1, 2, 3, 4, 5, 6 )
letters = c( "A", "B", "C" )

mean(dice)
sum(dice)
cumsum(dice)
sd(dice)
var(dice)

mean(letters)
mean(dice)

##################### INPUT & OUTPUT ######################

## Setting working directory
setwd("~/Desktop/RLab") #Can be done by going to Session > Set Working Directory > Choose Directory
getwd() #Get working directory
# https://raw.githubusercontent.com/dpaudel/cheatsheet/master/Wheat_91.txt
# https://raw.githubusercontent.com/dpaudel/cheatsheet/master/wheatc.csv

## Read a file (Example 9.1 from Clewer & Scarisbrick
wheat <- read.table("Wheat_91.txt", header=T)
# wheat <- read.csv("wheatc.csv", header=T) 
wheat

fix(wheat)

print(wheat)
head(wheat) #View top 6 lines of data
head(wheat, n=10) # View top 10 lines of data
tail(wheat)
dim(wheat) #find the dimension of data (row, column)
str(wheat) #find the structure of data


#### Addressing columns by name ######
#columns can be addressed by name, with either $ or square brackets wheat[,'variety']
print(wheat$variety)
wheat[,'variety']

wheat$SN <- c(1:nrow(wheat))


## Subsetting
## subsetting is obtained by [row,column]

## First value in leafdata, row 1, column 1
wheat[1,1]

## row 15, column 3
wheat[15,3]

# We can use the function c, which stands for combine to select more than 1 rows or columns
wheat[c(1,3), c(2,3)]

#We frequently want to select contguous rows or columns, such as the first ten rows, and columns 3 through 5. We can use c for this, but it is more convenient to use : operator. This function generates sequences of numbers
1:5
3:15

#Subset first 10 rows and last 3 columns
wheat[1:10, 2:3]
subset1 <- wheat[1:10, 2:3]
View (subset1)

#If you want to select all rows or all columns, leave that value empty
wheat[3,]
wheat[,3]

#All rows from column 2-3
wheat[,2:3]



#### using two functions at a time #### , here we are using subset and max or min, functions can be combined
wheat[,3]
max(wheat[,3])
min(wheat[,3])

####SUMMARY####
summary(wheat)

######PLOTTING#####
plot(wheat$yield,wheat$unit)

boxplot(wheat$yield~wheat$variety)

##LOGIC OPERATIONS
index_A = which(wheat$variety=="A")

wheat_A = wheat[index_A,]

View(wheat_A)
dim(wheat_A)
str(wheat_A)

## Writing or saving data
write.csv(wheat_A, file="wheat_A.csv") #this file is saved into your working directory
getwd()

## Letting just the data with yield > 25
index_thr25 <- which(wheat$yield > 25)
wheat_thr25 <- wheat[index_thr25,]


#Installing packages
#install.packages("agricolae") #this needs to be done only once

#installed package can be called by using library
library(agricolae)

## Analysis of Variance
model <- aov(yield~variety,data=wheat)
anova(model)
hsd_output <- HSD.test(model, trt="variety", alpha=0.05)
print(hsd_output)



set.seed(111)
x = rnorm(n = 10000, mean = 0, sd = 1)

dens_x <- density(x)
plot(dens_x)
plot(hist(x))

