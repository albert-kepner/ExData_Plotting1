## plot4.R
## Grid of 4 Plots versus time:
## 1) Global Active Power
## 2) Voltage
## 3) sub metering
## 4) Global Reactive Power

## Data to be read from input file at ./data/household_power_consumption.txt
##
## We are interested in data from 2 specific dates: 2007-02-01 and 2007-02-02
## Examining the input file with a text editor,
## data for 2/1/2007 starts on line 66639 and 
## data for 2/2/2007 ends on line    69518
## So we expect to have 2880 rows of data after filtering for these dates.
## This makes sense because we expect to have observations every minute for 
## (2) 24 hour days = 2 x 60 * 24 = 2880 observations.

## Read the input file. Read the first part of the file stopping a few
## rows after the location of the
## desired data. Reading 70000 rows covers this date range.
data <- read.table(
  file="./data/household_power_consumption.txt",
  header=TRUE,
  na.strings="?",
  skip=0,
  nrows=70000,
  sep=";"
  )

## Filter the data keeping only the two desired dates:
data2 <- data[ data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

## str(data2)
dim(data2)
## This confirms that we have now have 2880 observations of 9 variables.

## The next steps will be to convert the separate Date and Time columns into
## a new new DateTime column containing an R Date data type.

dateString <- paste(data2$Date, data2$Time, sep=" ");
dateTime <- strptime(dateString, format="%d/%m/%Y %H:%M:%S")

data3 <- data2
data3$DateTime <- dateTime
## data3 now contains the original data set with an added column DateTime 
## (actual Date/Time "POSIXlt" representation)


par(mfrow=c(2,2))

plot(data3$DateTime, data3$Global_active_power, 
     type="l",
     ylab="Global Active Power",
     xlab="datetime")

plot(data3$DateTime, data3$Voltage, 
     type="l",
     ylab="Voltage",
     xlab="datetime")

plot(data3$DateTime, data3$Sub_metering_1, col="black", type="l",
     ylab="Energy sub metering", xlab="datetime")
lines(data3$DateTime, data3$Sub_metering_2, col="red", type="l")
lines(data3$DateTime, data3$Sub_metering_3, col="blue", type="l")

legend( x="topright", 
        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
        col=c("black","red","blue"), lwd=2, lty=1, 
        merge=FALSE, cex=0.5 )

plot(data3$DateTime, data3$Global_reactive_power, 
     type="l",
     ylab="Global Reactive Power",
     xlab="datetime")

dev.copy(png, file = "plot4.png")
dev.off()
