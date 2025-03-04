#' Compute the Exclusive Economic Zone (EEZ) for the Azores
#'
#' This function calculates the Exclusive Economic Zone (EEZ) boundary for
#' the Azores by buffering each island by a specified distance (default 200
#' nautical miles) and merging the resulting buffers to create a single EEZ
#' polygon.
#'
#' @param crs Character or CRS object. The target coordinate reference system
#'   (CRS) for the EEZ output. Defaults to `laea_azores_proj()` (a custom
#'   Lambert Azimuthal Equal-Area projection centered on the Azores).
#'
#' @param distance Numeric. The buffer distance in nautical miles (NM) around
#'   each island. Defaults to `200` (200 NM, the standard EEZ definition). If
#'   another value is provided, it will be converted to meters.
#'
#' @return An `sf` object representing the EEZ as a single POLYGON.
#'
#' @details
#' The EEZ is defined as the area **200 nautical miles from the nearest baseline of each
#' island**. This function:
#' - Buffers each island by `distance × 1,852` meters (default: **370,400 meters**).
#' - Merges overlapping buffers into a single EEZ boundary.
#' - Transforms the final EEZ to the specified `crs`.
#'
#' @examples
#' library(ggplot2)
#' ggplot() +
#' geom_sf(data = eez(), fill = NA, linewidth = 1, col = "gray") +
#'  geom_sf(data = districts(), mapping = aes(fill = district), col = "white") +
#'  guides(fill = "none")
#'
#' @export
eez <- function(crs = laea_azores_proj(), distance = 200) {

  # If `distance` is 200 nautical miles, then buffer_distance is
  distance_meters <- distance * 1852  # 370,400 meters
  islands <- districts()
  eez_buffers <- sf::st_buffer(islands, dist = distance_meters)
  eez <- sf::st_union(eez_buffers)

  sf::st_transform(x = eez, crs = crs)

  eez
}
