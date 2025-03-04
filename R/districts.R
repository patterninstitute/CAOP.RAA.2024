#' Azorean districts
#'
#' [districts()] returns the boundaries of districts (islands) in the Azores.
#'
#' @param crs Coordinate reference system (CRS) passed on to
#'   [st_transform()][sf::st_transform]. Defaults to a custom CRS centered on
#'   the Azores, see [laea_azores_proj()] for more details. Other possible
#'   options are `"EPSG: 3035"` for ETRS89-extended / LAEA Europe or
#'   `"EPSG:4326"` for WGS 84.
#'
#' @returns A simple features ([sf][sf::sf]) object with six fields:
#'
#' \describe{
#' \item{`id`}{An unique identifier for the district. Follows the format
#' `[DT][MN][FR]`: DT is a two-digit id for the district, MN for the
#' municipality and FR for the district (freguesia in Portuguese).}
#' \item{`district`}{Name of the civil district.}
#' \item{`municipality`}{Name of municipality.}
#' \item{`district`}{Name of district, coincides with the name of the island.}
#' \item{`area`}{District area in hectares (ha).}
#' \item{`perimeter`}{District perimeter in kilometers.}
#' \item{`n_municipalities`}{Number of municipalities in the district.}
#' \item{`n_parishes`}{Number of parishes in the district.}
#' }
#'
#' @examples
#' districts()
#' districts_25N()
#' districts_26N()
#'
#' @export
districts <- function(crs = laea_azores_proj()) {

  districts_25N_proj <- sf::st_transform(x = districts_25N(), crs = crs)
  districts_26N_proj <- sf::st_transform(x = districts_26N(), crs = crs)

  dplyr::bind_rows(districts_25N_proj, districts_26N_proj)
}

#' @description
#' [districts_25N()] returns the districts in the meter-based projection PTRA08
#' / UTM zone 25N, i.e. those districts in the western-most part of the
#' archipelago: _Ilha das Flores_ and _Ilha do Corvo_.
#'
#' @rdname districts
#' @export
districts_25N <- function() {
  districts_25N_path <- system.file("extdata/districts_25N.rds", package = pkg_name(), mustWork = TRUE)
  districts_25N <- readr::read_rds(file = districts_25N_path)
  districts_25N
}

#' @description
#' [districts_26N()] returns the districts in the meter-based projection PTRA08
#' / UTM zone 26N, i.e. those districts in the Central and Eastern groups of
#' the archipelago.
#'
#' @rdname districts
#' @export
districts_26N <- function() {
  districts_26N_path <- system.file("extdata/districts_26N.rds", package = pkg_name(), mustWork = TRUE)
  districts_26N <- readr::read_rds(file = districts_26N_path)
  districts_26N
}
