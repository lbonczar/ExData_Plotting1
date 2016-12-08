#Download and unzip file into R table

temp <- tempfile()


download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
unzip(temp,"household_power_consumption.txt")

## read.table paramter 'colClasses' pre-loads multiple columns as correct classes. Date and Time columns are as character though, will be changed as needed later

dat <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

unlink(temp)

#change Date column to class 'Date'

dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")

dat <- subset(dat, Date > "2007-01-31" & Date < "2007-02-03")

# merge Date and Time and change Time column to class 'POSIXlt'

dat$merged_d_and_t <- paste(dat$Date,dat$Time, sep = " ")

dat$merged_d_and_t <- strptime(dat$merged_d_and_t, "%Y-%m-%d %H:%M:%S")

# create plot of clock time vs. Global Active Power

windows(xpinch=480, ypinch = 480)

plot(dat$merged_d_and_t, dat$Sub_metering_1, ylim=c(1,40), xlab = " ", ylab = "Energy sub metering", type = "l")
par(new = TRUE)
plot(dat$merged_d_and_t, dat$Sub_metering_2, ylim=c(1,40), xlab = " ", ylab = " ", type = "l", col = "red")
par(new = TRUE)
plot(dat$merged_d_and_t, dat$Sub_metering_3, ylim=c(1,40), xlab = " ", ylab = " ", type = "l", col = "blue")
par(new = FALSE)
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"))