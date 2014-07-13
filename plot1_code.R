# Exploratory Data Analysis
# Assignment 1, part 1/4
# Code for creating plot #1
#
#### Reading data
# set working directory
setwd("~/Documents/coursera/DataAnalysis/4EDA/week1")
#
# Read only 2-day data: 2007-02-01 and 2007-02-02
#
library(sqldf) 
#
datafile <- file("household_power_consumption.txt")
#
# #2007-02-01
day1data <- sqldf("select * from datafile where Date == '1/2/2007'", 
                  file.format = list(sep = ";",header=TRUE))
#2007-02-02
day2data <- sqldf("select * from datafile where Date == '2/2/2007'", 
                  file.format = list(sep = ";",header=TRUE))

head(day1data)
head(day2data)

# stack data for both days
data <- rbind(day1data,day2data)

#### Formating dates and times
x <- paste(data$Date, data$Time)
data$DateTime <- strptime(x,format="%d/%m/%Y %H:%M:%S")
#
summary(data)

#### Handling missing values
nrow(data[which(data$Global_active_power=="?"),])
## looks like there's no missing values in these two days!!

#### Making plot #1
png(filename="plot1.png",width=480,height=480,bg="grey60")
with(data, hist(x=Global_active_power, 
                main="Global Active Power", 
                xlab="Global Active Power (kilowatts)",
                col="red"))
dev.off()


