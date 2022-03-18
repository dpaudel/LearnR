#### Begin R ####
# set working directory, this is where our data analysis will occur

# write R script print

print("Hello World!")

# Save as .R

# View current working directory


# Let's do some maths
# Sum
 #I can comment or annotate my scripts by writing after the # sign
#Division

#Multiplication

#Power

#Square Root


#Logarithm

# Need help?

# Function within a function


#CREATING OBJECTS
#Object classes
x = 1
y = "treatment_A"
z = 1<0

class(x)
class(y)
class(z)

#Creating vectors
dice = c( 1, 2, 3, 4, 5, 6 )
letters = c( "A", "B", "C" )



##################### INPUT & OUTPUT ######################

# Get working directory
getwd()
# View files in current working directory
dir()
# import .txt file 
wheat_t <- read.table("Wheat_91.txt", header=T)

# import .csv file
wheat<-read.csv("wheatc.csv", header=T)

# Import from web url
wheat <- read.csv("https://raw.githubusercontent.com/dpaudel/LearnR/master/wheatc.csv", header=T)

# print and view head, tail, dimensions, and structure of data


# Addressing columns by name
# columns can be addressed by name, with either $ or square brackets wheat[,'variety']
           

# Subsetting
# subsetting is obtained by [row,column]
# First value in wheat data, row 1, column 1


# row 15, column 3

#We can use the function c, which stands for combine to select more than 1 rows or columns


#We frequently want to select contguous rows or columns, such as the first ten rows, and columns 3 through 5. We can use c for this, but it is more convenient to use : operator. This function generates sequences of numbers
#Subset first 10 rows and last 3 columns



#If you want to select all rows or all columns, leave that value empty



# using two functions at a time #### , here we are using subset and max or min, functions can be combined


####SUMMARY####


