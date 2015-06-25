#' Add heatmap of 2d bin counts.
#'
#' @section Aesthetics:
#' \Sexpr[results=rd,stage=build]{ggplot2:::rd_aesthetics("geom", "bin2d")}
#'
#' @export
#' @inheritParams geom_point
#' @examples
#' d <- ggplot(diamonds, aes(x = x, y = y)) + xlim(4,10) + ylim(4,10)
#' d + geom_bin2d()
#' d + geom_bin2d(binwidth = c(0.1, 0.1))
#'
#' # See ?stat_bin2d for more examples
geom_bin2d <- function (mapping = NULL, data = NULL, stat = "bin2d", position = "identity",
  show_guide = NA, ...)
{
  LayerR6$new(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomBin2d,
    position = position,
    show_guide = show_guide,
    params = list(...)
  )
}

GeomBin2d <- R6::R6Class("GeomBin2d", inherit = GeomR6,
  public = list(
    draw = function(data, scales, coordinates, ...) {

      # R6 TODO: Avoid instantiation
      GeomRect$new()$draw(data, scales, coordinates, ...)
    },

    objname = "bin2d",

    guide_geom = function() "polygon",

    default_stat = function() StatBin2d,

    required_aes = c("xmin", "xmax", "ymin", "ymax"),

    default_aes = function() {
      aes(colour = NA, fill = "grey60", size = 0.5, linetype = 1, weight = 1, , alpha = NA)
    }
  )
)
