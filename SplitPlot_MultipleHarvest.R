###NIRS THESIS###
setwd('C:/Users/AM/Desktop/BN/NIRS')
library(lubridate)
library(tidyverse)
library(agricolae)
library(emmeans)
library(lsmeans)
library(ggplot2)
library(lme4)
library(nlme)
library("lme4")
library("lmerTest")
library("languageR")
library(afex)  #for p-values
library(lattice)
library(multcompView)
library(multcomp)
library(dpaudelR)

NIRS<-read.csv("NIRS_THESIS.csv",header = T,check.names = F, na.strings = "#VALUE!") %>% data.frame()

##Turning Values into numeric
NIRS$Sample <- as.numeric(NIRS$Sample)
NIRS$ADF <- as.numeric(NIRS$ADF)
NIRS$DM <- as.numeric(NIRS$DM)
NIRS$K <- as.numeric(NIRS$K)
NIRS$P <- as.numeric(NIRS$P)
NIRS$IVTDMD30 <- as.numeric(NIRS$IVTDMD30)
NIRS$IVTDMD48 <- as.numeric(NIRS$IVTDMD48)
NIRS$FAT <- as.numeric(NIRS$FAT)
NIRS$dNDF30 <- as.numeric(NIRS$dNDF30)
NIRS$dNDF48 <- as.numeric(NIRS$dNDF48)
NIRS$Lignin <- as.numeric(NIRS$Lignin)
NIRS$CP <- as.numeric(NIRS$CP)
NIRS$aNDF <- as.numeric(NIRS$aNDF)
NIRS$Ca <- as.numeric(NIRS$Ca)
NIRS$Mg <- as.numeric(NIRS$Mg)

colnames(NIRS)<-c("Sample", "Block", "Harvest", "Genotype", "Treatment", "ADF", "DM", 
                         "K", "P", "IVTDMD30",	"IVTDMD48",	"FAT",	"ESC",	"WSC",	"dNDF30",
                         "dNDF48", "CP",	"aNDF",	"Ash",	"Lignin",	"Fructan",	"Ca",	"Mg")
NIRS$Genotype <- as.factor(NIRS$Genotype)
NIRS$Treatment <-as.factor(NIRS$Treatment)
NIRS$Harvest <- as.factor(NIRS$Harvest)
NIRS$Block <- as.factor(NIRS$Block)
str(NIRS)
summary(NIRS)

levels(NIRS$Genotype)
levels(NIRS$Harvest)

#BOXPLOT CP
boxplot(CP~Harvest, data=NIRS)
boxplot(CP~Block, data=NIRS)
boxplot(CP~Treatment, data=NIRS)
boxplot(CP~Genotype, data=NIRS)
hist(NIRS$CP, main= "CP", xlab="Length")

#BOXPLOT ADF
boxplot(ADF~Harvest, data=NIRS)
boxplot(ADF~Block, data=NIRS)
boxplot(ADF~Treatment, data=NIRS)
boxplot(ADF~Genotype, data=NIRS)
hist(NIRS$ADF, main= "ADF", xlab="Length")

#BOXPLOT dNDF48
boxplot(dNDF48~Harvest, data=NIRS)
boxplot(dNDF48~Block, data=NIRS)
boxplot(dNDF48~Treatment, data=NIRS)
boxplot(dNDF48~Genotype, data=NIRS)
hist(NIRS$dNDF48, main= "NDF48", xlab="Length")

#BOXPLOT K
boxplot(K~Harvest, data=NIRS)
boxplot(K~Block, data=NIRS)
boxplot(K~Treatment, data=NIRS)
boxplot(K~Genotype, data=NIRS)
hist(NIRS$K, main= "Potassium", xlab="Length")

#BOXPLOT P
boxplot(P~Harvest, data=NIRS)
boxplot(P~Block, data=NIRS)
boxplot(P~Treatment, data=NIRS)
boxplot(P~Genotype, data=NIRS)
hist(NIRS$P, main= "Phosphorous", xlab="Length")

