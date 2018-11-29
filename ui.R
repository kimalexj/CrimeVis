library(shiny)
library(leaflet)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("darkly"),
  navbarPage("CrimeVis",
             
    tabPanel("Home",
      sidebarPanel(
        # Validation "not necessarily for error" but to see if any crime was in the area 
        textInput("neighborhoodEntry", label = h3("Search Neighborhood"), value = "Enter neighborhood here... "),
        selectInput("select", label = h3("Time of Day"), choices = list("AM" = "Morning", "PM" = "Night", "Both" = "MornNight"), 
                    selected = "MornNight"),
        column(6,
          br(),
          checkboxGroupInput("filters1", label = h3("Type Filter"), 
                             choices = list("Theft" = "THEFT", "Burglary" = "BURGLARY", "Narcotics" = "NARC",
                             "Tresspassing" = "TRESSPASS", "Vehicle" = "VEH", "Children Affiliated" = "CHILD", 
                             "Arson" = "ARSON", "Assault" = "ASSLT", "Rape" = "RAPE"))
        ),
        column(6,
          br(),
          br(),
          br(),
          checkboxGroupInput("filters2", label = "", 
                             choices = list("Sexual Offense" = "SEXOFF",
                             "Homicide" = "HOMICIDE", "Prostitution" = "PROSTITUTION", "Obscene Material" = "PORNOGRAPHY",
                             "DUI" = "DUI", "Robbery" = "ROBBERY", "Fraud" = "FRAUD", "Threats" = "THREATS"))       
        )
      ),
      mainPanel(
        leafletOutput("main_map", width = 900, height = 675)
      )
    ),
    
    tabPanel("Crime Type History",
      column(4
        #Data Table here Use 
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
