library(leaflet)
library(maptools)
library(RColorBrewer)

#geojson data downloaded from here: 
#https://seancase.carto.com/tables/wi_counties_geojson/public
wi <- geojsonio::geojson_read("wi_counties_geojson.geojson", what = "sp")

##fixing the fips codes
county_fips <- as.numeric(as.character(wi$county_fip)) + 55000
wi <- spCbind(wi, county_fips)

##Getting the proportions and merging with the spatial data
prop <- trafficStops %>% group_by(county_fips, raceMissing) %>% summarise (n = n()) %>%
  mutate(ProportionMissing = n / sum(n)) %>% filter(raceMissing == T)
prop <- prop %>% select(county_fips, n, ProportionMissing)
wi <- merge(wi, prop, by.x = "county_fips", by.y = "county_fips")

##Getting the county name, population, and area
countyInfo <- trafficStops %>% group_by(county_fips) %>% select(county_fips, county_name, population, area)
countyInfo <- unique(countyInfo)
wi <- merge(wi, countyInfo, by.x = "county_fips", by.y = "county_fips")

##Colors for fill
bins <- c(0, .1, .2, .3, .4, .5, .6, 1)
pal <- colorBin("YlOrRd", domain = wi$ProportionMissing, bins = bins)

##Labels for hovering over county
labels <- sprintf(
  "<strong>%s</strong><br/>Population: %g<br/>Percent Missing: %g",
  wi$county_nam,wi$population,round(wi$ProportionMissing,3)
) %>% lapply(htmltools::HTML)

##Leaflet to map counties
leaflet(wi) %>%
  addTiles() %>%
  addPolygons(
    fillColor = ~pal(ProportionMissing),
    weight = 2,
    opacity = 1,
    color = "white",
    dashArray = "3",
    fillOpacity = 0.7,
    highlight = highlightOptions(
      weight = 5,
      color = "#666",
      dashArray = "",
      fillOpacity = 0.7,
      bringToFront = TRUE),
    label = labels,
    labelOptions = labelOptions(
      style = list("font-weight" = "normal", padding = "3px 8px"),
      textsize = "15px",
      direction = "auto")) %>% 
  addLegend(pal = pal, values = ~ProportionMissing, opacity = 0.7, title = "Proportion Missing Race ",
            position = "bottomleft")


