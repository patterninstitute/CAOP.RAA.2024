#' Azorean boundary segments
#'
#' [boundary_segments()] returns the boundary segments that separate
#' administrative entities or borders with the Atlantic Ocean in the Azores in
#' WGS84 (EPSG: 4326) for latitude and longitude coordinates.
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
boundary_segments <- function() {
  boundary_segments_25N_wgs84 <- sf::st_transform(x = boundary_segments_25N(), crs = 4326)
  boundary_segments_26N_wgs84 <- sf::st_transform(x = boundary_segments_26N(), crs = 4326)

  dplyr::bind_rows(boundary_segments_25N_wgs84, boundary_segments_26N_wgs84)
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
