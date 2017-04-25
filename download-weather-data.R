#### Download weather data using the rnoaa library
#### NOT WORKING YET: use download-weather-data-weatherdata.R

library(checkpoint)
checkpoint("2017-04-18")
library("tidyr")
library("purrr")
library("rnoaa")

## global variables
YEAR_MIN = 2007 # first year to pull data
YEAR_MAX = 2016 # last year to pull data
UNITS = "F" # Choose "C" for celcius or "F" for Fahrenheit


## List of cities to download data for
cities <- c(
  "Chicago",
  "Sydney",
  "Paris",
  "Seattle"
)

## Find lat/long of cities
library("ggmap")
library()
latlon <- geocode(cities)
city.loc <- tibble(id=seq(along=cities), city=cities, latitude=latlon$lat, longitude=latlon$lon)

### Find nearest weather station for each city
library(purrr)

## Cache station location data, or load if cached
if(!file.exists("station_data.Rd")) { 
  station_data <- ghcnd_stations()
  save("station_data", file="station_data.Rd")
    } else { 
  load("station_data.Rd")
}

## get list of weather stations within 10kn of each member of `cities`
nearby <- meteo_nearby_stations(city.loc, station_data=station_data, radius=10, year_min=YEAR_MIN)

## identify whether a given monitor mon_id returns temperature data since YEAR_MIN
mon_with_temps <- function(mon_ids, ym=YEAR_MIN) {
  checkdate = paste0(ym,"-01-01")
  suppressWarnings(
  tdata <- meteo_pull_monitors(mon_ids, date_min = checkdate, date_max=checkdate,
                               var=c("TAVG","TMAX","TMIN"))
  )
  print(tdata)
  tdata$id
}

nearby %>% 
  map(
    function(nearlist) mon_with_temps(nearlist$id)[1]
  ) -> temp_stations


### Given cities and monitor data, download weather data
### store results in weatherdata.Rd

city_stations <- tibble(
  city= c(
  "Chicago",
  "Sydney",
  "Paris",
  "Seattle"
  ),
  station=c(
    "USC00111550",
    "ASN00066037",
    "FR000007150",
    "USW00024234"
  )
)
min_date <- paste0(YEAR_MIN,"-01-01")
max_date <- paste0(YEAR_MIN,"-01-01")

  