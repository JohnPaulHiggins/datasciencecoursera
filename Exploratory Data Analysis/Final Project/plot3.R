# The code for plot 3 is again based on that for plot 2; we read in the data
# and then subset to isolate Baltimore City.

# Load in ggplot2
library(ggplot2)

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

# Using tapply, we can find the total pollution by year and type.

datmat <- with(baltdat, tapply(Emissions, list(year, type), sum, na.rm = TRUE))

# Now we can build a data frame with this information
finalframe <- data.frame(year = rep(rownames(datmat, 4)),
                         emissions = c(datmat[1:4,]),
                         type = rep(colnames(datmat), each = 4))

# Use ggplot to make a line plot; total pollution (y) against year (x)
# grouped by type.
gp <- ggplot(data = finalframe, aes(x = year, y = emissions, group = type)) +
      geom_point(aes(color = type)) +
      geom_line(aes(color = type)) +
      labs(title = "Pollution in Baltimore City by Year and Type")
ggsave("plot3.png", plot = gp, device = "png")