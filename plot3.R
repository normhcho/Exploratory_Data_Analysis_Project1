## Getting and setting the data
df <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)
library(dplyr)
elecDate <- mutate(df, date2 = as.Date(Date, format="%d/%m/%Y"))  ##converting date format

## only taking data from 2/1/07 and 2/2/07 or February 1st and 2nd 2007
power_data <- filter(elecDate, date2 == "2007-02-01" | date2 == "2007-02-02") 

## Converting global_active_power from factor to number
power_data$Global_active_power <- as.numeric(as.character(power_data$Global_active_power))


library(lubridate)

## adding column for combining date and time and thus creating a new dataset, "datetime."
datetime <- mutate(power_data, as.POSIXct(paste(power_data$date2, power_data$Time)))

## changing the name of the last or 11th column
colnames(datetime)[11] <- "date_and_time"

## Graph 3
plot(datetime$date_and_time, datetime$Sub_metering_1,xlab="",
     ylab = "Energy sub metering",type = "line")
lines(datetime$date_and_time, datetime$Sub_metering_2, col = "red")
lines(datetime$date_and_time, datetime$Sub_metering_3, col = "blue")
legend("topright", col = c("black","red","blue"), lty = 1,
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=1.2)

## The legend would not initially fix to the default scaling so set to 480x480
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
