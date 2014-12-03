## Plot 1 - Global Active Power Histogram

## Use these functions to read data into R and set up data frame for plots

library(data.table)  ## load data.table package to use fread function
powerdata <- fread("household_power_consumption.txt")  ## use fread to read in file
      # fread will read table into R in same way as read.csv or read.table

powerdatafebpull <- powerdata[which(powerdata$Date == "1/2/2007" | powerdata$Date == "2/2/2007"),]
      # create data frame with data from desired dates

class(powerdatafebpull) <- "data.frame"
      # coerce data into data frame

powerdatafebpull$Date <- as.Date(powerdatafebpull$Date, format = "%d/%m/%Y")
      # coerce date column to date format

Date.Time <- paste(powerdatafebpull$Date, powerdatafebpull$Time)
Date.Time <- strptime(Date.Time, format = "%Y-%m-%d %H:%M:%S")
powerdatafeb <- cbind(Date.Time, powerdatafebpull)[,c(1,4:10)]
      # create vector combining Date and Time columns, coerce to time format
      # use cbind to replace Date and Time columns with new combined vector

for (i in 2:8) {
      class(powerdatafeb[,i]) <- "numeric"
}
      # coerce data columns into numeric class

str(powerdatafeb) # check classes - should be POSIXct first and the rest num

## Data now ready for plotting - 


png(filename = "plot1.png", width = 480, height = 480)
      # create png file to be plotted onto

hist(powerdatafeb$Global_active_power, col = "red", main = "Global Active Power", 
      xlab = "Global Active Power (kilowatts)")

dev.off()
      # png graphic device now off
      # plotting process finished
