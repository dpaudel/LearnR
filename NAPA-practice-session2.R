rm(list=ls())

# check your working directory
getwd()

# View the file names
list.files()

# Use correct file name to run input commands
dat1 <- read.csv("Wheatc.csv")

# checking for data accuracy

# basic histogram for distribution
hist(dat1$yield, main = "Yield ~ variety", xlab = "yield")

# Analysis of variance  
model1 <- lm(yield ~ variety, data = dat1)
dat1$variety <- as.factor(dat1$variety)
summary(model1)
anova(model1)

# check model fit 
plot(model1)

# Post-hoc mean comparison
library(agricolae)

# Tukey's HSD
HSD <- HSD.test(model1,"variety", alpha = 0.05, group = TRUE)
HSD

# LSD test
out<-LSD.test(model1,"variety")
out

# bar graphs with SD
# extract means and SD
Means <-out$means$yield
SD <- out$means$std

tbl <- data.frame(Variety = rownames(out$means), Means = Means, SD = SD)
head(tbl)

library(ggplot2)
ggplot(tbl, aes(x = Variety, y=Means, fill = Variety)) + 
  geom_bar(stat = "identity", width = 0.7, color = "black") + 
  geom_errorbar(aes(ymin = Means - SD, ymax = Means + SD), width = 0.2) + 
  theme_bw()

# create a boxplot
ggplot(dat1, aes(x=variety, y=yield, fill = variety)) +
  geom_boxplot() + theme_bw()
#__________________________________________________________

# RCBD design
dat3 <- read.csv("https://raw.githubusercontent.com/dpaudel/LearnR/master/Breed_RCBD.csv")

# review data
str(dat3)
dat3$block <- as.factor(dat3$block)
dat3$Treatment <- as.factor(dat3$Treatment)

# histogram
hist(dat3$Yield)

#boxplots
ggplot(dat3, aes(x=Treatment, y=Yield, fill = Treatment)) +
  geom_boxplot()

# fit model
model2 <- lm(Yield ~ block + Treatment, data = dat3)
summary(model2)

# Anova
anova(model2)

# HSD
HSD2 <- HSD.test(model2,"Treatment")
HSD2

# LSD
# LSD test
out2<-LSD.test(model2,"Treatment")
out2
