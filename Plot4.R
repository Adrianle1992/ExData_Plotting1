
library(data.table)

URL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <-"GetData.zip"
if (!file.exists(filename)) {
  download.file(URL,filename,method="curl")
}
if (!file.exists("household_power_consumption.txt")) {
  unzip(filename)
}

data_set<-read.table(file.path(getwd(),"household_power_consumption.txt"), header=TRUE, stringsAsFactors = FALSE, sep=";")
data_set<-subset(data_set,Date=="1/2/2007" | Date=="2/2/2007")

data_set$Time <- strptime(paste(data_set$Date,data_set$Time),format="%d/%m/%Y %H:%M:%S")
data_set$Global_active_power <- as.numeric(data_set$Global_active_power)
data_set$Global_reactive_power <- as.numeric(data_set$Global_reactive_power)
data_set$Sub_metering_1 <- as.numeric(data_set$Sub_metering_1)
data_set$Sub_metering_2 <- as.numeric(data_set$Sub_metering_2)
data_set$Sub_metering_3 <- as.numeric(data_set$Sub_metering_3)
data_set$Voltage <- as.numeric(data_set$Voltage)

png("plot4.png", width=504, height=504)
par(mfcol=c(2,2))

with(data_set,plot(Time, Global_active_power, type="l",ylab="Global Active Power (kilowatts)"))

with(data_set,plot(Time, Sub_metering_1, col="black",type="l",ylab="Energy Sub Metering"))
with(data_set,lines(Time, Sub_metering_2, col="red",type="l"))
with(data_set,lines(Time, Sub_metering_3, col="blue",type="l"))
legend("topright",lty=c(1,1,1), col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_2"))

with(data_set,plot(Time, Voltage, type="l",ylab="Voltage",xlab="datetime"))

with(data_set,plot(Time, Global_reactive_power, type="l",ylab="Global_reactive_power",xlab="datetime"))
dev.off()
