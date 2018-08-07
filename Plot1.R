
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
data_set$Global_active_power <- as.numeric(data_set$Global_active_power)
png("Plot1.png", width=504, height=504)
with(data_set,hist(Global_active_power, col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)",ylab="Frequency"))
dev.off()