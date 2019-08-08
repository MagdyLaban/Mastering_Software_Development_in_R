#' @description Geom object for drawing timeline labels
#' @title GeomTimelineLabel
#' @importFrom ggplot2 ggproto
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 draw_key_polygon
#' @importFrom ggplot2 Geom
#' @importFrom grid textGrob
#' @importFrom grid polylineGrob
#' @importFrom grid unit
#' @importFrom grid gList
#' @importFrom grid gpar
#' @export
GeomTimelineLabel <- ggplot2::ggproto("GeomTimeline",
                                      ggplot2::Geom,
                                      required_aes = c("x","label"),
                                      default_aes = ggplot2::aes(y = 0.3,size = 1.0,
                                                                 colour = "grey",stroke = 1.0),
                                      draw_key = ggplot2::draw_key_polygon,
                                      draw_panel = function(data, panel_scales, coord){
                                        coords <- coord$transform(data,panel_scales)
                                        locations <- grid::textGrob(
                                          label = coords$label,
                                          x = grid::unit(coords$x, "npc"),
                                          y = grid::unit(coords$y + 0.05, "npc"),
                                          just = c("left", "bottom"),
                                          gp = grid::gpar(fontsize = 14, col = 'black'),
                                          rot = 45
                                        )
                                        lines <- grid::polylineGrob(
                                          x = grid::unit(c(coords$x, coords$x), "npc"),
                                          y = grid::unit(c(coords$y, coords$y + 0.05), "npc"),
                                          id = rep(1:length(coords$x),2),
                                          gp = grid::gpar(col = "grey50"))

                                      grid::gList(locations, lines)
                                       }
)

#' @title geom_timeline_label
#' @description Adds labels for the locations of individual earthquaks
#' @section Aesthetics :
#' \itemize{
#'   \item{\code{x}} : the \code{DATE} of the earthquake .
#'   \item{\code{label}} :  a character column which represents the location of individual earthquaks .  .
#'   \item{\code{color}} : a numeric column which represents the number of deaths per country .
#'   \item{\code{fill}} : it may be the number of deaths per country too .
#'   \item{\code{size}} : the magnitude of the earthquake measured on the Richter scale
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
#' eq_data <- noaa %>%
#'  eq_clean_data() %>%
#'  eq_location_clean() %>%
#'  filter(YEAR >= 2000, COUNTRY == "USA") %>%
#'  ggplot(aes(x = DATE, size = as.numeric(EQ_PRIMARY),
#'  color = as.numeric(TOTAL_DEATHS), label = LOCATION)) +
#'  geom_timeline() +
#'  geom_timeline_label()
#' }
#' @importFrom ggplot2 layer
#' @export
geom_timeline_label <- function(mapping = NULL, data = NULL, stat = "identity",
                                position = "identity", na.rm = FALSE,
                                show.legend = NA, inherit.aes = TRUE, ...) {
  ggplot2::layer(
    geom = GeomTimelineLabel, mapping = mapping,
    data = data, stat = stat, position = position,
    show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}


