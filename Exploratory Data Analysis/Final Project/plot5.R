# The code for plot 5 starts with reading in data as in prior plots.

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

annualbaltmv <- tapply(baltmv$Emissions, baltmv$year, sum, na.rm = TRUE)

# Plot total pollution due to motor vehicles. Color is for fun.

png("plot5.png")
barplot(annualbaltmv, col = 3:6, ylab = "Total Pollution (tons)",
        main = "Motor Vehicle Pollution in Baltimore City")
dev.off()