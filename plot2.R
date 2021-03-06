#Reading data of Electric power consumption
data <- read.table("./household_power_consumption.txt", header = TRUE, 
                   sep = ";", na.strings = "?", stringsAsFactors = FALSE)

#Paste and converting Date and Time and subsetting the used dates
data$datetime <- paste(data$Date, data$Time)
data <- data[,!names(data) %in% c("Date", "Time")]
data$datetime <- strptime(data$datetime, "%d/%m/%Y %H:%M:%S")
data <- subset(data, year(data$datetime) == 2007 & month(data$datetime) == 02 & 
                   mday(data$datetime) %in% c(01, 02))

#Create a plot #2 and save it in file
png("plot2.png")
with(data, plot(datetime, Global_active_power, type = "l", xlab = "", 
                ylab = "Global Active Power (kilowatts)"))
dev.off()