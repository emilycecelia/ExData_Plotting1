data <- read.table("household_power_consumption_truncated.txt", sep=";", header=TRUE)

png("plot2.png",width = 480, height = 480)

data$DateTime <- paste(data$Date, data$Time)

d <- strptime("1/2/2003 4:23:23", format = "%d/%m/%Y %H:%M:%S")
data$DateTime1 <- as.numeric(as.POSIXct(strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")))

plot(data$DateTime1,data$Global_active_power,type="n",
     xlab=NA,ylab="Global Active Power (kilowatts)",xaxt="n")
lines(data$DateTime1,data$Global_active_power)
axis(1, at=c(min(data$DateTime1),median(data$DateTime1),max(data$DateTime1)),labels=c("Thu","Fri","Sat"), las=1)

dev.off()
