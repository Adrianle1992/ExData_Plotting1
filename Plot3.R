
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
data_set$Sub_metering_1 <- as.numeric(data_set$Sub_metering_1)
data_set$Sub_metering_2 <- as.numeric(data_set$Sub_metering_2)
data_set$Sub_metering_3 <- as.numeric(data_set$Sub_metering_3)

png("plot3.png", width=504, height=504)
with(data_set,plot(Time, Sub_metering_1, col="black",type="l",ylab="Energy Sub Metering"))
with(data_set,lines(Time, Sub_metering_2, col="red",type="l"))
with(data_set,lines(Time, Sub_metering_3, col="blue",type="l"))
legend("topright",lty=c(1,1,1), col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_2"))
dev.off()
