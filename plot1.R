## Getting and setting the data
df <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)
library(dplyr)
elecDate <- mutate(df, date2 = as.Date(Date, format="%d/%m/%Y"))  ##converting date format

## only taking data from 2/1/07 and 2/2/07 or February 1st and 2nd 2007
power_data <- filter(elecDate, date2 == "2007-02-01" | date2 == "2007-02-02") 

## Converting global_active_power from factor to number
power_data$Global_active_power <- as.numeric(as.character(power_data$Global_active_power))

hist(power_data$Global_active_power, col = "red", main = "Global Active Power", 
xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
