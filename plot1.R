## plot1.R
##
## Adam Tannir
## Coursera Exploratory Data Analysis
## Assignment 1, part 1
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
##
##

xwidth <- 480
ywidth <- 480

##TODO
##convert Date and Time to unified value, and proper type, using strptime() and as.Date()


hpc_sample <- read.table("household_power_consumption.txt", sep=";",header = TRUE, na.strings="?", nrows = 10)
classes <- sapply(hpc_sample, class)
classes["Date"] <- "character"
classes["Time"] <- "character"
## tried to be fancy with dates ahead of time, didn't work.
## offsets found using grep -n on command line
hpc <- read.table("household_power_consumption.txt", colClasses = classes, sep = ";", header = TRUE, na.strings="?", skip = 66636, nrows = 2880)
colnames(hpc) <- colnames(hpc_sample)
## rm(hpc_sample)

## hpc$DateTime <- 

## Plot 1 is labeled Global Active Power
## Plot 1 X is Global Active Power (kilowatts)
## Plot 1 y is Frequency

## hist(hpc$Global_active_power) ## almost perfect

#png(filename = "plot1.png", ## useful link: http://www.ats.ucla.edu/stat/r/faq/saving.htm
#    width = xwidth,
#    height = ywidth) ## slightly unintuitive names, esp for y which is height.
hist(hpc$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "RED")
#dev.off()