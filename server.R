library(shiny)
library(leaflet)
library(dplyr)
library(knitr)

shinyServer(function(input, output) {
  # Primary map output on home page
  output$main_map <- renderLeaflet({
    leaflet(options = leafletOptions(zoomControl = FALSE, minZoom = 11, maxZoom = 15)) %>% 
      addTiles() %>% 
      setView(lng = -122.3, lat = 47.6, zoom = 11) %>% 
      setMaxBounds(lng1 = -122.4, lng2 = -122.2, lat1 = 47.75, lat2 = 47.4)
  })
  
  output$example <- renderTable({
    
  })
})
