library(rvest)
library(tidyverse)

url <- "https://en.wikipedia.org/wiki/List_of_counties_in_Wisconsin"
counties <- url %>%
  read_html() %>%
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[1]') %>% 
  html_table()

countyData <- cbind.data.frame(counties[[1]]$`FIPS code[6]`, counties[[1]]$`Population[4][7]`, counties[[1]]$`Area[4]`)
colnames(countyData) <- c("county_fips", "population", "area")
countyData$population <- gsub("^[^\u2660]*","",countyData$population)
countyData$population <- gsub("[\u2660]","",countyData$population)

countyData$area <- gsub("^[^\u2660]*","",countyData$area)
countyData$area <- gsub("[\u2660]","",countyData$area)
countyData$area <- gsub("[sq].*","",countyData$area)
countyData$area <- gsub("^\\s+|\\s+$", "", countyData$area)

countyData$population <- as.numeric(gsub(",", "", countyData$population))
countyData$area <- as.numeric(trimws(gsub(",", "", countyData$area), which = "both"))
countyData$county_fips <- countyData$county_fips + 55000

str(countyData)