hist(as.double(NIRS$P))
aggregate(P~Harvest+Treatment,data=NIRS,FUN=mean)
aggregate(P~Harvest,data=NIRS,FUN=sd)

#BOXPLOT Ca
boxplot(Ca~Harvest, data=NIRS)
boxplot(Ca~Block, data=NIRS)
boxplot(Ca~Treatment, data=NIRS)
boxplot(Ca~Genotype, data=NIRS)
hist(NIRS$P, main= "Calcium", xlab="Length")

#BOXPLOT Mg
boxplot(Mg~Harvest, data=NIRS)
boxplot(Mg~Block, data=NIRS)
boxplot(Mg~Treatment, data=NIRS)
boxplot(Mg~Genotype, data=NIRS)
hist(NIRS$P, main= "Magnesium", xlab="Length")

#BOXPLOT Lignin
boxplot(Lignin~Harvest, data=NIRS)
boxplot(Lignin~Block, data=NIRS)
boxplot(Lignin~Treatment, data=NIRS)
boxplot(Lignin~Genotype, data=NIRS)
hist(NIRS$P, main= "Calcium", xlab="Length")





### MODEL
model_1<-aov(P~Block+Treatment*Genotype*Harvest+Error(Block/Treatment/Genotype/Harvest), data=NIRS)
  summary(model_1)

  par(mfrow=c(2,2))
  plot(model_1)

  # aov(response ~ time * sp * trt + Error(block/trt/sp), data = d3)
model2<-aov(P~Block+Treatment*Genotype*Harvest+Error(Block/Treatment/Genotype/Harvest), data=NIRS)
summary(model2)  
plot(model2)
plot(model2$`Block:Treatment`$residuals, model2$`Block:Treatment`$fitted.values)
model1 <- ExpDes::strip(NIRS$Genotype, NIRS$Harvest, NIRS$Block, NIRS$P, quali = c(TRUE, TRUE), mcomp = "sk", fac.names = c("Genotype", "Harvest"), sigT = 0.05, sigF = 0.05)
# fat3.rbd(factor1, factor2, factor3, block, resp, quali = c(TRUE, TRUE, TRUE),mcomp = "tukey", fac.names = c("F1", "F2", "F3"), sigT = 0.05, sigF = 0.05)

ExpDes::fat3.rbd(NIRS$Harvest, NIRS$Genotype, NIRS$Treatment, NIRS$Block, NIRS$P, quali = c(TRUE, TRUE, TRUE),
         mcomp = "tukey", fac.names = c("Harvest", "Genotype", "Treatment"), sigT = 0.05, sigF = 0.05)

###Multiple means separation with lsmeans library
  #lsmeans(model_1, ~Genotype)
  
#Alternative means separation using Agricolae library
  #(HSD.test(model_1,"Genotype"))
  
#Create a table with the means and SE
 #RCBD_P<-lsmeans(model_1, ~Genotype)
 #RCBD_P<-summary(RCBD_P)
  
#Tukey Test
  #TukeyHSD(model_1)
  
  ###bind_rows(summary(model_1)) %>% copy2clipboard()### COPYING A TABLE IN R
  
  #### DATA EXPLORATING
  # rstd<-residuals(mdl_sorghum,type="response")  # Simple residuals
  # fitvalue<-fitted(mdl_sorghum)
  # diagnostics(rstd,fitvalue)
  
  
  ## LSMEANS FUNCTION
  ### Treatment and Rate
  (lsm_mdl_1<-emmeans(model_1, ~  Treatment*Harvest,  adjust='Tukey'))
  
  
  # Compare the two contrasts for each order
  contrast(lsm_mdl_1, "revpairwise", by = "Harvest")
  
  contrast(lsm_mdl_1, "revpairwise", by = "Treatment")
  
  
  #### grouping by letters
  # Treatment x Harvest 
  multcomp::cld(lsm_mdl_1, by="Harvest", sort = TRUE, reversed = TRUE, Letters = "abcdefgh", alpha = .05)
  multcomp::cld(lsm_mdl_1, by="Treatment", sort = TRUE, reversed = TRUE, Letters = "abcdefgh", alpha = .05)
  
 

