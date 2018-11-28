library(shiny)
library(leaflet)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("darkly"),
  navbarPage("CrimeVis",
             
    tabPanel("Home",
      sidebarPanel(
        # Validation necessary 
        textInput("neighborhoodEntry", label = h3("Search Neighborhood"), value = "Enter neighborhood here... "),
        dateRangeInput("dateRange", label = h3("Date range")),
        selectInput("select", label = h3("Time"), choices = list("AM" = "Morning", "PM" = "Night", "Both" = "MornNight"), 
                    selected = "MornNight"),
        checkboxGroupInput("filters", label = h3("Type Filter"), 
                           choices = list("Theft" = "THEFT", "Burglary" = "BURGLARY", "Narcotics" = "NARC",
                           "Tresspassing" = "TRESSPASS", "Vehicle" = "VEH", "Children Affiliated" = "CHILD", 
                           "Arson" = "ARSON", "Assault" = "ASSLT", "Rape" = "RAPE", "Sexual Offense" = "SEXOFF",
                           "Homicide" = "HOMICIDE", "Prostitution" = "PROSTITUTION", "Obscene Material" = "PORNOGRAPHY",
                           "DUI" = "DUI"))
      ),
      mainPanel(
        leafletOutput("main_map", height = 800)
      )
    ),
    
    tabPanel("Crime Type",
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
    
    tabPanel("Crime Trend",
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
