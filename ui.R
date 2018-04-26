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