library(dplyr)

# Adjust the crime offense data column to just contain keywords
map_data <- read.csv("data/Updated_Crime_data.csv")
offenses <- map_data$offense_type
map_data$offense_type <- substr(offenses, 1, regexpr('-', offenses) - 1)

# Large data set for neighborhood filtering and point gathering (Also filters primary offense by key name)
large_map_set <- read.csv("data/Crime_Data.csv")
offenses <- large_map_set$Primary.Offense.Description
large_map_set$Primary.Offense.Description <- substr(offenses, 1, regexpr('-', offenses) - 1)

# All unique neighborhoods dataframe.
all_neighborhoods <- as.data.frame(unique(large_map_set$Neighborhood), stringsAsFactors = FALSE)
colnames(all_neighborhoods) <- c("Neighborhoods")
# Number of reports per neighbhorhood dataframe.
frequency_per_neighborhood <- as.data.frame(table(large_map_set$Neighborhood), stringsAsFactors = FALSE)
colnames(frequency_per_neighborhood) <- c("neighborhoods", "reports")
latitude <- c(47.56, 47.57, 47.69, 47.686, 47.61, 47.72, 47.54, 47.63, 47.62, 47.60, 
               47.56, 47.56, 47.63, 47.58, 47.61, 47.64, 47.64, 47.52, 47.61, 47.65, 
               47.5633, 47.5432, 47.6969, 47.5503, 47.5247, 47.5495, 47.5932, 47.7193, 47.5503, 47.6346,
               47.6003, 47.6396, 47.5526, 47.6211, 47.6417, 47.8201, 47.5832, 47.5389, 47.5812, 47.5794,
               47.5623, 47.7086, 47.6748, 47.5707, 47.6015, 47.6323, 47.5123, 47.502867, 47.6781, 47.5267, 
               47.6787, 47.6256, 47.5830, 47.5318, 47.5269, 47.5311, 47.6089, 0, 47.6613)
longitude <- c(-122.39, -122.4, -122.4, -122.4, -122.34, -122.35, -122.28, -122.32, -122.31, -122.32, 
               -122.3, -122.28, -122.34, -122.35, -122.33, -122.3, -122.32, -122.38, -122.33, -122.35,
               -122.3928, -122.3221, -122.3562, -122.3691, -122.3460, -122.2804, -122.3005, -122.2952, -122.2649, -122.2796,
               -122.2928, -122.3997, -122.3009, -122.3050, -122.3050, -122.2616, -122.2923, -122.2861, -122.3866, -122.3113,
               -122.3655, -122.3232, -122.3566, -122.3593, -122.3343, -122.3569, -122.2640, -122.263383, -122.3156, -122.3699,
               -122.2570, -122.3344, -122.3348, -122.2888, -122.3607, -122.3257, -122.3175, 0, -122.3299)
frequency_per_neighborhood <- mutate(frequency_per_neighborhood, "latitude" = latitude, "longitude" = longitude)





