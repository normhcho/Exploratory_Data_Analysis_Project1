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


## Graph 4

par(mfrow = c(2,2))

## 1st graph in matrix
plot(datetime$date_and_time, datetime$Global_active_power, xlab = "",
     ylab= "Global Active Power", type ="line")

## 2nd graph in matrix
## Converting voltage from factor to number
datetime$Voltage <- as.numeric(as.character(power_data$Voltage))

plot(datetime$date_and_time, datetime$Voltage, xlab = "datetime",
     ylab= "Voltage", type ="line")

## 3rd graph in matrix
plot(datetime$date_and_time, datetime$Sub_metering_1,xlab="",
     ylab = "Energy sub metering",type = "line")
lines(datetime$date_and_time, datetime$Sub_metering_2, col = "red")
lines(datetime$date_and_time, datetime$Sub_metering_3, col = "blue")

## cex used in order to fit the legend 
legend("topright", col = c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty = 1, bty="n", cex = 0.5)
      
       
## 4th graph in graph

## Converting global_reactive_power from factor to number
datetime$global_reactive_power <- as.numeric(as.character(datetime$global_reactive_power))

plot(datetime$date_and_time, datetime$Global_reactive_power, xlab = "datetime", ylab = 
       "Global_reactive_power", type ="line")

## Fitting the graphs as a png sized 480x480
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