###bind_rows(summary(model_1)) %>% copy2clipboard()### COPYING A TABLE IN R

#### DATA EXPLORATING
# rstd<-residuals(mdl_sorghum,type="response")  # Simple residuals
# fitvalue<-fitted(mdl_sorghum)
# diagnostics(rstd,fitvalue)


## LSMEANS FUNCTION
### Treatment and Rate
(lsm_mdl_2<-emmeans(model_1, ~  Treatment*Harvest,  adjust='Tukey'))


# Compare the two contrasts for each order
contrast(lsm_mdl_1, "revpairwise", by = "Harvest")

contrast(lsm_mdl_1, "revpairwise", by = "Treatment")


#### grouping by letters
# Treatment x Harvest 
cld(lsm_mdl_1, by="Harvest", sort = TRUE, reversed = TRUE, Letters = "abcdefgh", alpha = .05)
cld(lsm_mdl_1, by="Treatment", sort = TRUE, reversed = TRUE, Letters = "abcdefgh", alpha = .05)


# Preparing the output as a matrix

(data_for_graph_1<-summary(lsm_mdl_1, infer = c(TRUE,TRUE), level = .95, adjust = "Tukey"))

## Code to make the graphs

ggplot(data_for_graph_1, aes(x=Harvest, y=emmean, fill=Treatment)) + 
  geom_bar(position=position_dodge(), stat="identity",
           colour="black", # Use black outlines,
           size=.5) + scale_fill_brewer(palette = "Set3")+      # Thinner lines 
  geom_errorbar(aes(ymin=emmean-SE, ymax=emmean+SE),
                size=.4,    # Thinner lines
                width=.5,
                position=position_dodge(.9))+ 
  ylab("Mean")+ 
  #ylim(0,13000)+
  scale_y_continuous(breaks=c(0,5,10,15,20))+
  xlab("Harvest Date") +
  guides(fill=guide_legend(title="Fertilizer Treatment"))+
  theme_bw()+
  theme(
    axis.title= element_text(size = "12", color="black", hjust = 0.5, vjust=0),
    axis.text.y = element_text(colour = "black", size="12", hjust = 0),
    axis.text.x = element_text(colour = "black", size="12",angle =0, hjust = 0.5, vjust =0),
    legend.title = element_text(colour = "black", size = "12"), legend.text = element_text(size = "12"),legend.position="bottom")



# Preparing the output as a matrix
(data_for_graph_2<-summary(lsm_mdl_2, infer = c(TRUE,TRUE), level = .95, adjust = "Tukey"))



###Checking for Assumptions
hist(NIRS$CP, xlab = "%", main="Crude Protein")
qqnorm(NIRS$CP)



# ##Plotting DM Yield x Genotype
# boxplot(DMYieldKg_ha~Subplot, main="DM Yield x Genotype",fill=Subplot,xlab="Genotype", ylab="Kg/Ha" )
# ##Plotting DMYield ~ Genotype x Harvest
# qplot(factor(Date), DMYieldKg_ha, data=Harvest2018, geom=c("boxplot"),
#       main="DM Yield x Harvest",fill=Subplot,xlab="Harvest", ylab="Kg/Ha")
# 
# qplot(factor(Subplot), DMYieldKg_ha, data=Harvest2018, geom=c("boxplot"),
#       main="DM Yield x Genotype",fill=Subplot,xlab="Genotype", ylab="DM Yield Kg/Ha")
# 
# qplot(factor(Treatment), DMYieldKg_ha, data=Harvest2018, geom=c("boxplot"),
#       main="DM Yield",fill=Treatment, xlab="Treatment", ylab="Kg/Ha")
# 
# qplot(factor(Date), DMYieldKg_ha, data=Harvest2018, geom=c("boxplot"),
#       main="DM Yield",fill=Date,xlab="Genotype", ylab="Kg/Ha")



