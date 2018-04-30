library(shinycssloaders)
ui <- fluidPage(
  
  # App title ----
  titlePanel("Traffic Stops: Missing Race Data"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      
      sliderInput("slider", "Year:",
                  min = 2011, max = 2016,
                  value = 2011, sep = "", step = 1,
                  animate = animationOptions(interval = 5000, loop = TRUE))),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      withSpinner(leafletOutput("mappedData"))
    )
  ),
  # checkboxes to build model
  fluidRow(
    column(12, align = "center", 
           h3("Build your own model", align = "center"),
           checkboxGroupInput("checkGroup", label = h4("Select variables to include in model"), 
                              choices = list("county_fips" = "county_fips",
                                             "police_department" = "police_department", 
                                             "driver_gender" = "driver_gender",
                                             "search_conducted" = "search_conducted", 
                                             "stop_outcome" = "stop_outcome",
                                             "year" = "year", 
                                             "month" = "month", 
                                             "num_violations" = "num_violations",
                                             "population" = "population", 
                                             "area" = "area", 
                                             "percentMinority" = "percentMinority",
                                             "percentPoverty" = "percentPoverty"),
                              inline = TRUE,
                              selected = "year"),
           actionButton(
             inputId = "submit_loc",
             label = "Submit"
           ),
           hr(),
           fluidRow(column(6, verbatimTextOutput("conMat")),
                    column(6, plotOutput("roc")))
    )
  ),
  
  fluidRow(
    column(12, align = "center", 
           h3("2014-2015: When did the officers stop recording race data?", align = "center"),
           img(src='PercentMissingRace.png', align = "left"),
           h4("November 2014: "),
           tags$a(href="https://www.postcrescent.com/story/news/nation/2014/11/18/ferguson-black-arrest-rates/19043207/", "Nationwide"),
           tags$br(),
           tags$a(href="https://www.postcrescent.com/story/news/investigations/2014/11/18/wisconsin-black-arrest-rates-dwarf-ferguson/19244069/", "In Wisconsin")
           
    )
  )
)