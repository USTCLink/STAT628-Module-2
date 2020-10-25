# setwd("W:/UW_Class_2020_2021/628/Module2/")
rm(list = ls())
par(mfrow = c(1,1))

library(car)
library(MASS)
library(gvlma)

load("cleaned_data.RData")
# data = data[-c(172,182),]

data1 = data[-39,]

attach(data)
fit1 = lm(BODYFAT~., data = data[, -c(1,2,3,5,6,7,20,21)])
# fit2 = lm(BODYFAT~AGE + weight_kg + height_cm + weight_kg*height_cm, data = data1)
# par(mfrow = c(2,2), pty = "s")
plot(fit1)   
summary(fit1)

 

####  candidates

# step - variable selection - not delete any point
step_fit1 = step(fit1, direction = "both")
summary(step_fit1)
# step_fit1 = lm(BODYFAT~AGE+NECK+ABDOMEN+HIP+THIGH+FOREARM+WRIST+weight_kg,     ### formula
#                data=data[,-c(1,2,3,5,6,7,20,21)])

cor(weight_kg, THIGH) # 0.8619951
cor(weight_kg, NECK)  # 0.8247504
cor(weight_kg, HIP)   # 0.9375123



fit2 = lm(BODYFAT~AGE+NECK*HIP*THIGH*weight_kg+ABDOMEN+FOREARM+WRIST, 
          data=data[,-c(1,2,3,5,6,7,20,21)])
summary(fit2)
step_fit2 = step(fit2, direction = "both")
summary(step_fit2)
# step_fit2 = lm(BODYFAT ~ AGE+NECK+HIP+THIGH+weight_kg+ABDOMEN+FOREARM+WRIST+   ### formula
#                  NECK:THIGH + NECK:weight_kg + HIP:weight_kg,
#                data = data[, -c(1, 2, 3, 5, 6, 7, 20, 21)])



attach(data1)

fit3 = lm(BODYFAT ~ AGE+NECK+HIP+weight_kg+ABDOMEN+FOREARM+WRIST+                ### formula
            NECK:weight_kg + HIP:weight_kg,
          data = data1[, -c(1, 2, 3, 5, 6, 7, 20, 21)])
summary(fit3)
step_fit3 = step(fit3, direction = "both")
summary(step_fit3)
# step_fit3 = lm(BODYFAT ~ AGE+NECK+HIP+weight_kg+ABDOMEN+FOREARM+WRIST+HIP:weight_kg,    ### formula
#                data = data1[, -c(1, 2, 3, 5, 6, 7, 20, 21)])

cor(data1$weight_kg, data1$HIP)     #### 0.9249859  too high



fit4 = lm(BODYFAT ~ AGE+NECK+weight_kg+ABDOMEN+FOREARM+WRIST, data = data1[, -c(1, 2, 3, 5, 6, 7, 20, 21)])
summary(fit4)
step_fit4 = step(fit4, direction = "both")    # the same as the fit4

cor(data1$weight_kg, data1$ABDOMEN) #### 0.8710491  too high



fit5 = lm(BODYFAT ~ height_cm+AGE+NECK+weight_kg+HIP+ABDOMEN+FOREARM+WRIST, data = data1[, -c(1, 2, 3, 5, 6, 7, 20, 21)])
summary(fit5)
step_fit5 = step(fit5, direction = "both")
summary(step_fit5)
# step_fit5 = lm(BODYFAT ~ height_cm + AGE + NECK + ABDOMEN + FOREARM + WRIST, data = data1)  ### formula
plot(step_fit5)


### regression diagnostics
fit = step_fit1
fit = step_fit2
fit = step_fit3
fit = fit4
fit = step_fit5

# global test
gvmodel = gvlma(fit)
summary(gvmodel)  # all accepted

# check normality                   ### 207, 224 may have problems  (the same)
qqPlot(fit, id.method="identify", simulate=TRUE, main="QQPlot - check normality")

# check the independence of error   ### fine - step_fit2 is better
durbinWatsonTest(fit)   

# check the linearity               ### can consider other format of "Neck, Hip, Thigh"
crPlots(fit)

# check the homoscedasticity        ### good
ncvTest(fit)

# check the multicollinearity       ### many problems !!!!!
vif(fit)
sqrt(vif(fit))>2

# outlier in x                      ### 36 39 106 159 163 175 206 very dangerous
hat.plot = function(fit){           ### especially 39 and 175
  p = length(coefficients(fit))
  n = length(fitted(fit))
  plot(hatvalues(fit), main="index plot of hat values")
  abline(h = c(2,3)*p/n, col="red", lty = 2)
  identify(1:n, hatvalues(fit), names(hatvalues(fit)))
}
hat.plot(fit)

# Cook's Distance                        # 39, 175, 216 - step_fit1
                                         # 39, 108, 175 - step_fit2
cutoff = 4/(nrow(data)-length(fit$coefficients)-2)
cutoff = 4/(nrow(data1)-length(fit$coefficients)-2)
plot(fit, which = 4, cook.levels = cutoff)
abline(h = cutoff, lty = 2, col = "red")

# summarize the influential points
influencePlot(fit)                 # 39, 175, 207, 224 (almost the same)
                                   # step_fit2 adds 108

summary(influence.measures(fit))   # 39, 175 - step_fit1
                                   # 39      - step_fit2

# statistics
(r2     = summary(fit)$r.squared)       # 0.7475 - step_fit1; 0.7625595 - step_fit2
(r2_Adj = summary(fit)$adj.r.squared)   # 0.7392 - step_fit1; 0.7516768 - step_fit2
(aic    = AIC(fit))
(bic    = BIC(fit))
# press=PRESS(fit1)
# r2_pred=R2pred(fit1)
# rmse=rmsep(fit1)
# c(r2, r2_Adj, aic, bic)





#### later (optional)
# boxcox
b = boxcox(BODYFAT~AGE+weight_kg+height_cm, data = data1)
