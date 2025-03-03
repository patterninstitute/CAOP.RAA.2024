#' Azorean municipalities
#'
#' [municipalities()] returns the boundaries of municipalities in the Azores in
#' WGS84 (EPSG: 4326) for latitude and longitude coordinates.
#'
#' @returns A simple features ([sf][sf::sf]) object with six fields:
#'
#' \describe{
#' \item{`id`}{An unique identifier for the municipality. Follows the format
#' `[DT][MN]`: DT is a two-digit id for the district and MN for the
#' municipality.}
#' \item{`municipality`}{Name of municipality.}
#' \item{`district`}{Name of district, coincides with the name of the island.}
#' \item{`area`}{Municipality area in hectares (ha).}
#' \item{`perimeter`}{Municipality perimeter in kilometers.}
#' \item{`n_parishes`}{Number of parishes in municipality.}
#' }
#'
#' @examples
#' municipalities()
#' municipalities_25N()
#' municipalities_26N()
#'
#' @export
municipalities <- function() {
  municipalities_25N_wgs84 <- sf::st_transform(x = municipalities_25N(), crs = 4326)
  municipalities_26N_wgs84 <- sf::st_transform(x = municipalities_26N(), crs = 4326)

  dplyr::bind_rows(municipalities_25N_wgs84, municipalities_26N_wgs84)
}

#' @description
#' [municipalities_25N()] returns the municipalities in the meter-based
#' projection PTRA08 / UTM zone 25N, i.e. those municipalities in the
#' western-most part of the archipelago: _Ilha das Flores_ and _Ilha do Corvo_.
#'
#' @rdname municipalities
#' @export
municipalities_25N <- function() {
  municipalities_25N_path <- system.file("extdata/municipalities_25N.rds", package = pkg_name(), mustWork = TRUE)
  municipalities_25N <- readr::read_rds(file = municipalities_25N_path)
  municipalities_25N
}

#' @description
#' [municipalities_26N()] returns the municipalities in the meter-based
#' projection PTRA08 / UTM zone 26N, i.e. those municipalities in the Central
#' and Eastern groups of the archipelago.
#' @rdname municipalities
#' @export
municipalities_26N <- function() {
  municipalities_26N_path <- system.file("extdata/municipalities_26N.rds", package = pkg_name(), mustWork = TRUE)
  municipalities_26N <- readr::read_rds(file = municipalities_26N_path)
  municipalities_26N
}
