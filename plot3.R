## plot2.R
##
## Adam Tannir
## Coursera Exploratory Data Analysis
## Assignment 1, part 2
##
##
## household power consumption for 2 days, 2007-02-01 and 2007-02-02.
##
## zip is 20 MB, full txt is 127 MB.
##
## Suggested to read only the data for those dates, but still researching how.
## 15 seconds to read whole dataset on my machine, 21 without column pre-specified
## using the offsets, load time is under 1 second
##
## hints for large files from http://www.biostat.jhsph.edu/~rpeng/docs/R-large-tables.html
##
## strptime(paste(hpc_sample[[1]][1],hpc_sample[[2]][1], sep=" " ), format = "%d/%m/%Y %H:%M:%S")
## strptime(paste(hpc_sample$Date,hpc_sample$Time, sep=" " ), format = "%d/%m/%Y %H:%M:%S")
##

xwidth <- 480
ywidth <- 480

hpc_sample <- read.table("household_power_consumption.txt", sep=";",header = TRUE, na.strings="?", nrows = 10)
classes <- sapply(hpc_sample, class)
classes["Date"] <- "character"
classes["Time"] <- "character"
## tried to be fancy with dates ahead of time, didn't work.
## offsets found using grep -n on command line
hpc <- read.table("household_power_consumption.txt", colClasses = classes, sep = ";", header = TRUE, na.strings="?", skip = 66636, nrows = 2880)
colnames(hpc) <- colnames(hpc_sample)
## rm(hpc_sample)

hpc$DateTime <- strptime(paste(hpc$Date,hpc$Time, sep=" " ), format = "%d/%m/%Y %H:%M:%S")
hpc$DoW <- weekdays(strptime(paste(hpc$Date,hpc$Time, sep=" " ), format = "%d/%m/%Y %H:%M:%S"))

## Plot 3 is not labeled
## Plot 3 X is days of week
## Plot 3 y is Global Active Power (kilowatts)
## plot is a line graph, with 3 entries

png("plot3.png", ## useful link: http://www.ats.ucla.edu/stat/r/faq/saving.htm
  width = xwidth,
  height = ywidth) ## slightly unintuitive names, esp for y which is height.

plot(y = hpc$Sub_metering_1,
     x = hpc$DateTime,
     type = "l",
     xlab = "", ## Thursday Friday Saturday, so need to manipulate the days of the week
     ylab = "Energy sub metering",
     col = "black"
)

lines(y = hpc$Sub_metering_2,
     x = hpc$DateTime,
     type = "l",
     col = "red")

lines(y = hpc$Sub_metering_3,
      x = hpc$DateTime,
      type = "l",
      col = "blue")

legend(x = "topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = 1,
       col = c("black", "red", "blue")
       )

dev.off()