#' Azorean civil administrative parishes
#'
#' [parishes()] returns the boundaries of civil parishes in the Azores.
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
#' \item{`id`}{An unique identifier for the parish. Follows the format
#' `[DT][MN][FR]`: DT is a two-digit id for the district, MN for the
#' municipality and FR for the parish (freguesia in Portuguese).}
#' \item{`parish`}{Name of the civil parish.}
#' \item{`municipality`}{Name of municipality.}
#' \item{`district`}{Name of district, coincides with the name of the island.}
#' \item{`area`}{Parish area in hectares (ha).}
#' \item{`perimeter`}{Parish perimeter in kilometers.}
#' }
#'
#' @examples
#' parishes()
#' parishes_25N()
#' parishes_26N()
#'
#' @export
parishes <- function(crs = laea_azores_proj()) {

  parishes_25N_proj <- sf::st_transform(x = parishes_25N(), crs = crs)
  parishes_26N_proj <- sf::st_transform(x = parishes_26N(), crs = crs)

  dplyr::bind_rows(parishes_25N_proj, parishes_26N_proj)
}

#' @description
#' [parishes_25N()] returns the parishes in the meter-based projection PTRA08 /
#' UTM zone 25N, i.e. those parishes in the western-most part of the
#' archipelago: _Ilha das Flores_ and _Ilha do Corvo_.
#'
#' @rdname parishes
#' @export
parishes_25N <- function() {
  parishes_25N_path <- system.file("extdata/parishes_25N.rds", package = pkg_name(), mustWork = TRUE)
  parishes_25N <- readr::read_rds(file = parishes_25N_path)
  parishes_25N
}

#' @description
#' [parishes_26N()] returns the parishes in the meter-based projection PTRA08 /
#' UTM zone 26N, i.e. those parishes in the Central and Eastern groups of the
#' archipelago.
#' @rdname parishes
#' @export
parishes_26N <- function() {
  parishes_26N_path <- system.file("extdata/parishes_26N.rds", package = pkg_name(), mustWork = TRUE)
  parishes_26N <- readr::read_rds(file = parishes_26N_path)
  parishes_26N
}
