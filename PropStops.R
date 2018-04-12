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
