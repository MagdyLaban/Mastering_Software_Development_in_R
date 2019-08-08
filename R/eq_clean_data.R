#' @title eq_clean_data
#' @description this function used to clean the data comes from NOAA and add \code{DATE} column
#' @importFrom dplyr mutate
#' @importFrom lubridate ymd
#' @importFrom magrittr %>%
#' @param noaa_data a dataframe contains information about 5,933 earthquakes over an approximately 4,000 year time span
#' @examples
#' \dontrun{
#' noaa <- readr::read_delim("filepath")
#' clean_noaa_data <- eq_clean_data(noaa)
#' }
#' @return clean_data new dataframe repersents a cleaned data from NOAA
#' @export
eq_clean_data <- function(noaa_data){
  clean_data <- noaa_data %>%
    dplyr::mutate(DATE = lubridate::ymd(paste(YEAR, MONTH, DAY)))
  clean_data
}

#' @title eq_location_clean
#' @description this function used to clean the data comes from NOAA and add \code{LOCATION_NAME} column
#' @importFrom dplyr mutate
#' @importFrom stringr str_split
#' @importFrom stringr str_to_title
#' @importFrom magrittr %>%
#' @param noaa_data a dataframe contains information about 5,933 earthquakes over an approximately 4,000 year time span
#' @examples
#' \dontrun{
#' noaa <- readr::read_delim("filepath")
#' clean_noaa_data <- eq_location_clean(noaa)
#' }
#' @return clean_data new dataframe repersents a cleaned data from NOAA
#' @export
eq_location_clean <- function(noaa_data){
  clean_data <- noaa_data %>%
    dplyr::mutate(LOCATION = stringr::str_split(LOCATION_NAME, pattern =  ': '),
                  LOCATION = stringr::str_to_title(LOCATION_NAME))
  clean_data
}
