# R Demo 2020 Rios lab

```
suppressPackageStartupMessages({
  library(fBasics)
  require(agricolae)
  require(fBasics)
  require(lattice)
  #require(asbio)
  require(ExpDes)
  library(fBasics)
  library(ExpDes)
  library(EMSaov)
  library(afex)
  library(lme4)
  library(multcompView)
  library(ggplot2)
  library(dplyr) })
```

# Topic 1: RCBD (Randomized Complete Block Design) one way ANOVA

```
rm(list = ls())
setwd("C:/Users/dpaudel/Downloads/R demo")
bean <- read.table("bean.txt",header=T)
head(bean)
str(bean) # data structure
```
### Anova
```
aov.bean <- aov(tons ~ block + cultivar, data=bean)
anova(aov.bean) 
```

### transform block and cultivas as factor
```
bean1 <- transform(bean, block=factor(block), cultivar=factor(cultivar))
str(bean1)
head(bean1)
```
### ANOVA
```
aov.bean1 <- aov(tons ~ block + cultivar, data=bean1)
anava <- anova(aov.bean1) 
```

### Normality of the error distributions 

##### capture residuals
```
res.bean <- aov.bean1$residuals 
```
##### Shapiro- Wilk test (observation: until 5000 observations)
```shapiro.test(res.bean) ```

##### QQ-plot 
```
qqplot <- qqnormPlot(res.bean) 
cor(qqplot$x,qqplot$y, method = "pearson")
```

### Homoscedasticity

##### Option 1: Anscombe & Tukey's Homoscedasticity test

```
attach(bean1)
# anscombetukey(resp, trat, block, glres, msres, sstrat, ssblock, residuals, fitted.values)
anscombetukey(tons, cultivar, block, anava[3,1], anava[3,3], anava[2,2], anava[1,2], aov.bean1$residuals, aov.bean1$fitted.values)
```
##### Option 2: Bartlett's Test
```
bartlett.test(tons ~ cultivar, data = bean1)
bartlett.test(tons ~ block, data = bean1)
```
##### Option 3: Graphic option with boxplot

**Variance across cultivars**
```boxplot(bean$tons ~ bean$cultivar)```

**variance across blocks**
```boxplot(bean$tons ~ bean$block)```

### predicted vs actual plot
```
par(mfrow = c(2, 2))
plot(aov.bean1); layout(1)
```

### Tukey's honestly significant difference (HSD) post hoc test (agricolae package)
```
post_hoc <- HSD.test(aov.bean1,"cultivar", group=T)
plot(post_hoc, las=1 , col="brown",main = "Test Tukey - Bean Trial") # las=1 --> vertical label axis style
```
Tukey's test (Stats package)
```
post_hoc2 <- TukeyHSD(x=aov.bean1,"cultivar", conf.level=0.95)
plot(post_hoc2 , las=1 , col="brown")
```

# ExpDes function
rbd(bean$cultivar, bean$block, bean$tons, quali = TRUE, mcomp = "tukey", nl = FALSE, hvar='oneillmathews', sigT = 0.05, sigF = 0.05)


# ggplot visualization means + letter from  tukey test

# Creating data frame with cultivars, means and letters from tukey test 
result <- post_hoc$groups
Cultivar <- rownames(result)
result <- cbind(result, Cultivar)
result$groups <- as.character(result$groups)
groups <- result$groups
head(result)
str(result) # data structure

# First layer of the Graph
bean_graph <- ggplot(result, aes(x=Cultivar, y=tons, fill=Cultivar)) +
  geom_bar(stat="identity", position=position_dodge()) 

# add letter
bean_graph <-  bean_graph + geom_text(aes(label = groups, y = tons + 0.1), position = position_dodge(0.9),vjust = 0)  

#add title, axis labels and theme
bean_graph <- bean_graph + labs(title= "Trial Bean 2018", y = expression(tons/~ha**-1))+
  theme_bw() # + theme(legend.position="none") #* remove legend if you want

bean_graph


# save plot with with resolution 
tiff("bean_trial_plot.tiff", width = 5, height = 4, units = 'in', res = 400) # can use png as well
bean_graph
dev.off() # save on your directory




#### Topic 2: RCBD Split plot ####

#----------------------------------------------------  #
rm(list=ls())
bean_ph <- read.table("bean_phosphorus.txt",h=T)
head(bean_ph)
str(bean_ph) # Needs transform to factors

bean_ph <- transform(bean_ph, cultivar = factor(cultivar), P = factor(P), Rep = factor(Rep), Prod = as.numeric(tons) )
str(bean_ph)  

# Fit model
model <- aov( tons ~ Rep + cultivar + P + cultivar*P, data= bean_ph)
anava <- anova(model)

#### ####
# Normality of the error distributions
shapiro.test(model$residuals)
qqnormPlot(model$residuals)

