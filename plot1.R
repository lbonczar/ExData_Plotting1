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

#create histogram of Global Active Power in kw's

hist(dat$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")




