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
      column(4,
             
        #Data Table here Use (kable)
        DT::dataTableOutput("crimeType", width = "100%")

      ),
      column(8,
        plotOutput("crime_type_plot", width = 800, height = 500),
        hr(),
        fluidRow(
          textOutput("summaryText")
        )
      )

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
    
    tabPanel("Resources",
      fluidRow(
        textOutput("resourcesText")
      )
    )
    
      fluidPage(
        verticalLayout(
          fluidRow(
            tags$div(style = "text-align:center",
              tags$h1("Contributors (Team ACSpacey)", style="font-weight: bold"),
              tags$div(
                tags$a(href = "https://github.com/kimalexj",
                  tags$img(src = "https://github.com/kimalexj.png", width = 150, height = 150, style = "border-radius: 25px; margin-right: 50px")
                ),
                tags$a(href = "https://github.com/Nathan-Lee-8",
                       tags$img(src = "https://github.com/Nathan-Lee-8.png", width = 150, height = 150, style = "border-radius: 25px; margin-right: 50px")
                ),
                tags$a(href = "https://github.com/praveenk12345",
                       tags$img(src = "https://github.com/praveenk12345.png", width = 150, height = 150, style = "border-radius: 25px; margin-right: 50px")
                ),
                tags$a(href = "https://github.com/ngoa2",
                       tags$img(src = "https://github.com/ngoa2.png", width = 150, height = 150, style = "border-radius: 25px; margin-right: 50px")
                ),
                tags$a(href = "https://github.com/miahcheng",
                       tags$img(src = "https://github.com/miahcheng.png", width = 150, height = 150, style = "border-radius: 25px")
                )
             ),
              tags$p("(From left to right: Alexander Kim, Nathan Lee, Praveen Kesapragada, Alan Ngo, and Jeremiah Cheng)", 
                     style = "margin-top: 10px; font-size: 15px")
            )
          ),
          hr(),
          fluidRow(
            column(6,
              tags$h1(style = "font-weight: bold", "Motivations/Purpose"),
              tags$p(style = "font-size: 15px", "This project was created with the driven goal of promoting safety for civilians of the Seattle area 
                     including more importantly, students. As a result, we as a group planned and designed an application that 
                     would serve as a hub for updated information regarding crime specifically relevant to our current day."),
              br(),
              tags$p(style = "font-size: 15px", "CrimeVis is a result of this cumulative effort to instill awareness of the 
                     prevalence of danger in the Seattle area by providing access to pinpoint locations of crime in the past
                     48 hours and two additional visualizations for types of crime and their respective trends that manifest 
                     the gradual increase and/or decrease of crime through history. It is important to also consider that the
                     application does pertain to us even in current day because this data does include 2018.")
            ),
            column(6,
              tags$h1(style = "font-weight: bold", "Tab Guides"),
              tags$h4(style = "text-decoration: underline", "Home Page"),
              tags$li("Interactive map that pinpoints the most recently reported crime in the past 48 hours."),
              tags$li("Additional map that visually displays the quantity of crime reported in given neighborhoods of Seattle."),
              tags$h4(style = "text-decoration: underline", "Crime Type Page"),
              
              tags$h4(style = "text-decoration: underline", "Crime Trend Page"),
              tags$li("Interactive line plot that displays the trend of reports of specific types of crimes over time."),
              tags$li("Data table provided for user reference for tracking specific reports")
            )
          )
        )
      )
    )  
  )
))