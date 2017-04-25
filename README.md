# Weather Report: An example of using checkpoint with knitr and RStudio 

This is an example R Markdown notebook showing how to use the [`checkpoint` package](https://github.com/RevolutionAnalytics/checkpoint) with knitr and RStudio.

## Create a weather report

First, run the script `download-weather-data.R`. This will download historical weather data for New York City (NYC), Chicago (ORD), Boston (BOS),
Seattle (SEA) and Alanta (ATL), and saves the data as an R object in `weatherHistory.Rd`. You can configure the script to download data for different cities, if you like. The download process can take several minutes.

Once you have downloaded the data, the file `weather-report.Rmd` will generate a Word document summarizing the weather in Chicago in 2016. You can choose another cities' data by changing the `city` variable on line 24 to its corresponding airport code, if the data is included in `weatherHistory.Rd`.

Note that both the `download-weather-data.R` script and the `weather-report.Rmd` R Markdown file use the `checkpoint` function for reproducibility. Both scripts will download and use their dependent R packages as they were on April 18, 2017. The first time `checkpoint("2017-04-18")` is called, it will automatically detect the required packages and download them into your `~/.checkpoint` folder. If you haven't used `checkpoint` before, install it from CRAN first with `install.packages("checkpoint")`. You should also run:
```
checkpoint("2017-04-18")
```
from the R console, and confirm that you wish to create the `~/.checkpoint` folder.

## Using checkpoint with RStudio and knitr

RStudio requires several packages to be installed when you click the "Knit" button, and when using `checkpoint` those packages need to be installed for the corresponding checkpoint date. There is a very simple way to do this: when you use `checkpoint` in a `.Rmd` file, simply ensure there isa .R file containing the following lines in the same folder:
```
library("formatR")
library("htmltools")
library("caTools")
library("bitops")
library("base64enc")
library("rprojroot")
library("rmarkdown")
```
While this `.R` file is never exectuted, the `checkpoint` function will discover it and ensure the named packages are installed for the checkpoint date. That's the purpose of the `knitr-packages.R` file in this example.
