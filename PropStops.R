# percent of stops with no race recorded - nearly 15%!
sum(is.na(d$driver_race))/length(d$driver_race) 

# filter - stops with no race recorded
tmp = d %>% filter(is.na(driver_race))

# how often is gender missing? Slightly less often than race
sum(is.na(d$driver_gender))/length(d$driver_gender)

# what are the proportion of stops shared by each cop per county?
bycounty = d[order(as.numeric(d$county_fips)),] # get sorted by county
# get count of total stops by county
stopbycounty = d %>%  group_by(county_fips) %>% count() %>% arrange(desc(n)) 
# count of stops per officer: 
stopbyofficer = d %>% group_by(officer_id) %>% count() %>% arrange(desc(n))
# what officer belongs to what county?
# try Adams first
adoff = unique(d[d$county_fips == 55001, ]$officer_id) 
# get proportion for first officer in Adams... messy code.
stopbyofficer[stopbyofficer$officer_id == "2375",]$n[1]/stopbycounty[stopbycounty$county_fips == 55001,]$n
# This first cop does over 50% of all stops in the county?

# second cop... see if this adds up
stopbyofficer[stopbyofficer$officer_id == "2398",]$n[1]/stopbycounty[stopbycounty$county_fips == 55001,]$n
# This cop does 242% of the stops in the county. It appears cops go outisde of their counties frequently.

# just overall proportion of stops by officer, then:
stopbyofficer = stopbyofficer %>% mutate(percent = n/length(d$id)*100)
head(stopbyofficer)

# what counties are top stoppers in?
# start with top cop, id 2286.
unique(d[d$officer_id == "2286",]$county_name) # 18 counties!

# is it possible to make a map of which officers have stopped in what counties?
# try the top cop first
library(choroplethr)
library(choroplethrMaps) 
# first, need to make a county, # stops df for officer 2286.
officertop = d[d$officer_id == "2286",] %>% group_by(county_fips) %>% count() 
colnames(officertop) = c("region", "value")
officertop$region = as.numeric(officertop$region)
# map of first officer - all blacked out counties have no stops
county_choropleth(df = officertop, state_zoom = "wisconsin", title = "Stops by Officer 2286") 

# second officer, just because
officer2072 = d[d$officer_id == "2072",] %>% group_by(county_fips) %>% count() 
colnames(officer2072) = c("region", "value")
officer2072$region = as.numeric(officer2072$region)
county_choropleth(df = officer2072, state_zoom = "wisconsin", title = "Stops by Officer 2072")
# this officer did 33% of the stops in county 55139.

# function to plot any officer - make sure to put ID in quotes to run
mapstops = function(officerid) {
  officer = d[d$officer_id == officerid,] %>% group_by(county_fips) %>% count() 
  colnames(officer) = c("region", "value")
  officer$region = as.numeric(officer$region)
  county_choropleth(df = officer, state_zoom = "wisconsin", 
                    title = paste("Stops by Officer", officerid))
}

# example - this one has a crazy map
mapstops("2176")
