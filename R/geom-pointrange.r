#' An interval represented by a vertical line, with a point in the middle.
#'
#' @section Aesthetics:
#' \Sexpr[results=rd,stage=build]{ggplot2:::rd_aesthetics("geom", "pointrange")}
#'
#' @inheritParams geom_point
#' @seealso
#'  \code{\link{geom_errorbar}} for error bars,
#'  \code{\link{geom_linerange}} for range indicated by straight line, + examples,
#'  \code{\link{geom_crossbar}} for hollow bar with middle indicated by horizontal line,
#'  \code{\link{stat_summary}} for examples of these guys in use,
#'  \code{\link{geom_smooth}} for continuous analog"
#' @export
#' @examples
#' # See geom_linerange for examples
geom_pointrange <- function (mapping = NULL, data = NULL, stat = "identity",
  position = "identity", show_guide = NA, inherit.aes = TRUE, ...)
{
  LayerR6$new(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomPointrange,
    position = position,
    show_guide = show_guide,
    inherit.aes = inherit.aes,
    params = list(...)
  )
}

GeomPointrange <- R6::R6Class("GeomPointrange", inherit = GeomR6,
  public = list(
    objname = "pointrange",

    default_stat = function() StatIdentity,

    default_aes = function() {
      aes(colour = "black", size = 0.5, linetype = 1, shape = 19,
          fill = NA, alpha = NA, stroke = 1)
    },

    guide_geom = function() "pointrange",

    required_aes = c("x", "y", "ymin", "ymax"),

    draw = function(data, scales, coordinates, ...) {
      # R6 TODO: Avoid instantiation
      if (is.null(data$y)) return(GeomLinerange$new()$draw(data, scales, coordinates, ...))

      ggname(self$my_name(),
        gTree(children=gList(
          GeomLinerange$new()$draw(data, scales, coordinates, ...),
          GeomPoint$new()$draw(transform(data, size = size * 4), scales, coordinates, ...)
        ))
      )
    },

    draw_legend = function(data, ...) {
      data <- aesdefaults(data, self$default_aes(), list(...))

      grobTree(
        # R6 TODO: Avoid instantiation
        GeomPath$new()$draw_legend(data, ...),
        GeomPoint$new()$draw_legend(transform(data, size = size * 4), ...)
      )
    }
  )
)
