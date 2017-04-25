## Download weather data using the weatherData package
library(checkpoint)
checkpoint("2017-04-25", use.knitr=TRUE)

library(weatherData)

#use this to check availability of data when adding cities
#checkDataAvailability("ATL","2004-01-01")
#cities <- c("MIA")

cities <- c("JFK","SEA","ORD","BOS","ATL")
cityLongNames <- c("New York City", "Seattle","Chicago","Boston","Atlanta")
yearStarts <- c(1990, 2005,2001,2001,2001)
yearEnds <- c(2016, 2016,2016,2016,2016)


#cities <- c("ORD","BOS","SEA","ATL")
#cityLongNames <- c("Chicago","Boston","Seattle","Atlanta")
#yearStarts <- c(2001,2001,2001,2001)
#yearEnds <- c(2016,2016,2016,2016)

weatherHistory <- NULL
for(thecity in seq(along=cities)) {
  city <- cities[thecity]
  cityLongName <- cityLongNames[thecity]
  yearStart <- yearStarts[thecity]
  yearEnd <- yearEnds[thecity]

  if (!checkDataAvailability(city, paste(yearStart, "-01-01", sep = ""))
      || !checkDataAvailability(city, paste(yearEnd, "-12-31", sep = ""))) {
    stop("Data not available for selected city/dates")
  }
  
  for (year in yearStart:yearEnd) {
    weatherHistory <- rbind(weatherHistory,
                            cbind(
                            getWeatherForYear(city, year),
                            CityName=city,
                            CityLongName=cityLongName)
    )
  }

}

weatherHistory$Date <- as.POSIXct(weatherHistory$Date)
save(weatherHistory, file="weatherHistory.Rd")
