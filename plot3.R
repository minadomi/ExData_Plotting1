## First I need to read my data from the file. I read out only the first 500,000
## lines because I know the data I want is fairly early on within the file.
require("dplyr")
household_power_consumption <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE,na.strings="?", nrows=500000)

## Next I select only the rows corresponding to February 1st and 2nd, 2007.
selectedrows <- filter(household_power_consumption, Date == "1/2/2007" | Date == "2/2/2007")

## I now convert the Date and Time columns into a single column representing date 
## and time in the POSIXlt format.
datelist <- strptime(paste(selectedrows$Date, selectedrows$Time), format = "%d/%m/%Y %H:%M:%S")
selectedrows$DateTime <- datelist
selectedrows$Date <- NULL
selectedrows$Time <- NULL
selectedrows <- selectedrows[c(8,1,2,3,4,5,6,7)]

## I open my graphics file device and plot my graph. 
png(filename = "plot3.png")
plot(selectedrows$DateTime, selectedrows$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(selectedrows$DateTime, selectedrows$Sub_metering_2, col = 2, type = "l")
lines(selectedrows$DateTime, selectedrows$Sub_metering_3, col = "blue", type = "l")

## Finally, I add the legend and close the file device.
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()