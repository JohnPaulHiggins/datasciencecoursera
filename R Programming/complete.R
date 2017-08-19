complete <- function(directory, id = 1:332) {
  
  # List file names
  files <- list.files(directory, full.names = TRUE)
  
  # Read in appropriate CSVs
  csvs <- lapply(files[id], read.csv)
  
  # Determine # complete cases for each CSV
  cases <- lapply(csvs, complete.cases)
  numcases <- lapply(cases, sum)
  
  # Build data frame; col 1 is id of station, col 2 is # complete cases
  dat <- data.frame(id = id, nobs = unlist(numcases))
  
  # Return data frame
  dat
}