% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/laea_azores_proj.R
\name{laea_azores_proj}
\alias{laea_azores_proj}
\title{Lambert Azimuthal Equal-Area (LAEA) projection centered on the
Azores}
\usage{
laea_azores_proj(lat_0 = 38.5, lon_0 = -28, datum = "WGS84", units = "m")
}
\arguments{
\item{lat_0}{Numeric. Latitude of the projection's center. Defaults to \code{38.5}
(Central Azores).}

\item{lon_0}{Numeric. Longitude of the projection's center. Defaults to \code{-28}
(Central Azores).}

\item{datum}{Character. The geodetic datum used for the projection. Defaults
to \code{"WGS84"}. Other options include \code{"ETRS89"}, \code{"NAD83"}, etc.}

\item{units}{Character. Measurement units for the projection. Defaults to
\code{"m"} (meters). Can be set to \code{"ft"} (feet) if needed.}
}
\value{
A character string representing the PROJ definition for the custom
LAEA projection.
}
\description{
\code{\link[=laea_azores_proj]{laea_azores_proj()}} creates a PROJ string for a custom Lambert Azimuthal Equal-Area
(LAEA) projection, centered on the Azores. It allows flexibility in setting
the latitude and longitude center, datum, and units.
}
\examples{
# Default Azores-centered LAEA projection
laea_azores_proj()

# Custom projection centered at a different location
laea_azores_proj(lat_0 = 38, lon_0 = -27, datum = "ETRS89")

}
