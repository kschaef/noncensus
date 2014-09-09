library(shiny)
library(noncensus)
library(leaflet)
library(dplyr)



county_data <- readRDS("data/data.rds")
extra_data <- readRDS("data/extras.rds")
grain <- extra_data$map
fillColors <- extra_data$colors
leg_txt <- extra_data$legend
fill_name <- extra_data$old[1]
if(length(extra_data$old) > 1){
  cat_name <- extra_data$old[2]
  county_cats <- levels(factor(county_data$categories))
}
tile <- extra_data$bg_tile
if (is.na(tile)) tile <- NULL
attr <- extra_data$bg_attr
if (is.na(attr)) attr <- NULL

if (grain == "county"){
data(county_polygons)
comp_two <- merge(county_polygons, county_data, by = "fips", all.x = T)
comp_two <- comp_two %>% arrange(group, order)
} else if (grain == "state"){
  data(state_polygons)
  comp_two <- merge(state_polygons, county_data, by = "fips", all.x = T)
  comp_two <- comp_two %>% arrange(group, order)
} else {
  data(world_polygons)
  comp_two <- merge(world_polygons, county_data, by = "fips", all.x = T)
  comp_two <- comp_two %>% arrange(group, order)
}

