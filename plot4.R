library(dplyr)

Data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
Data$Date <- strptime(Data$Date, format = "%d/%m/%Y", tz = "UTC")
Data$Date <- as.Date(Data$Date)

StartDate  <- as.Date(("2007-01-31"))
EndDate  <- as.Date(("2007-02-03"))

Data[Data$Date > StartDate & Data$Date < EndDate, ] -> Data

Fields <- names(Data)[-1:-2]

for(f in Fields){ Data[[f]] <- as.numeric(Data[[f]])}

dim <- 480 
## Use dplyr to mutate datetime and format so it can be read
mutate(Data, DateTime  = paste(Data$Date, Data$Time)) -> Data
Data$DateTime <-  strptime(Data$DateTime, format = "%Y-%m-%d %H:%M:%S")


## Fourth Plot
png(filename = "plot4.png")
par(mfrow = c(2,2))

plot(Data$DateTime, Data$Global_active_power, type = "l", ylab = "Global Active Power", xlab = NA) ##1
plot(Data$DateTime, Data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime") ##2

plot(Data$DateTime, Data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(Data$DateTime, Data$Sub_metering_2, col = "red")
lines(Data$DateTime, Data$Sub_metering_3, col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = c(1,1,1))

plot(Data$DateTime, Data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime") ##4 
dev.off()