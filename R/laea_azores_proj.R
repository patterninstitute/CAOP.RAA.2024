#' Lambert Azimuthal Equal-Area (LAEA) projection centered on the
#' Azores
#'
#' [laea_azores_proj()] creates a PROJ string for a custom Lambert Azimuthal Equal-Area
#' (LAEA) projection, centered on the Azores. It allows flexibility in setting
#' the latitude and longitude center, datum, and units.
#'
#' @param lat_0 Numeric. Latitude of the projection's center. Defaults to `38.5`
#'   (Central Azores).
#' @param lon_0 Numeric. Longitude of the projection's center. Defaults to `-28`
#'   (Central Azores).
#' @param datum Character. The geodetic datum used for the projection. Defaults
#'   to `"WGS84"`. Other options include `"ETRS89"`, `"NAD83"`, etc.
#' @param units Character. Measurement units for the projection. Defaults to
#'   `"m"` (meters). Can be set to `"ft"` (feet) if needed.
#'
#' @return A character string representing the PROJ definition for the custom
#'   LAEA projection.
#'
#' @examples
#' # Default Azores-centered LAEA projection
#' laea_azores_proj()
#'
#' # Custom projection centered at a different location
#' laea_azores_proj(lat_0 = 38, lon_0 = -27, datum = "ETRS89")
#'
#' @export
laea_azores_proj <- function(lat_0 = 38.5, lon_0 = -28, datum = "WGS84", units = "m") {
  glue::glue("+proj=laea +lat_0={lat_0} +lon_0={lon_0} +datum={datum} +units={units} +no_defs")
}
