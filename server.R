server <- function(input, output) {
  
  output$mappedData <- renderLeaflet({
    
    filteredData <- trafficStops %>% filter(!grepl("2010",stop_date))
    
    if(input$slider == 2011){
      filteredData <- trafficStops %>% filter(grepl("2011",stop_date))
    }
    else if(input$slider == 2012){
      filteredData <- trafficStops %>% filter(grepl("2012",stop_date))
    }
    else if(input$slider == 2013){
      filteredData <- trafficStops %>% filter(grepl("2013",stop_date))
    }
    else if(input$slider == 2014){
      filteredData <- trafficStops %>% filter(grepl("2014",stop_date))
    }
    else if(input$slider == 2015){
      filteredData <- trafficStops %>% filter(grepl("2015",stop_date))
    }
    else if(input$slider == 2016){
      filteredData <- trafficStops %>% filter(grepl("2016",stop_date))
    }
    prop <- filteredData %>% group_by(county_fips, raceMissing) %>% summarise (n = n()) %>%
      mutate(ProportionMissing = n / sum(n)) %>% filter(raceMissing == T)
    prop <- prop %>% select(county_fips, n, ProportionMissing)
    wiGeo <- merge(wi, prop, by.x = "county_fips", by.y = "county_fips")
    
    ##Colors for fill
    bins <- c(0, .1, .2, .3, .4, .5, .6, 1)
    pal <- colorBin("YlOrRd", domain = wiGeo$ProportionMissing, bins = bins)
    
    ##Labels for hovering over county
    labels <- sprintf(
      "<strong>%s</strong><br/>Population: %g<br/>Proportion Missing: %g",
      wiGeo$county_nam,wiGeo$population,round(wiGeo$ProportionMissing,3)
    ) %>% lapply(htmltools::HTML)
    
    ##Leaflet to map counties
    leaflet(wiGeo) %>%
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
  })
}