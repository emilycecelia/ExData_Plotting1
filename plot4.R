data <- read.table("household_power_consumption_truncated.txt", sep=";", header=TRUE)

meter1 <- data$Sub_metering_1
meter2 <- data$Sub_metering_2
meter3 <- data$Sub_metering_3
voltage <- data$Voltage
reactive_power <- data$Global_reactive_power

data$DateTime <- paste(data$Date, data$Time)
d <- strptime("1/2/2003 4:23:23", format = "%d/%m/%Y %H:%M:%S")
data$DateTime1 <- as.numeric(as.POSIXct(strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")))

q_dt <- quantile(data$DateTime1, c(0,.50,.65,.75,1))
dtmin <- q_dt["0%"]
dtmed <- q_dt["50%"]
dtmax <- q_dt["100%"]

png("plot4.png",width = 480, height = 480)

par(mfrow=c(2,2))

#Plot 1: Datetime vs Global Active Power
plot(data$DateTime1,data$Global_active_power,type="n",
     xlab=NA,ylab="Global Active Power",xaxt="n")
lines(data$DateTime1,data$Global_active_power)
axis(1, at=c(min(data$DateTime1),median(data$DateTime1),max(data$DateTime1)),labels=c("Thu","Fri","Sat"), las=1)

#Plot 2: Datetime vs Voltage
plot(data$DateTime1,voltage,type="n",
     xlab="datetime",ylab="Voltage",xaxt="n")
lines(data$DateTime1,voltage)
axis(1, at=c(dtmin,dtmed,dtmax),labels=c("Thu","Fri","Sat"), las=1)

#Plot 3: Datetime vs Submeters
plot(data$DateTime1,meter1,type="n",
     xlab=NA,ylab="Energy sub metering",xaxt="n")
lines(data$DateTime1,meter1)
lines(data$DateTime1,meter2,col="red")
lines(data$DateTime1,meter3,col="blue")
axis(1, at=c(q_dt["0%"],q_dt["50%"],q_dt["100%"]),labels=c("Thu","Fri","Sat"), las=1)
legend("topright", 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),   
       lwd=c(2.5,2.5,2.5),col=c("black","red","blue"),
       bty="n") 

#Plot 4: Datetime vs Global Reactive Power
plot(data$DateTime1,reactive_power,type="n",
     xlab="datetime",ylab="Global_reactive_power",xaxt="n")
lines(data$DateTime1,reactive_power)
axis(1, at=c(dtmin,dtmed,dtmax),labels=c("Thu","Fri","Sat"), las=1)

dev.off()
