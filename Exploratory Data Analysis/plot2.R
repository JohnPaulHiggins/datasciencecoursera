# When run from the same directory as the zipped data file, this will generate
# the prescribed second plot.

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
png(filename = "plot2.png", width = 480, height = 480, units = "px")

# Then we generate the lineplot.
x <- workdata$datetime
y <- workdata$Global_active_power
plot(x, y, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Finally, we close the device.
dev.off()