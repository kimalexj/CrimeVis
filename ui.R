library(shiny)
library(leaflet)
library(shinythemes)
CrimeList <- as.vector(unique(large_map_set$Primary.Offense.Description))
CrimeList <- append(CrimeList, "ALL CRIME", 0)
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
    column(4,
      dataTableOutput("table")
      ),
      column(8,
        # Input plot call here
        plotOutput("trend_Plot"),
        hr(),
        fluidRow(
          selectInput(
            inputId = "crimechoice",
            label = "Choose a type of Crime",
            choices = CrimeList
          ),
          p(" Crime in Seattle has noticeably increased throughout the years. 
            Several ",a("sites", 
              href =  "https://www.neighborhoodscout.com/wa/seattle/crime"),
            " have stated that 98% of the cities in the United States are safer 
            than Seattle. Therefore, it is important for us to see what crimes 
            are contributing to the rate of reports in Seattle over time. 
            As the trendline above represents, the ", strong("general crime "),"as a whole has decreased by ",
            strong("several thousand "),"reports in the recent years. Due to the ",
            a("increased security and extra police force, ", 
              href = "https://www.king5.com/article/news/local/seattle-mayors-59-billion-budget-would-pay-for-40-additional-police-officers/281-597660900"),
            "crimes such as ",strong("theft, burglary, narcotics, and grand theft auto "),
            "are all decreasing. Unfortunately, crimes such as ",strong("rape, assault, and homicide"),
            "are either staying stagnant or increasing. It is also interesting to note that crimes such as ",
            strong("prostitution and child abuse "),"are close to being absolete. By educating ourselves on the crime 
            trends in our community we can enact change together and make our community a safer place to live."
            ,style = "font-family: 'times'; font-si20pt")
          
           
              
          
             
          
          
          
          
          
          
        )
      ) 
    ),
    
    tabPanel("Resources"
    
    )
    
    )
))