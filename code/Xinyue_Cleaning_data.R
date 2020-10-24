rm(list = ls())

# setwd("W:/UW_Class_2020_2021/628/Module2/")

data = read.csv(file = "BodyFat.csv", header = T)
# attach(data)

    # modification - weight part
    data$WEIGHT[163] = data$WEIGHT[163] - 20
    data$WEIGHT[221] = data$WEIGHT[221] + 20


names(data)[3] = "DENSITY(under water)"
names(data)[5] = "WEIGHT(lbs)"
names(data)[6] = "HEIGHT(inches)"
# change the "unit"
data$weight_kg = 0.45359237 * data$`WEIGHT(lbs)`
data$height_cm = 2.54 * data$`HEIGHT(inches)`


    # modification - height part
    data$height_cm[42] = data$height_cm[42] + 100
    data$`HEIGHT(inches)`[42] = data$height_cm[42]/2.54

# all.equal(data$BODYFAT, round(495/data$DENSITY-450,1))
# all.equal(data$ADIPOSITY, data$weight_kg/(data$height_cm/100)^2)
# all.equal(data$ADIPOSITY, 703*data$`WEIGHT(lbs)`/(data$`HEIGHT(inches)`^2))


# calculate BMI from weight and height
data$calculated_BMI_kgcm = data$weight_kg/(data$height_cm/100)^2
data$calculated_BMI_lbin = 703*data$`WEIGHT(lbs)`/(data$`HEIGHT(inches)`^2)


# check the outliers
(w = which(abs(data$ADIPOSITY-data$calculated_BMI_kgcm)>0.5)) # 42, 163, 221 originally
which(abs(data$ADIPOSITY-data$calculated_BMI_lbin)>0.5)       # the same
data[w, c("WEIGHT(lbs)", "HEIGHT(inches)", "weight_kg", "height_cm", 
          "ADIPOSITY", "calculated_BMI_kgcm", "calculated_BMI_lbin")]


# height
sqrt(data$weight_kg/data$ADIPOSITY)[w]            # the 42th height should add 100
sqrt(data$`WEIGHT(lbs)`*703/data$ADIPOSITY)[w]
# weight
((data$height_cm/100)^2*data$ADIPOSITY)[w]
((data$`HEIGHT(inches)`^2)*data$ADIPOSITY/703)[w] # 163th weight should subtract 20(lbs)
                                                  # 221th weight should add 20(lbs)


summary(data)

# BMI max - 39th - not an outlier
data[which(data$`WEIGHT(lbs)`==max(data$`WEIGHT(lbs)`)),] # 183cm 165kg normal
which.max(data$ADIPOSITY)

# bodyfat_female = 1.2*data$ADIPOSITY+0.23*data$AGE-5.4
# bodyfat_male   = 1.2*data$ADIPOSITY+0.23*data$AGE-16.2

# abs(495/(100*data$BODYFAT+450)-data$`DENSITY(under water)`)

save(data, file = "cleaned_data.RData")
