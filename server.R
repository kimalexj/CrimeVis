library(shiny)
library(leaflet)
library(dplyr)
library(htmltools)
library(ggplot2)
library(stringr)
library(RColorBrewer)
library(colorRamps)
library(DT)
library(lubridate)
source('scripts/HomePageData.R')

# Validation for Neighborhood input
proper_neighborhood <- function(input) {
  if (!(input %in% all_neighborhoods$Neighborhoods)) {
    "Please input a proper neighborhood in the same format as the initial value, i.e. SANDPOINT. 
    To check for potential neighborhood choices, select neighborhood under Map Type and click on 
    the desired circle for a proper name"
  } else {
    NULL
  }
}

data_config <- function() {
  data_occurred <- as.Date(large_map_set$Occurred.Date, format = "%m/%d/%Y")
  data_reported <- as.Date(large_map_set$Reported.Date, format = "%m/%d/%Y")
  
  data2 <- large_map_set %>%
    select(-Report.Number) %>%
    mutate(Occurred.Date = data_occurred) %>%
    mutate(Reported.Date = data_reported) %>% 
    select(Occurred.Date, Occurred.Time, Reported.Date, Reported.Time, Primary.Offense.Description)
  
  data2
}

shinyServer(function(input, output) {
  
  filtered_time_check <- reactive({
    collected_inputs <- c(input$filters1, input$filters2) 
    new_data <- map_data %>% 
      filter(str_detect(date_reported, input$select)) %>% 
      filter(offense_type %in% collected_inputs)
    return(new_data)
  })
  
  # Primary map output on home page
  output$main_map <- renderLeaflet({
    if (input$selectType == "current") {
      leaflet(data = filtered_time_check(), options = leafletOptions(zoomControl = FALSE, minZoom = 11, maxZoom = 15)) %>% 
        addTiles() %>% 
        setView(lng = -122.3, lat = 47.6, zoom = 11) %>% 
        setMaxBounds(lng1 = -122.4, lng2 = -122.2, lat1 = 47.8, lat2 = 47.4) %>% 
        addMarkers(~longitude, ~latitude)
    } else {
      leaflet(data = frequency_per_neighborhood, options = leafletOptions(zoomControl = FALSE, minZoom = 11, maxZoom = 15)) %>% 
        addTiles() %>% 
        setView(lng = -122.3, lat = 47.6, zoom = 11) %>% 
        setMaxBounds(lng1 = -122.4, lng2 = -122.2, lat1 = 47.8, lat2 = 47.4) %>% 
        addCircleMarkers(
          lat = ~latitude, lng = ~longitude, popup = ~htmlEscape(neighborhoods), stroke = FALSE, fillOpacity = 0.6,
          fillColor = "#004d99", radius = ~reports / 1000 * 1.5
        ) 
    }
  })
  
  # Render absolute panel to have designated plot
  panel_data <- reactive({
    validate(
      proper_neighborhood(input$neighborhoodEntry)
    )
    large_map_set$Primary.Offense.Description <- sub("^$", "UNKNOWN", large_map_set$Primary.Offense.Description)
    filtered_neighborhood <- large_map_set %>% 
      filter(Neighborhood == input$neighborhoodEntry) %>% 
      select(Primary.Offense.Description)
    freq_per_crime <- as.data.frame(table(filtered_neighborhood), stringsAsFactors = FALSE)
    colnames(freq_per_crime) <- c("Crimes", "Reports")
    return(freq_per_crime)
  })
  
  output$neighborhoodType <- renderPlot({
    colorCount = length(panel_data()$Crimes)
    ggplot(panel_data(), aes(x=Crimes, y=Reports, fill=Crimes)) + geom_bar(stat="identity") + 
      ggtitle("Designated Neighborhood Crime Distribution") + scale_fill_manual(
        values = colorRampPalette(brewer.pal(8, "Accent"))(colorCount), guide = guide_legend(ncol = 2)) + 
      theme(legend.position = "right") + geom_text(aes(label=Reports), hjust = -0.25, size=3.5) +
      theme(axis.text.x = element_text(face = "bold", size = 13)) + 
      theme(axis.title.x = element_text(face = "bold", size = 16, vjust = 0)) +
      theme(axis.text.y = element_text(face = "bold", size = 13)) + 
      theme(axis.title.y = element_text(face = "bold", size = 16, vjust = 2)) + 
      scale_y_continuous(limits = c(0, 600)) + theme(plot.title = element_text(face = "bold", size = 20)) +
      coord_flip()
  })
  
  output$crime_type_plot <- renderPlot({
    large_map_set$Primary.Offense.Description <- sub("^$", "UNKNOWN", large_map_set$Primary.Offense.Description)
    filtered_occurances <- group_by(large_map_set, Primary.Offense.Description) %>% summarise(count = n())
    colorCount = length(filtered_occurances$Primary.Offense.Description)
    
    plot <- ggplot(filtered_occurances, aes(Primary.Offense.Description, count, fill = Primary.Offense.Description)) + 
      geom_bar(stat = "identity", width = .5) + ggtitle("Crime Types in The Greater Seattle Area") + 
      theme(axis.text.x = element_text(size = 10, angle = 90), plot.title = element_text(face = "bold", 
                                                                                        size = 20, hjust = 0.5)) + 
      geom_text(aes(label=count), vjust = -0.55) + xlab("Crime Types") + ylab("Count") + scale_fill_manual(
        values = colorRampPalette(brewer.pal(8, "Accent"))(colorCount), guide = guide_legend(title = "Crime Types" , ncol = 2))
    print(plot)
  })
  
  output$summaryText <- renderText({
    paste("There has been an increase in the number of crimes committed in the last decade in the Greater Seattle Area.",
          "In 2010, there were 43,971 crimes commited while in 2017 there were 50663 crimes committed.", 
          "When looking at the just the numbers, it may seem that the crime rate has increased significantly but",
          "the population increase in Seattle may be the influence of the increase. In 2010 there were just 610,000 people",
          "living within the city borders of Seattle and that number increased to 725,000 in 2017. The crime rate increase",
          "from 2010-2017 was roughly +15% while the population increase was roughly +19%. Relatively, the incease in crime",
          "rate is lower than the increase in population and the crime rate per capita has actually decreased from 2010 to",
          "2017.")
  })
  
  
  
  output$crimeType <- DT::renderDataTable({
    filtered_data <- large_map_set %>% select(Neighborhood, Occurred.Date, Occurred.Time,
                                              Crime.Subcategory, Primary.Offense.Description)
    DT::datatable(filtered_data, options = list(pageLength = 10, scrollX = TRUE, scrollY = '450px')) %>% formatStyle(names(filtered_data))
  })
  
  output$resourcesText <- renderText({
    paste("Population data in Crime Type History found from ",
    "https://www.seattle.gov/police/information-and-data/crime-dashboard")
  })
  
  output$trend_Plot <- renderPlot({
    if(input$crimechoice != "ALL CRIME"){
      crime_frame <- filter(large_map_set, Primary.Offense.Description == input$crimechoice)
    }
    else{
      crime_frame <- large_map_set
    }
    map_plus_year <- mutate(crime_frame,"Year" = year(mdy(Reported.Date)))
    number_of_s <- as.data.frame(table(map_plus_year$Year))
    names(number_of_s) = c("YearOfCrime", "Number_of_Crime")
    number_of_s$YearOfCrime <- as.integer(as.character(number_of_s$YearOfCrime))
    number_of_s <- number_of_s %>%
      filter(YearOfCrime >= 2008)
    ggplot(number_of_s, aes(x = YearOfCrime, y = Number_of_Crime)) + geom_line() + geom_point() +
      labs(title = str_to_title(paste0("Trendline for ", input$crimechoice)), 
           x = "Year", y = "Number of Reports") + 
      theme(plot.title = element_text(face = "bold", size = 20)) +
      theme(axis.title.x = element_text(face = "bold", size = 16, vjust = -2)) + 
      theme(axis.title.y = element_text(face = "bold", size = 16, vjust = 3)) 
  })
  
  output$table <- renderDataTable(data_config(), options = list(
    scrollY = '450px', pageLength = 10, scrollX = TRUE)
  )
})
