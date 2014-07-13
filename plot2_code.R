# Exploratory Data Analysis
# Assignment 1, part 2/4
# Code for creating plot #2
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

# #2007-02-01
day1data <- sqldf("select * from datafile where Date == '1/2/2007'", 
                  file.format = list(sep = ";",header=TRUE))
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

#### Handling missing values
## looks like there's no missing values in these two days!!

#### Extracting day of the week
weekday <- weekdays(as.Date(x=data$DateTime))
table(weekday)
levels(factor(weekday))
#put names in English
data$weekdayEng <- factor(weekday,levels=c("Thu","Fri"))
weekdayLabel <- c(rep("Thu",1439),rep("Fri",1440),"Sat")

#note. Finally we won't use this, we put tick labels manually.

#### Making plot #2

png(filename="plot2.png",width=480,height=480,bg="grey60")
plot(data$Global_active_power, type='l',ylab="Global Active Power (kilowatts)",xaxt="n" ,xlab="")
axis(1, at=c(1,1440,length(data$Global_active_power)), labels=c("Thu","Fri","Sat"))
dev.off()

