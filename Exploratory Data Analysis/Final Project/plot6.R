# The code for plot 6 is leveraged on the code from plot 5.

# Load ggplot2
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

# Subset for Baltimore City.

baltdat <- subset(neidat, fips == "24510")

# We will limit ourselves to onroad vehicles; this is to isolate and
# eliminates sources like leafblowers, lawn mowers, etc.

mvindices <- Reduce(union,
                    apply(scc,
                          2,
                          function(x)
                          {grep(".*vehicle.*", x, ignore.case = TRUE)}))

mv <- scc[mvindices, ]

mv <- mv[which(mv$Data.Category == "Onroad"), ]

mvcodes <- as.character(mv$SCC)

baltmv <- baltdat[which(baltdat$SCC %in% mvcodes), ]

# Label each observation with the appropriate city, to distinguish
# from LA data.
baltmv$city <- "Baltimore City"

# Extract data for Los Angeles County.

lacdat <- subset(neidat, fips == "06037")

lacmv <- lacdat[which(lacdat$SCC %in% mvcodes), ]

# Label each observation with the appropriate city, to distinguish
# from Baltimore data.

lacmv$city <- "LA County"

# Combine data from both cities.

citydat <- rbind(baltmv, lacmv)

# Summarize the total emissions by city and year.

finaldat <- aggregate(Emissions ~ year + city, citydat, sum)

# Plot the data.

gp <- ggplot(finaldat, aes(year, Emissions, color = city)) +
  geom_point() + geom_line() + labs(x = "", 
                                    y = "Total Pollution (tons)",
                                    title = "Motor Vehicle Pollution")
ggsave("plot6.png", plot = gp, device = "png")