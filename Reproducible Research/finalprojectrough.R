if (!file.exists("repdata%2Fdata%2FStormData.csv.bz2")) {
  download.file(
    "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2",
    destfile = "repdata%2Fdata%2FStormData.csv.bz2")
}
storm.data <- read.csv("repdata%2Fdata%2FStormData.csv.bz2", stringsAsFactors = FALSE)
library(dplyr)
cost.multiplier <- function(x) {
  if (x == "") {
    0
  }
  else{
    switch(x,
           "b" =,
           "B" = 1000000000,
           "h" =,
           "H" = 100,
           "K" =,
           "k" = 1000,
           "m" =,
           "M" = 1000000,
           "?" =,
           "-" = 0,
           "+" = 1,
           10) 
  }
}
storm.data$PROPDMGMULT <- sapply(storm.data$PROPDMGEXP, cost.multiplier)
storm.data$CROPDMGMULT <- sapply(storm.data$CROPDMGEXP, cost.multiplier)
storm.data <- tbl_df(storm.data)
storm.data <- storm.data %>% 
  select(EVTYPE, FATALITIES, INJURIES, PROPDMG, PROPDMGMULT,
         CROPDMG, CROPDMGMULT) %>%
  mutate(PROPCOST = PROPDMG * PROPDMGMULT,
         CROPCOST = CROPDMG * CROPDMGMULT)
grouped.data <- group_by(storm.data, EVTYPE)
property.damage <- grouped.data %>%
  summarize(EXPENSE = sum(PROPCOST)) %>%
  arrange(desc(EXPENSE))
crop.damage <- grouped.data %>%
  summarize(EXPENSE = sum(CROPCOST)) %>%
  arrange(desc(EXPENSE))
fatalities <- grouped.data %>%
  summarize(DEATHS = sum(FATALITIES)) %>%
  arrange(desc(DEATHS))
injuries <- grouped.data %>%
  summarize(INJURED = sum(INJURIES)) %>%
  arrange(desc(INJURED))
library(ggplot2)
econ.panel <- ggplot(data = head(property.damage, 10),
                  aes(x = reorder(EVTYPE, EXPENSE), y = EXPENSE)) + 
  geom_col() +
  coord_flip()
death.panel <- ggplot(data = head(fatalities, 10),
                      aes(x = reorder(EVTYPE, DEATHS), y = DEATHS)) +
  geom_col() +
  coord_flip()