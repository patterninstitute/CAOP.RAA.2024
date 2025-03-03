#' Azorean NUTS
#'
#' [nuts()] returns the boundaries of the Nomenclature of Territorial Units for
#' Statistics (NUTS).
#'
#' @param crs Coordinate reference system (CRS) passed on to
#'   [st_transform()][sf::st_transform]. Defaults to a custom CRS centered on
#'   the Azores, see [laea_azores_proj()] for more details. Other possible
#'   options are `"EPSG: 3035"` for ETRS89-extended / LAEA Europe or
#'   `"EPSG:4326"` for WGS 84.
#'
#' @returns A simple features ([sf][sf::sf]) object with seven fields:
#'
#' \describe{
#' \item{`nuts_code`}{NUTS code.}
#' \item{`nuts_level`}{NUTS level.}
#' \item{`nuts_name`}{NUTS name.}
#' \item{`area`}{NUTS area in hectares (ha).}
#' \item{`perimeter`}{NUTS perimeter in kilometers.}
#' \item{`n_municipalities`}{Number of municipalities in the NUTS.}
#' \item{`n_parishes`}{Number of parishes in the NUTS.}
#' }
#'
#' @examples
#' nuts()
#' nuts_25N()
#' nuts_26N()
#'
#' @export
nuts <- function(crs = laea_azores_proj()) {

  nuts_25N_wgs84 <- sf::st_transform(x = nuts_25N(), crs = crs)
  nuts_26N_wgs84 <- sf::st_transform(x = nuts_26N(), crs = crs)

  dplyr::bind_rows(nuts_25N_wgs84, nuts_26N_wgs84)
}

#' @description
#' [nuts_25N()] returns the NUTS boundaries in the meter-based projection PTRA08
#' / UTM zone 25N, i.e. the NUTS area in the western-most part of the
#' archipelago: _Ilha das Flores_ and _Ilha do Corvo_.
#'
#' @rdname nuts
#' @export
nuts_25N <- function() {
  nuts_25N_path <- system.file("extdata/nuts_25N.rds", package = pkg_name(), mustWork = TRUE)
  nuts_25N <- readr::read_rds(file = nuts_25N_path)
  nuts_25N
}

#' @description
#' [nuts_26N()] returns the NUTS boundaries in the meter-based projection PTRA08
#' / UTM zone 26N, i.e. the NUTS area in the Central and Eastern groups of
#' the archipelago.
#'
#' @rdname nuts
#' @export
nuts_26N <- function() {
  nuts_26N_path <- system.file("extdata/nuts_26N.rds", package = pkg_name(), mustWork = TRUE)
  nuts_26N <- readr::read_rds(file = nuts_26N_path)
  nuts_26N
}
