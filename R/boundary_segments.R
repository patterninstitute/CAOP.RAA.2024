#' Azorean boundary segments
#'
#' [boundary_segments()] returns the boundary segments that separate
#' administrative entities or borders with the Atlantic Ocean in the Azores.
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
#' \item{`id`}{An unique UUID identifier for the segment.}
#' \item{`id_at_right`}{Identifier for the entity at the right side of the boundary.}
#' \item{`id_at_left`}{Identifier for the entity at the left side of the boundary.}
#' \item{`is_confirmed`}{Boundary segment whose acceptance by the parties has
#' not yet been officially communicated.}
#' \item{`boundary_type`}{Boundary type: land or coast.}
#' \item{`boundary_level`}{Boundary level: administrative level.}
#' \item{`length`}{Boundary segment length in kilometers.}
#' }
#'
#' @examples
#' boundary_segments()
#' boundary_segments_25N()
#' boundary_segments_26N()
#'
#' @export
boundary_segments <- function(crs = laea_azores_proj()) {

  boundary_segments_25N_proj <- sf::st_transform(x = boundary_segments_25N(), crs = crs)
  boundary_segments_26N_proj <- sf::st_transform(x = boundary_segments_26N(), crs = crs)

  dplyr::bind_rows(boundary_segments_25N_proj, boundary_segments_26N_proj)
}

#' @description
#' [boundary_segments_25N()] returns the boundary segments in the meter-based projection PTRA08
#' / UTM zone 25N, i.e. those boundary segments in the western-most part of the
#' archipelago: _Ilha das Flores_ and _Ilha do Corvo_.
#'
#' @rdname boundary_segments
#' @export
boundary_segments_25N <- function() {
  boundary_segments_25N_path <- system.file("extdata/boundary_segments_25N.rds", package = pkg_name(), mustWork = TRUE)
  boundary_segments_25N <- readr::read_rds(file = boundary_segments_25N_path)
  boundary_segments_25N
}

#' @description
#' [boundary_segments_26N()] returns the boundary segments in the meter-based projection PTRA08
#' / UTM zone 26N, i.e. those boundary segments in the Central and Eastern groups of
#' the archipelago.
#'
#' @rdname boundary_segments
#' @export
boundary_segments_26N <- function() {
  boundary_segments_26N_path <- system.file("extdata/boundary_segments_26N.rds", package = pkg_name(), mustWork = TRUE)
  boundary_segments_26N <- readr::read_rds(file = boundary_segments_26N_path)
  boundary_segments_26N
}
