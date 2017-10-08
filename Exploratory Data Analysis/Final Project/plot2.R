# The code for plot 2 is almost identical to plot 1, with the caveat that
# we are subsetting based on fips code to isolate Baltimore City.

# Check if directory has already been downloaded to working directory.
# If not, download.

if (!file.exists("NEIdata")) {
  # Check if it's still zipped
  if (file.exists("exdata%2Fdata%2FNEI_data.zip")) {
    unzip("exdata%2Fdata%2FNEI_data.zip", exdir = "NEIdata")
  }
  else {
    tmp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                  tmp)
    unzip(tmp, exdir = "NEIdata")
    unlink(tmp)
  }
}

# Read data in from directory

scc <- readRDS("./NEIdata/Source_Classification_Code.rds")
neidat <- readRDS("./NEIdata/summarySCC_PM25.rds")

# Subset neidat by fips == "24510" to isolate Baltimore City.
baltdat <- subset(neidat, fips == "24510")

# We will be looking at the total pollution for each year; easily found by
# tapply.

annualpollution <- tapply(baltdat$Emissions, baltdat$year, sum, na.rm = TRUE)

# Now a quick plot to show the trend
png("plot2.png")
barplot(annualpollution,
     ylab = "Total Pollution (tons)", main = "Baltimore City Pollution Levels")
dev.off()