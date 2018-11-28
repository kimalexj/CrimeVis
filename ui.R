library(shiny)
library(leaflet)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("darkly"),
  navbarPage("CrimeVis",
             
    tabPanel("Home",
      sidebarPanel(
        # Validation necessary 
        textInput("neighborhoodEntry", label = h3("Search Neighborhood"), value = "Enter neighborhood here... "),
        selectInput("select", label = h3("Time"), choices = list("AM" = "Morning", "PM" = "Night", "Both" = "MornNight"), 
                    selected = "MornNight"),
        dateRangeInput("dateRange", label = h3("Date range"), min = '2008-01-01', max = '2018-12-30'),
        checkboxGroupInput("filters", label = h3("Type Filter"), 
                           choices = list("Theft" = "THEFT", "Burglary" = "BURGLARY", "Narcotics" = "NARC",
                           "Tresspassing" = "TRESSPASS", "Vehicle" = "VEH", "Children Affiliated" = "CHILD", 
                           "Arson" = "ARSON", "Assault" = "ASSLT", "Rape" = "RAPE", "Sexual Offense" = "SEXOFF",
                           "Homicide" = "HOMICIDE", "Prostitution" = "PROSTITUTION", "Obscene Material" = "PORNOGRAPHY",
                           "DUI" = "DUI"))
      ),
      mainPanel(
        leafletOutput("main_map", width = "100%", height = 800)
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
