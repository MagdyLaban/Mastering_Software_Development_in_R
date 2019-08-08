#' @description Geom object for drawing timeline
#' @title GeomTimeline
#' @importFrom ggplot2 ggproto
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 draw_key_point
#' @importFrom ggplot2 Geom
#' @importFrom grid circleGrob
#' @importFrom grid segmentsGrob
#' @importFrom grid gList
#' @importFrom grid gpar
#' @export
GeomTimeline <- ggplot2::ggproto("GeomTimeline", ggplot2::Geom,
                                 required_aes = c("x"),
                                 default_aes = ggplot2::aes(y = 0.3, colour = "grey50", size = 1.0,
                                                            alpha = 0.5, shape = 19, fill = NA,
                                                            stroke = 1.0),
                                 draw_key = ggplot2::draw_key_point,
                                 draw_group = function(data, panel_scales, coord) {
                                   coords <- coord$transform(data, panel_scales)
                                   circles <- grid::circleGrob(
                                     x = coords$x,
                                     y = coords$y,
                                     r = (2 ^ coords$size) / 1000,
                                     gp = grid::gpar(
                                       fill = coords$colour,
                                       col = coords$colour,
                                       alpha = coords$alpha
                                     ))
                                   line <- grid::segmentsGrob(x0 = min(coords$x),
                                                              y0 = coords$y,
                                                              x1 = max(coords$x),
                                                              y1 = coords$y,
                                                              gp = grid::gpar(col = "grey", lwd = 1))
                                   grid::gList(circles, line)
                                 }
)

#' @title geom_timeline
#' @description shows a timeline of NOAA Significant earthquakes for an individual country in the y axis and dates in x axis
#' and the size of the points is associated with the earthquakes magnitude and
#' the color is represented the total number of deaths
#' @section Aesthetics :
#'  \itemize{
#'   \item{\code{x}} : the DATE column in the NOAA dataframe .
#'   \item{\code{size}} :  a numeric column which represents Richter scale value .
#'   \item{\code{color}} : a numeric column which represents the number of deaths per country .
#'   \item{\code{fill}} : it may be the number of deaths per country too .
#'   \item{\code{y}} : it is column that represents \code{COUNTRY} name .
#'   \item{\code{alpha}}
#'   \item{\code{shape}}
#' }
#' @param mapping look at Arguments section in  \code{ggplot2::geom_point()}
#' @param data look at Arguments section in  \code{ggplot2::geom_point()}
#' @param stat look at Arguments section in  \code{ggplot2::geom_point()}
#' @param position look at Arguments section in  \code{ggplot2::geom_point()}
#' @param na.rm look at Arguments section in  \code{ggplot2::geom_point()}
#' @param show.legend look at Arguments section in  \code{ggplot2::geom_point()}
#' @param inherit.aes look at Arguments section in  \code{ggplot2::geom_point()}
#' @param ... look at Arguments section in  \code{ggplot2::geom_point()}
#' @examples
#' \dontrun{
#' noaa %>%
#' eq_clean_data() %>%
#' filter(YEAR >= 2000, COUNTRY == "USA") %>%
#' ggplot(aes(x = DATE, size = as.numeric(EQ_PRIMARY), color = as.numeric(TOTAL_DEATHS))) +
#' geom_timeline()
#' }
#' @importFrom ggplot2 layer
#' @export
geom_timeline <- function(mapping = NULL, data = NULL, stat = "identity",
                          position = "identity", na.rm = FALSE, show.legend = NA,
                          inherit.aes = TRUE, ...) {
  ggplot2::layer(
    geom = GeomTimeline, mapping = mapping,  data = data, stat = stat,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}


