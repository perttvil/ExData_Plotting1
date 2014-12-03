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
# plot to file
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()