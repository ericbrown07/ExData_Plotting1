## Plot 4 - Four charts (GAP, Voltage, ESM, GRP) (by time, labeled by day)

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


png(filename = "plot4.png", width = 480, height = 480)
      # create png file to be plotted onto

par(mfrow = c(2, 2))

with(powerdatafeb, {
      plot(Date.Time, Global_active_power, type = "l", 
            ylab = "Global Active Power", xlab = "")
      plot(Date.Time, Voltage, type = "l", 
            ylab = "Voltage", xlab = "datetime")
      plot(Date.Time, Sub_metering_1, type = "l", 
            ylab = "Energy sub metering", xlab = "")
      lines(Date.Time, Sub_metering_2, col = "red")
      lines(Date.Time, Sub_metering_3, col = "blue")
      legend("topright", lty = 1, col = c("black", "red", "blue"), 
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      plot(Date.Time, Global_reactive_power, type = "l", 
            ylab = "Global_reactive_power", xlab = "datetime")
})
      # create 4 plots in a 2 x 2 arrangement

dev.off()
      # png graphic device now off
      # plotting process finished
