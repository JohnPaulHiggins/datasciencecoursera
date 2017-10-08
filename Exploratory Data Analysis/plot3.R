# When run from the same directory as the zipped data file, this will generate
# the prescribed third plot.

# First, the data is read.
df <- read.table(unz("exdata%2Fdata%2Fhousehold_power_consumption.zip",
                     "household_power_consumption.txt"),
                 header = TRUE, sep=";",
                 stringsAsFactors = FALSE,
                 na.strings = "?")

# Next, the data from the appropriate dates is selected.
workdata <- df[which(df$Date == "1/2/2007" | df$Date == "2/2/2007"),]

# For convenience, we build a new column, datetime, which holds a POSIXlt
# date-time.
workdata$datetime <- strptime(paste(workdata$Date, workdata$Time),
                              "%d/%m/%Y %H:%M:%S")

# Next, we prepare the graphics device.
png(filename = "plot3.png", width = 480, height = 480, units = "px")

# Then we generate the lineplot. First a blank plot is prepared.
x <- workdata$datetime
y1 <- workdata$Sub_metering_1
y2 <- workdata$Sub_metering_2
y3 <- workdata$Sub_metering_3
plot(x, y1, type = "n", xlab = "", ylab = "Energy sub metering")

# Each line is filled in.
lines(x, y1, col = "black")
lines(x, y2, col = "red")
lines(x, y3, col = "blue")

# The legend is added.
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1), col = c("black", "red", "blue"))

# Finally, we close the device.
dev.off()