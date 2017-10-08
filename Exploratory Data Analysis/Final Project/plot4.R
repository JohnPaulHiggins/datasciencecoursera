# The code for plot 4 starts with reading in data as in prior plots.

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

# Find any SCC corresponding to coal -- search for "coal" in every column of
# scc, and take union of all returned indices. This gives all rows in scc that
# correspond to coal-related pollution sources. Remove charcoal.

coalindices <- Reduce(union,
                      apply(scc,
                            2,
                            function(x)
                              {grep(".coal.*", x, ignore.case = TRUE)}))

charcoalindices <- Reduce(union,
                          apply(scc,
                                2,
                                function(x)
                                  {grep(".*charcoal.*", x,
                                        ignore.case = TRUE)}))

coalindices <- setdiff(coalindices, charcoalindices)

# Determine which indices have to do with combustion -- "comb."

combindices <- Reduce(union,
                      apply(scc,
                            2,
                            function(x)
                              {grep(".comb.*", x, ignore.case = TRUE)}))

# Intersect the two to determine coal-combustion pollution.

coalcombindices <- intersect(coalindices, combindices)

# Figure which SCC correspond to those indices.

coalcombcodes <- as.character(scc$SCC[coalcombindices])

# Subset neidat based on the SCC that correspond to coal combustion

coalcombinfo <- neidat[which(neidat$SCC %in% coalcombcodes), ]

# Now, sum Emissions divided by year.

annualcoalcomb <- tapply(coalcombinfo$Emissions, coalcombinfo$year,
                     sum, na.rm = TRUE)

# A quick plot shows the national trend.

png("plot4.png")
barplot(annualcoalcomb, ylab = "Total Pollution (tons)",
        main = "Coal Combustion Pollution")
dev.off()