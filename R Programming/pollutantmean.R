pollutantmean <- function(directory, pollutant, id = 1:332) {
  # Get a list of filenames in the directory
  files <- list.files(directory, full.names = TRUE)
  
  # Read in specified CSVs
  tmp <- lapply(files[id], read.csv)
  
  # Merge CSVs
  dat <- do.call(rbind, tmp)
  
  # Return mean of chosen pollutant
  mean(dat[, pollutant], na.rm = TRUE)
  
}