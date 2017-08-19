corr <- function(directory, threshold = 0) {
  # List files in directory
  files <- list.files(directory, full.names = TRUE)
  
  # Obtain table of completed cases for each station
  tbl <- complete(directory)
  
  # Subset based on threshold
  subtbl <- tbl[which(tbl[, "nobs"] > threshold), ]
  d
  if (nrow(subtbl) == 0) {
    output <- 0
  } else {
    # Read in corresponding files
    csvs <- lapply(files[subtbl[, "id"]], read.csv)
    
    # Run across list of data frames, calculating correlation and appending
    # to vector
    output <- c()
    for (i in seq_along(csvs)) {
      frm <- csvs[[i]]
      output[i] <- cor(frm$sulfate, frm$nitrate, use = "complete.obs")
    }
  }
  output
}