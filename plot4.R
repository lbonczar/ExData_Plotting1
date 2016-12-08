#Download and unzip file into R table

temp <- tempfile()


download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
unzip(temp,"household_power_consumption.txt")

## read.table paramter 'colClasses' pre-loads multiple columns as correct classes. Date and Time columns are as character though, will be changed as needed later

dat <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

unlink(temp)

#spare copy of dat to play with

dat_extra <- dat

#change Date column to class 'Date'

dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")

dat <- subset(dat, Date > "2007-01-31" & Date < "2007-02-03")

#change Time column to class 'POSIXlt'and merge Date and Time

dat$merged_d_and_t <- paste(dat$Date,dat$Time, sep = " ")

dat$merged_d_and_t <- strptime(dat$merged_d_and_t, "%Y-%m-%d %H:%M:%S")


par(mfrow = c(2,2))

# create plot of clock time vs. Global Active Power

plot(dat$merged_d_and_t, dat$Global_active_power, xlab = " ", ylab = "Global Active Power", type = "l")

# create plot of clock time vs. Volatage

plot(dat$merged_d_and_t, dat$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")


# create plot of clock time vs. Sub Metering 1,2,3

#windows(width=3, height=3)

plot(dat$merged_d_and_t, dat$Sub_metering_1, ylim=c(1,40), xlab = " ", ylab = "Energy sub metering", type = "l")
par(new = TRUE)

#lines(dat$merged_d_and_t, dat$Sub_metering_2, ylim=c(1,40), xlab = " ", ylab = " ", type = "l", col = "red")

plot(dat$merged_d_and_t, dat$Sub_metering_2, ylim=c(1,40), xlab = " ", ylab = " ", type = "l", col = "red")
par(new = TRUE)
plot(dat$merged_d_and_t, dat$Sub_metering_3, ylim=c(1,40), xlab = " ", ylab = " ", type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"), cex = .5, xjust = 0, bty = "n", x.intersp = 0)

#dev.off()
#par(mfg = c(2,2), new = TRUE)

# create plot of clock time vs. Volatage

plot(dat$merged_d_and_t, dat$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
par(new = FALSE)

