#' Azorean islands
#'
#' A brief dataset of the nine Azorean islands.
#'
#' @returns A [tibble][tibble::tibble] with columns:
#'
#' \describe{
#' \item{`group`}{Island group.}
#' \item{`is_triangle`}{Due to their proximity, Pico, Faial and São Jorge form
#' the so-called _Triangle_ of the Central Group of islands.}
#' \item{`name`}{Island's name.}
#' }
#'
#' @examples
#' islands()
#'
#' @export
islands <- function() {
  tibble::tribble(
    ~group, ~is_triangle, ~ name,
    "Eastern", FALSE, "Ilha de Santa Maria",
    "Eastern", FALSE, u("Ilha de S\\u00e3o Miguel"),

    "Central", TRUE, "Ilha do Pico",
    "Central", TRUE, "Ilha do Faial",
    "Central", TRUE, u("Ilha de S\\u00e3o Jorge"),
    "Central", FALSE,"Ilha Terceira",
    "Central", FALSE, "Ilha Graciosa",

    "Western", FALSE, "Ilha das Flores",
    "Western", FALSE, "Ilha do Corvo"
  )
}


