library(shiny)
library(leaflet)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("sandstone"),
  navbarPage("CrimeVis",
             
    tabPanel("Home",
      sidebarPanel(
        # Validation "not necessarily for error" but to see if any crime was in the area 
        textInput("neighborhoodEntry", label = h4("Search Neighborhood"), placeholder = "Enter neighborhood i.e. SANDPOINT", 
                  value = "SANDPOINT"),
        selectInput("select", label = h4("Time of Day"), choices = list("AM" = "AM", "PM" = "PM", "Both" = "0000"), 
                    selected = "0000"),
        selectInput("selectType", label = h4("Map Type"), choices = list("Current Crimes" = "current", "Neighborhoods" = "neighbor"),
                    selected = "current"),
        column(6,
          br(),
          checkboxGroupInput("filters1", label = h4("Type Filter"), 
                             choices = list("Theft" = "THEFT", "Burglary" = "BURGLARY", "Narcotics" = "NARC",
                             "Tresspassing" = "TRESSPASS", "Vehicle" = "VEH", "Children Affiliated" = "CHILD", 
                             "Arson" = "ARSON", "Assault" = "ASSLT", "Rape" = "RAPE"), selected = c("THEFT", "BURGLARY",
                             "VEH", "THEFT"))
        ),
        column(6,
          br(),
          br(),
          br(),
          checkboxGroupInput("filters2", label = "", 
                             choices = list("Sexual Offense" = "SEXOFF",
                             "Homicide" = "HOMICIDE", "Prostitution" = "PROSTITUTION", "Obscene Material" = "PORNOGRAPHY",
                             "DUI" = "DUI", "Robbery" = "ROBBERY", "Fraud" = "FRAUD", "Threats" = "THREATS", "Forgery" = "FORGERY"),
                             selected = c("FRAUD", "THREATS", "FORGERY"))       
        )
      ),
      mainPanel(
        tabsetPanel(type = "tabs",
          tabPanel("Primary Map", leafletOutput("main_map", width = 900, height = 600)),
          tabPanel("Neighborhood Plot", plotOutput("neighborhoodType", width = 900, height = 600))
        )
      )
    ),
    
    tabPanel("Crime Type History",
      column(4,
             
        #Data Table here Use (kable)
        DT::dataTableOutput("crimeType")

      ),
      column(8,
        # Input plot call here
        hr(),
        fluidRow(
          # Input paragraph here
        )
      )
    ),
    
    tabPanel("Crime Trend History",
      column(4
      #Data Table here Use (kable)
      ),
      column(8,
        # Input plot call here
        hr(),
        fluidRow(
        # Input paragraph here
        )
      ) 
    ),
    
    tabPanel("Resources"
    
    )
    
  )
))
