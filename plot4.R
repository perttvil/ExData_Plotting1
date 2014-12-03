library(grDevices)
Sys.setlocale("LC_TIME", "English")

# download zip
datafile <- "household_power_consumption.txt"
if(!file.exists(datafile)) {
  zipfile <- "data.zip"
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", zipfile, mode = "wb")
  unzip(zipfile)
  file.remove(zipfile)
}

data <- read.table(datafile, header=TRUE, sep = ";", na.strings = "?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

#add timestamp with full datetime
data$Timestamp <- paste(data$Date, data$Time)
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Timestamp <- strptime(data$Timestamp, "%d/%m/%Y %H:%M:%S")
# filter data
data <- subset(data, data$Date >= as.Date("01/02/2007", "%d/%m/%Y") & data$Date <= as.Date("02/02/2007", "%d/%m/%Y"))

# plot 4 images to 1 file
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
# set 2 rows, 2 columns
par(mfrow=c(2,2))

# plot 1
plot(data$Timestamp, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# plot 2
plot(data$Timestamp, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# plot 3
plot(data$Timestamp, data$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
points(data$Timestamp, data$Sub_metering_1, type="l", col="black")
points(data$Timestamp, data$Sub_metering_2, type="l", col="red")
points(data$Timestamp, data$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty="solid", bty = "n")

# plot 4
plot(data$Timestamp, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()