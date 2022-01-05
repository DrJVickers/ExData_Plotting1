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

#
par(mfrow = c(1,1))

## First Plot 
png(filename = "plot1.png")
hist(Data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()