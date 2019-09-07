
<!-- README.md is generated from README.Rmd. Please edit that file -->

# msdr

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/MagdyLaban/Mastering_Software_Development_in_R_Capstone_Coursera.svg?branch=master)](https://travis-ci.org/MagdyLaban/Mastering_Software_Development_in_R_Capstone_Coursera)
<!-- badges: end -->

``` r
library(msdr)
```

# NOAA Earthquakes Capstone

This Package is the final project for mastering software development in
R specialization on Coursera and the major of this package is to make a
package that cleans up and visualizes the NOAA earthquakes data .

# The Full Process

## Reading and cleaning the data

  - you can read the data through the following example :

<!-- end list -->

``` r
NOAA <- read.delim("signif.txt")
```

  - you can clean the data through two methods :

<!-- end list -->

``` r
NOAA %>%
eq_data_clean()
```

``` r
NOAA %>%
eq_location_clean()
```

## Data Visualization

1.this section is for creating a new geoms for ggplot2 , there are two
geoms

  - `geom_timeline()` : this ends up with a timeline geom that
    represents the earthquakes for a specific period of date .

<!-- end list -->

``` r
noaa %>%
    eq_clean_data()%>%
    filter(YEAR >= 2000, COUNTRY == "USA") %>%
    ggplot(aes(x = DATE, size = as.numeric(EQ_PRIMARY), color = as.numeric(TOTAL_DEATHS)))+
    geom_timeline()
```

  - `geom_timeline_label()` : this ends up with a timeline geom that
    represents the earthquakes for a specific period of date and a label
    that shows up the location name where the earthquake has happend .

<!-- end list -->

``` r
noaa %>%
    eq_clean_data() %>%
    eq_location_clean() %>%
    filter(YEAR >= 2000, COUNTRY == "USA") %>%
    ggplot(aes(x = DATE, size = as.numeric(EQ_PRIMARY),color = as.numeric(TOTAL_DEATHS), label = LOCATION)) +
    geom_timeline() +
    geom_timeline_label()
```

2.there are also two leaflet based methods

  - `eq_map()` : this method used to represent the location of each
    earthquakes on a leaflet map .

<!-- end list -->

``` r
noaa %>%
    eq_clean_data() %>%
    dplyr::filter(COUNTRY == "MEXICO" & lubridate::year(DATE) >= 2000) %>%
    eq_map(annot_col = "DATE")
```

  - `eq_create_label()` : this method used to cearte a pop-up that
    contains the information about the earthquakes

<!-- end list -->

``` r
noaa %>%
    eq_clean_data() %>%
    dplyr::filter(COUNTRY == "MEXICO" & lubridate::year(DATE) >= 2000) %>%
    dplyr::mutate(popup_text = eq_create_label(.)) %>%
    eq_map(annot_col = "popup_text")
```
