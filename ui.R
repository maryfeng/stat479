library(shinycssloaders)
library(leaflet)
library(shiny)
library(caret)
library(tidyverse)
load("officer.Rdata")
ui <- fluidPage(
  
  navbarPage("Wisconsin Traffic Stops",
             tabPanel("Introduction", value = "intro",
                      div(class = "outer",
                          
                          fluidRow(
                            column(12, align = "center", 
                                   h3("Introduction", align = "center"),
                                   p(align = "left","The ", a("Stanford Open Policing Project", href="https://openpolicing.stanford.edu/"), "began as an effort to better understand and improve relations between law enforcement and the public. Previous reports on the data indicate that racial biases continue to exist in policing nationwide, making the inclusion of racial information in policing reports essential to the recognition, and hopeful improvement, of existing inequalities in policing."),
                                   p(align = "left","Our project aims to explore the reasons why so many traffic stops in Wisconsin are missing racial data by use of logistic regression and data exploration. We have also included the percent of the population in poverty and the percent minority in the dataset (as of 2013) from American Factfinder.")
                            )
                          ),
                          
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
                                   p("Each time you click the 'Submit' button, the data is randomly partitioned into a train/test set using 70%/30% of the data, respectively. (Only one model is fit to the entire training set without cross validation due to time constraints.) The variables you select are used as predictors in a logistic regression model with missing race as the outcome. After training and testing, metrics of the model performance on the test set are displayed, followed by a map displaying the proportion misclassified by county."),
                                   p("A suggested predictor to include is year (default setting) for reasons described in the introduction tab. Including driver gender or search outcome seems to result in good performance, but this is most likely due to the fact that when driver race is missing, driver gender and other information about the stop in general tend to be missing as well."),
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
                                            column(6, plotOutput("roc"))),
                                   tags$br(),
                                   fluidRow(column(12, plotOutput("residMap1")))
                            )
                          )
                      )),
             tabPanel("Officer", value = "officer",
                      div(class = "outer",
                          fluidRow(
                            column(12, align = "center", 
                                   h3("Missing race by officer", align = "center"),
                                   p("In the scatter plot below, each officer is a dot. The horizontal axis denotes the number of stops made by the officer, and the vertical axis denotes the proportion of total stops made by the officer which are missing race. This shows there are some officers, often those who make fewer stops, with a higher proportion of missing race data."),
                                   img(src='officer_race.png', align = "center", width="500"),
                                   h3("Explore missing race data by officer id", align = "center"),
                                   p("Select an officer id to display the proportion of stops missing race by officer and county."),
                                   selectInput('officer', 'Select officer id', 
                                               officer_missingRace %>% distinct(officer_id) %>% arrange(officer_id), 
                                               selectize=FALSE,
                                               selected='2176'),
                                   plotOutput('officer_race'),
                                   plotOutput('officer')
                            )
                          )
                      )),
             tabPanel("Feedback",
                      div(class = "outer",
                          fluidRow(
                            column(12, align = "center", 
                                   h3("Changes Made Since Presentation", align = "center"),
                                   p("Since presenting in class, we have added an additional tab to our Shiny app that explores missing data by officer. At the top of the tab is a graph of the number of stops vs the proportion of stops that are missing race, where each dot represents an officer. Additionally, we have included a dropdown menu; the user can select any officer ID and a map is generated that displays the proportion of stops by that officer in each county that are missing race, along with a map that shows number of stops made by officer by county."),
                                   p("Lastly, we have also included a map to assess how well the logistic model performs by county. After specifying and fitting a model, the user can scroll down to the bottom of the Predictive Model tab and view the proportion misclassified per county displayed in a map. The darker the county, the higher the proportion misclassified.")
                            )
                          )
                      ))
  )
  
  
)