## Set Working Directory
setwd("D:/Coursera/201503 - Exploratory Data Analysis/Week1/")

## Download File
url   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file  <- "household_power_consumption.zip"

download.file(url, file, method = "curl")

unzip(file, exdir = "D:/Coursera/201503 - Exploratory Data Analysis/Week1")

## Getting full dataset
data_full <- read.csv(  "household_power_consumption.txt"
                        ,header=T
                        ,sep=';'
                        ,na.strings="?"
                        ,check.names=F
                        ,stringsAsFactors=F
                        ,comment.char=""
                        ,quote='\"')

data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subset the data
data <- subset(data_full, subset<-(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Create Date+Time
data$datetime <- paste(as.Date(data$Date), data$Time)
data$datetime <- strptime(data$datetime, format="%Y-%m-%d %H:%M:%S")

## Plot 4
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 0, 0))

## 1 of 4
plot(  x=data$datetime
       ,y=data$Global_active_power
       ,type="l"
       ,xlab=""
       ,ylab="Global Active Power")

## 2 of 4
plot(  x=data$datetime
       ,y=data$Voltage
       ,type="l"
       ,xlab="datetime"
       ,ylab="Voltage")

## 3 of 4
with(data,plot( datetime
                ,Sub_metering_1,
                ,type="l"
                ,xlab=""
                ,ylab="Energy sub metering" ))

with(data,points(datetime,Sub_metering_2,col="red",type="l"))
with(data,points(datetime,Sub_metering_3,col="blue",type="l"))
legend(  "topright"
         ,col = c("black","blue", "red")
         ,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
         ,bty = "n"
         ,lty=1
         ,cex=1
         )

## 4 of 4
plot(  x=data$datetime
       ,y=data$Global_reactive_power
       ,type="l"
       ,xlab="datetime"
       ,ylab="Global_reactive_power")

dev.off() 