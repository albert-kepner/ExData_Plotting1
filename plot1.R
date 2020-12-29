## plot1.R
## Plot of Global Active Power

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

str(data2)
dim(data2)
## This confirms that we have now have 2880 observations of 9 variables.
