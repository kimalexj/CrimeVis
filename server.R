library(shiny)
library(leaflet)

shinyServer(function(input, output) {
  # Primary map output on home page
  output$main_map <- renderLeaflet({
    leaflet(options = leafletOptions(zoomControl = FALSE, minZoom = 13, maxZoom = 13)) %>% 
      addTiles() %>% 
      setView(lng = -122.3, lat = 47.6, zoom = 13)
  })
})
