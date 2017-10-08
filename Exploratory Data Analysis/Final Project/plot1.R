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

# We will be looking at the total pollution for each year; easily found by
# tapply.

annualpollution <- tapply(neidat$Emissions, neidat$year, sum, na.rm = TRUE)

# Now a quick plot to show the trend
png("plot1.png")
barplot(annualpollution, ylab = "Total Pollution (tons)")
dev.off()