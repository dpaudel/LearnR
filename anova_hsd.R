# Title: Anova HSD and Barplotter
# Version: 0.1
# Authors: Dev Paudel, email="dpaudel@outlook.com"
# Description: Given a dataset and linear model, the program runs ANOVA, HSD, and plots a barplot with standard errors
# Depends: R (>= 3.1.0)
# License: CC0
# Syntax: anova_hsd("DependentVariable~IndependentVariable", data)
# Example: anova_hsd("Petal.Length~Species", iris)

# The codes will let users select a .csv file and run an ANOVA analysis with HSD ranking

#### Installation of required packages ####
# Install required packages if they are not already installed.
if(!require(Rmisc))install.packages("Rmisc")
if(!require(agricolae))install.packages("agricolae")
if(!require(dplyr))install.packages("dplyr")
if(!require(ggplot2))install.packages("ggplot2")

#### Function to calculate ANOVA and plot results ####

## ANOVA and HSD
# define function for anova
anova_hsd <- function (user_model, datafile){
  model1a <- as.formula(user_model)
  user_treatment <- as.character(formula(user_model))[2]
  user_group <- as.character(formula(user_model))[3]
  datafile <- datafile %>% mutate_at(user_group, as.factor) %>% mutate_at(user_treatment, as.numeric)
  
  aov1 <- aov(model1a, data=datafile)

# ANOVA Assumptions
  par(mfrow=c(2,2))
  plot(aov1)

# print ANOVA results
  print("ANOVA table")
  aov1_summary <- summary(aov1)
  capture.output(aov1_summary, file = "results_anova.txt")
  print(aov1_summary)
  
# Tukey HSD
  hsd_aov1 <- agricolae::HSD.test(aov1, user_group, group=TRUE)
  
# Sort
  order_aov1 <- hsd_aov1$groups[order(rownames(hsd_aov1$groups)),]
  
# Get summary statistics from Rmisc package
  data_stats <- Rmisc::summarySE(datafile, measurevar= user_treatment , groupvars= user_group, na.rm=TRUE)
  
# Merge HSD grouping and summary statistics and print results
  print("HSD ranking")
  data_merged <- dplyr::left_join(data_stats, order_aov1)
  capture.output(data_merged, file = "results_hsd.txt")
  print(data_merged)
  
## Plotting 
  
# Create standard error bars for plots
  yerr_names1 <- colnames(data_merged)[c(3,5)]
  yerrbar1 <- aes_string(ymin = paste(yerr_names1, collapse = '-'), 
                         ymax = paste(yerr_names1,collapse='+'))
  
# Nudge amount for extreme cases
  nudge_amt <- 0
  if (mean(data_merged$se, na.rm=T) < 1){
    nudge_amt <- 5*mean(data_merged$se, na.rm=T)
  } else {
    nudge_amt <- 2*mean(data_merged$se, na.rm=T)}
  
# Plot the graph
  plot1 <- ggplot(data_merged, aes_string(x=user_group, y=user_treatment, fill=user_group))+
    geom_bar(position=position_dodge(.5), stat="identity", colour="black", width = 0.5)+
    geom_errorbar(mapping = yerrbar1, width=0.2)+
    geom_text(nudge_y=nudge_amt, label=data_merged$groups,  size=4) +
    ggtitle("HSD grouping")+
    theme_bw()
  return(plot1)
  plotname=paste0('plot_',user_treatment,"_",user_group,".png")
  ggsave(filename = plotname, width=7, height=5.5, dpi=300)
}

#### Run the program ####

# read data file
data1 <- read.csv("iris.csv")
# run the program
anova_hsd("Petal.Length~Species", data1)
