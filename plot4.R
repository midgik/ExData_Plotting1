#Reading data of Electric power consumption
data <- read.table("./household_power_consumption.txt", header = TRUE, 
                   sep = ";", na.strings = "?", stringsAsFactors = FALSE)

#Paste and converting Date and Time and subsetting the used dates
data$datetime <- paste(data$Date, data$Time)
data <- data[,!names(data) %in% c("Date", "Time")]
data$datetime <- strptime(data$datetime, "%d/%m/%Y %H:%M:%S")
data <- subset(data, year(data$datetime) == 2007 & month(data$datetime) == 02 & 
                   mday(data$datetime) %in% c(01, 02))

#Create a plot #4 and save it in file
png("plot4.png")
par(mfrow = c(2, 2))
with(data, {
     plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
     plot(datetime, Voltage, type = "l")
     plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
     lines(datetime, Sub_metering_2, col = "red")
     lines(datetime, Sub_metering_3, col = "blue")
     legend("topright", legend = c(names(data)[5:7]), lty = 1, col = c("black", "red", "blue"), bty = "n")
     plot(datetime, Global_reactive_power, type = "l")
})
dev.off()