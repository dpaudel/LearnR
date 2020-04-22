# Split plot RCB

```
#### correct method ####
bake <- read.table("https://online.stat.psu.edu/onlinecourses/sites/stat502/files/lesson08/baketime_data.txt", header=T)
head(bake)
```
### expdes
```
bake_exp <- split2.rbd(bake$temp, bake$time, bake$rep, bake$resp, fac.names=c('temp','time')) # correct
bake1 <- transform(bake, rep=factor(rep), temp=factor(temp),time=factor(time))
```
### aov
```
bake_aov1 <- aov(resp~temp*time+Error(rep/temp/time), data=bake1)
summary(bake_aov1)
```
### lm
```
bake_lm <- lm(resp~rep+temp+rep:temp+time+temp:time, data=bake1)
aovlm <- aov(bake_lm)
summary(aovlm)
```



##ANOVA as a Split Plot RIGHT MODEL

```

model.yield <- aov(Yield~TrA*TrB+Error(Rep/Wplot/Splot),data)
summary(model.yield)
TrB.comp <- lsmeans::lsmeans(model.yield,~TrB, adjust = "mvt" )
plot(TrB.comp)
TrB.comp

names(model.yield)
model.yield["Rep:Wplot"]
model.yield["(Intercept)"]
m.pr.1 <- proj(model.yield)
data$trans.yield <- sqrt(40 + data$Yield)
model.yield.2 <- aov(trans.yield~TrA*TrB+Error(Rep/Wplot/Splot),data)
m.pr.2 <- proj(model.yield.2)
hist(data$trans.yield)


#residual.2 <- m.pr[[2]][ ,"Residuals"]
#residuals.3 <- m.pr[[3]][ ,"Residuals"]
extract.res.1 <- m.pr.1[[4]][ ,"Residuals"]
extract.res.2 <- m.pr.2[[4]][, "Residuals"]


#(temp <- data.frame(residual.2, residuals.3, extract.res))
par(mfrow = c(1, 2))
qqnorm(extract.res.1)
qqline(extract.res.1)

qqnorm(extract.res.2)
qqline(extract.res.2)

dev.off()
plot(model.yield)

hist(residuals(yield))
```
