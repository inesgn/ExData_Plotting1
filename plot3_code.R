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

#### Handling missing values
nrow(data[which(data$Global_active_power=="?"),])
## looks like there's no missing values in these two days!!

#### Making plot #3
png(filename="plot3.png",width=480,height=480,bg="grey60")
plot(x=data$Sub_metering_1, type="l", ylab='Energy sub metering',xaxt="n" ,xlab="")
axis(1, at=c(1,1440,length(data$Global_active_power)), labels=c("Thu","Fri","Sat"))
lines(x=data$Sub_metering_2, type="l",col='red')
lines(x=data$Sub_metering_3, type="l",col='blue')
legend("topright", col = c("black","red", "blue"),lty='solid',pch=NULL,
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()


