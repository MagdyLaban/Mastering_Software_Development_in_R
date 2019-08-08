#' @title eq_map
#' @description Function that takes a data from NOAA and annotation column to
#' get back a leaflet map represents individual earthquakes .
#' @param data the data obtained from NOAA .
#' @param annot_col column used for annotation in the pop-up graph
#' @importFrom leaflet leaflet
#' @importFrom leaflet addTiles
#' @importFrom leaflet addCircleMarkers
#' @importFrom magrittr %>%
#' @examples
#' \dontrun{
#' noaa %>%
#'  eq_clean_data() %>%
#'  dplyr::filter(COUNTRY == "MEXICO" & lubridate::year(DATE) >= 2000) %>%
#'  eq_map(annot_col = "DATE")
#' }
#' @export
eq_map <- function(data, annot_col) {
  leaflet::leaflet() %>%
    leaflet::addTiles() %>%
    leaflet::addCircleMarkers(data = data,
                              lng = ~ LONGITUDE,
                              lat = ~ LATITUDE,
                              radius = ~ as.numeric(EQ_PRIMARY),
                              popup = ~ data[[annot_col]],
                              fillOpacity = 0.3)
}
#' @title eq_create_label
#' @description Function used to create a pop-up that contains each earthquake information
#' @param data the data obtained from NOAA .
#' @examples
#' \dontrun{
#' noaa %>%
#' eq_clean_data() %>%
#' dplyr::filter(COUNTRY == "MEXICO" & lubridate::year(DATE) >= 2000) %>%
#' dplyr::mutate(popup_text = eq_create_label(.)) %>%
#' eq_map(annot_col = "popup_text")
#' }
#' @export
eq_create_label <- function(data) {
  paste("<b>Location :</b>", data$LOCATION_NAME, "<br />",
        "<b>Magnitude :</b>", data$EQ_PRIMARY, "<br />",
        "<b>Total deaths :</b>", data$TOTAL_DEATHS, "<br />")
}