# Homoscedasticity
bartlett.test(tons ~ cultivar, data = bean_ph)
bartlett.test(tons ~ P, data = bean_ph)

# predicted vs actual plot
par(mfrow = c(2, 2))
plot(model); layout(1)

# ANOVA Using function of the ExpDes package
library(ExpDes)
# fat2.rbd(factor1, factor2, block, resp, quali = c(TRUE, TRUE), mcomp = "tukey", fac.names = c("F1", "F2"), sigT = 0.05, sigF = 0.05)
b_ph <- fat2.rbd(bean_ph$cultivar, bean_ph$P, bean_ph$Rep, bean_ph$tons, quali = c(TRUE, TRUE), mcomp = "sk", fac.names = c("Progenies", "Phosphorus"), sigT = 0.05, sigF = 0.05)


#- Create an graph with the results ---------------------------# 

# Standart error function
s_error <- function(x){ 
  sd(x)/sqrt(length(x))}  

# Summarise in average level
bean_ph_summary <- bean_ph %>%
  group_by(cultivar, P) %>%
  dplyr::summarise(mean = mean(tons), error =  s_error(tons))


# Graph
b_ph_plot <- ggplot(bean_ph_summary, aes(x=cultivar, y= mean, fill= P)) +
  geom_bar(stat="identity", position=position_dodge()) 

# Add error bar
b_ph_plot <- b_ph_plot +geom_errorbar(aes(ymin=mean-error, ymax=mean+error), width=.2, position=position_dodge(.9)) 

# add letters
# Create Matrix letter: cultivar in the columns and phosphorus in the rows
# Capital letters compare Phosphorus level within each Cultivar; Lower case letters compare Cultivars within each Phosphorus  level . Means followed by the same letter do not differ statistically by the Scott-Knott test at 5% probability.
letters <- c("a B", "a C" ,"a A", 
             "c B", "c C", "c A",
             "a B", "a C", "a A",
             "d B", "d C", "d A",
             'b B', 'b C', 'b A',
             "c B", "c C", "c A",
             "c B", "c C", "c A",
             "d B", "d C", "d A")


b_ph_plot <- b_ph_plot + geom_text(aes(label = letters, y = mean+error + 20), position = position_dodge(0.9),vjust = 0)  

#add title, axis labels and theme
b_ph_plot <- b_ph_plot + labs(title= "Trial: Bean vs Phosphorus", y = expression(tons/~ha**-1))+
  theme_bw() # + theme(legend.position="none") #* remove legend if you want

b_ph_plot



# Topic 3:  RCBD Strip plot (repeated measure in time)

#------------------------------------------------------------#
rm(list=ls())
turf <- read.csv("turf.csv",h=T)
str(turf) # Necessidade de transformação em fatores

turf <- transform(turf, Entry = factor(Entry), Rep = factor(Rep), Measure = factor(Measure))
str(turf)  
head(turf)


# Interaction plot

turf %>%
  ggplot() +
  aes(x = Measure, y = Value, color = Entry) +
  geom_line(aes(group = Entry)) +
  labs(title = "Coverage", y = "%", x = "Measure") +
  geom_point() + theme_bw() +
  theme(axis.text = element_text(size = 10, color="black"),
        legend.title = element_text(size = 15))
 

# Anova and poshoc test
# strip(factor1, factor2, block, resp, quali = c(TRUE, TRUE), mcomp = "tukey", fac.names = c("F1", "F2"), sigT = 0.05, sigF = 0.05)
turf_model <- strip(turf$Entry, turf$Measure, turf$Rep, turf$Value, quali = c(TRUE, TRUE), mcomp = "sk",
                    fac.names = c("Entry", "Measure"), sigT = 0.05, sigF = 0.05)


# add letters
# Create Matrix letter # cultivar in the columns and Measure in the rows
let <- c("a B","a A","a A","a A","a A","a A",
         "a A","a A","a A","a A","a A","a A",
         "a B","b B","a A","a A","b A","b B",
         "a B","b B","b B","a A","b B","b B",
         "a C","b B","a A","a A","b B","b B",
         "a B","b B","a A","a A","a A","b B")


# Create a graph
turf_mean <-turf %>% group_by(Entry, Measure) %>%
  dplyr::summarise(mean = mean(Value))

# Lattice graph
barchart(mean~Entry|Measure,data=turf_mean,scales=list(rot=c(45,0)),as.table=TRUE)


# ggplot graph
turf_plot <- ggplot(turf_mean, aes(x=Entry, y = mean, fill = Entry)) +
  geom_bar(stat="identity") +
  facet_wrap(~ Measure) +
  geom_text(aes(label = let, y = mean + 2), position = position_dodge(0.9),vjust = 0) +
  labs(title = "Coverage", y = "%", x = "Genotype")+
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 45)) 

turf_plot

# Save graph
tiff("turf_plot.tiff", width = 10, height = 6, units = 'in', res = 400) 
turf_plot
dev.off() # 



