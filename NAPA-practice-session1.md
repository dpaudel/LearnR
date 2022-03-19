#### Begin R ####
# set working directory, this is where our data analysis will occur
setwd("C:/Users/dpaudel/Desktop/RLab") # ctrl + Enter
# write R script print
print("Hello World!")
print("string")
# Save as .R

# View current working directory
getwd()

# Let's do some maths
# Sum
3+3 #I can comment or annotate my scripts by writing after the # sign
#Division
12/4
#Multiplication
3*3
#Power
3^3
#Square Root
9^0.5
sqrt(9)
#Logarithm
log(10)
# Need help?
?sqrt
# Function within a function
log(sqrt(9))

#CREATING OBJECTS
#Object classes
x = 1
x
x <- 2
x
y = "treatment_A"
z = 1<0

class(x)
class(y)
class(z)

#Creating vectors # c = combine
dice = c( 1, 2, 3, 4, 5, 6 )
dice
letters = c( "A", "B", "C" )
letters

mean(dice)
sum(dice)
sd(dice)
var(dice)

mean(letters)

##################### INPUT & OUTPUT ######################

# Get working directory
getwd()
# View files in current working directory
dir()
list.files()
# import .txt file 
wheat_t <- read.table("Wheat_91.txt", header=T)
head(wheat_t)
# import .csv file
wheat <- read.csv("wheatc.csv", header=T)
head(wheat)
# Import from web url
wheat1 <- read.csv("https://raw.githubusercontent.com/dpaudel/LearnR/master/wheatc.csv", header=T)
head(wheat1)

# print and view head, tail, dimensions, and structure of data
head(wheat)
head(wheat, n=10)
tail(wheat)
dim(wheat)
str(wheat)
# Addressing columns by name
# columns can be addressed by name, with either $ or square brackets wheat[,'variety']
wheat[1,1]
wheat[1:5,1:2]


# Subsetting
# subsetting is obtained by [row,column]
# First value in wheat data, row 1, column 1
subset1 <- wheat[1:10,]
head(subset1)
View(subset1)

# row 15, column 3
wheat[15,2]
#We can use the function c, which stands for combine to select more than 1 rows or columns
wheat[c(1,3),c(1,2)]

#We frequently want to select contguous rows or columns, such as the first ten rows, and columns 3 through 5. We can use c for this, but it is more convenient to use : operator. This function generates sequences of numbers
#Subset first 10 rows and last 3 columns



#If you want to select all rows or all columns, leave that value empty
wheat[2,]
wheat[,1]

# using two functions at a time #### , here we are using subset and max or min, functions can be combined
max(wheat[,2])

####SUMMARY####
summary(wheat)
Wheat_91 <- read.delim("C:/Users/dpaudel/Desktop/RLab/Wheat_91.txt")
View(Wheat_91)

#install.packages("agricolae")
library(agricolae)
dplyr::filter()

