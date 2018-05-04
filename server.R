load("data.RData")
load("geoData.Rdata")
library(shinycssloaders)
library(shinyjs)
library(caret)
library(ROCR)
library(RColorBrewer)
library(leaflet)
library(tidyverse)
library(shiny)
library(e1071)
library(choroplethr)
server <- function(input, output) {
  
  output$mappedData <- renderLeaflet({
    
    if(input$slider == 2011){
      filteredData <- data %>% filter(year == 2011)
    }
    else if(input$slider == 2012){
      filteredData <- data %>% filter(year == 2012)
    }
    else if(input$slider == 2013){
      filteredData <- data %>% filter(year == 2013)
    }
    else if(input$slider == 2014){
      filteredData <- data %>% filter(year == 2014)
    }
    else if(input$slider == 2015){
      filteredData <- data %>% filter(year == 2015)
    }
    else if(input$slider == 2016){
      filteredData <- data %>% filter(year == 2016)
    }
    prop <- filteredData %>% group_by(county_fips, missingRace) %>% summarise (n = n()) %>%
      mutate(ProportionMissing = n / sum(n)) %>% filter(missingRace == T)
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
  
  
  # build model from user selected checkboxes
  observeEvent(
    eventExpr = input[["submit_loc"]],
    handlerExpr = {
      
      Train <- reactive({
        #data2 <- data[sample(1:nrow(data), 500000, replace = F),]
        createDataPartition(data$missingRace, p=0.7, list=FALSE)
      })
      training <- reactive({
        data[ Train(), ]
      })
      testing <- reactive({
        data[ -Train(), ]
      })
      
      mod_fit <- reactive({
        progress <- shiny::Progress$new()
        on.exit(progress$close())
        progress$set(message = 'Building model', detail = 'This may take a while...')
        ctrl <- trainControl(method = "none", savePredictions = TRUE)
        train(as.formula(paste("missingRace ~",paste(isolate(input$checkGroup),collapse="+"))), data=training(), method="glm", family="binomial", trControl = ctrl)
      })
      
      pred <- reactive({
        predict(mod_fit(), newdata=testing())
      })
      
      output$conMat <- renderPrint({ 
        confusionMatrix(data=pred(), testing()$missingRace, positive = "TRUE")
      })
      
      output$roc <- renderPlot({ 
        pr <- prediction(as.numeric(pred()), as.numeric(testing()$missingRace))
        prf <- performance(pr, measure = "tpr", x.measure = "fpr")
        plot(prf, main="ROC Curve") 
      })
      
      output$residMap1 <- renderPlot({
        residuals <- testing() %>% mutate(prediction = pred()) %>% 
          mutate(correct = (missingRace == prediction)) %>% 
          group_by(county_fips) %>% 
          summarize(ProportionWrong = mean(correct == F))
        
        residuals %>% 
          mutate(value = ProportionWrong, region = as.numeric(as.character(county_fips))) %>% 
          dplyr::select(value, region) %>%
          county_choropleth(title = "Proportion Misclassified Per County", state_zoom = "wisconsin") + 
          scale_fill_brewer(palette="Reds")
      })
      
      reset("submit_loc")
    }
  )
  
}