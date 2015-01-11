data <- read.table("household_power_consumption_truncated.txt", sep=";", header=TRUE)

png("plot1.png",width = 480, height = 480)

hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)",  
        ylab="Frequency", ylim=c(0,1200), col="red")

dev.off()