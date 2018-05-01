library(shinycssloaders)
library(leaflet)
library(shiny)
library(caret)
ui <- fluidPage(
  
  navbarPage("Wisconsin Traffic Stops",
             tabPanel("Introduction", value = "intro",
                      div(class = "outer",
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
                              withSpinner(leafletOutput("mappedData")),
                              tags$br(),
                              tags$br()
                            )
                          ),
                          fluidRow(
                            column(12, align = "center",
                                   h3("The End of Racial Profile Tracking")),
                            h4(tags$a(href = "http://host.madison.com/wsj/news/local/govt-and-politics/walker-signs-bill-ending-racial-profile-tracking-program/article_3209a440-9d1f-11e0-bce2-001cc4c002e0.html", 
                                      "In 2011, the bill that required officers to collect race data was repealed.")),
                            h4("However, we see that the proportion of stops missing race data was very low between
                               2011 and 2014."),
                            img(src='MissingRace2011.png', align = "center"),
                            tags$br(),
                            tags$br(),
                            tags$br()
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
                      )),
             tabPanel("Predictive Model", value = "model",
                      div(class = "outer",
                          fluidRow(
                            column(12, align = "center", 
                                   h3("Build your own model", align = "center"),
                                   checkboxGroupInput("checkGroup", label = h4("Select variables to include in model"), 
                                                      choices = list("County Fips" = "county_fips",
                                                                     "Police Department" = "police_department", 
                                                                     "Driver Gender" = "driver_gender",
                                                                     "Search Conducted" = "search_conducted", 
                                                                     "Stop Outcome" = "stop_outcome",
                                                                     "Year" = "year", 
                                                                     "Month" = "month", 
                                                                     "Number of Violations" = "num_violations",
                                                                     "Population" = "population", 
                                                                     "Area" = "area", 
                                                                     "Percent Minority (County)" = "percentMinority",
                                                                     "Percent Poverty (County)" = "percentPoverty"),
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
                          )
                      ))
  )
  
  
)