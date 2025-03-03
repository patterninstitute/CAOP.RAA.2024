library(tidyverse)
library(sf)

gpks_files <- list.files(path = "data-raw", pattern = "*.gpkg$", full.names = TRUE)

col_rename <- function(x) {
  dplyr::case_match(
    x,
    "dtmnfr" ~ "id",
    "dtmn" ~ "id",
    "dt" ~ "id",
    "freguesia" ~ "parish",
    "tipo_area_administrativa" ~ "type",
    "distrito" ~ "district",
    "municipio" ~ "municipality",
    "distrito_ilha" ~ "district",
    "area_ha" ~ "area",
    "perimetro_km" ~ "perimeter",
    "n_freguesias" ~ "n_parishes",
    "n_municipios" ~ "n_municipalities",
    "codigo" ~ "nuts_code",
    "identificador" ~ "id",
    "ea_direita" ~ "id_at_right",
    "ea_esquerda" ~ "id_at_left",
    "paises" ~ "countries",
    "estado_limite_admin" ~ "is_confirmed",
    "significado_linha" ~ "boundary_type",
    "nivel_limite_admin" ~ "boundary_level",
    "comprimento_km" ~ "length",
    "geom" ~ "geometry",
    .default = x
  )
}

type_recode <- function(dat) {
  dat |>
    dplyr::mutate(
      type = dplyr::case_match(
        .data$type,
        "Área Principal" ~ "primary",
        "Área Secundária" ~ "secondary"
      )
    )
}

boundary_type_recode <- function(dat) {
  dat |>
    dplyr::mutate(
      boundary_type = dplyr::case_match(
        .data$boundary_type,
        "Limite em Terra" ~ "land",
        "Limite e Linha de Costa" ~ "coast"
      )
    )
}

is_confirmed_recode <- function(dat) {
  dat |>
    dplyr::mutate(
      is_confirmed = dplyr::case_match(
        .data$is_confirmed,
        "Não Confirmado" ~ FALSE,
        "Definido" ~ TRUE
      )
    )
}

boundary_level_recode <- function(dat) {
  dat |>
    dplyr::mutate(boundary_level = as.integer(stringr::str_extract(.data$boundary_level, "^\\d{1}")))
}

drop_cols <- function(dat) {
  dat |>
    dplyr::select(-dplyr::any_of(
      c("id", "nuts1", "nuts2", "nuts3", "designacao_simplificada", "paises")
    ))
}

regions_26N <- sf::st_read(gpks_files[1], layer = "raa_cen_ori_areas_administrativas") |>
  drop_cols() |>
  dplyr::rename_with(.fn = col_rename) |>
  type_recode()

regions_25N <- sf::st_read(gpks_files[2], layer = "raa_oci_areas_administrativas") |>
  drop_cols() |>
  dplyr::rename_with(.fn = col_rename) |>
  type_recode() |>
  drop_cols()

#
# Parishes
#
parishes_26N <- sf::st_read(gpks_files[1], layer = "raa_cen_ori_freguesias") |>
  drop_cols() |>
  dplyr::rename_with(.fn = col_rename)

parishes_25N <- sf::st_read(gpks_files[2], layer = "raa_oci_freguesias") |>
  drop_cols() |>
  dplyr::rename_with(.fn = col_rename)

#
# Municipalities
#
municipalities_26N <- sf::st_read(gpks_files[1], layer = "raa_cen_ori_municipios") |>
  drop_cols() |>
  dplyr::rename_with(.fn = col_rename)

municipalities_25N <- sf::st_read(gpks_files[2], layer = "raa_oci_municipios") |>
  drop_cols() |>
  dplyr::rename_with(.fn = col_rename)

#
# Districts
#
districts_26N <- sf::st_read(gpks_files[1], layer = "raa_cen_ori_distritos") |>
  drop_cols() |>
  dplyr::rename_with(.fn = col_rename)


districts_25N <- sf::st_read(gpks_files[2], layer = "raa_oci_distritos") |>
  drop_cols() |>
  dplyr::rename_with(.fn = col_rename)


#
# NUTS
#
nuts1_26N <- sf::st_read(gpks_files[1], layer = "raa_cen_ori_nuts1")
nuts2_26N <- sf::st_read(gpks_files[1], layer = "raa_cen_ori_nuts2")
nuts3_26N <- sf::st_read(gpks_files[1], layer = "raa_cen_ori_nuts3")

nuts_26N <- dplyr::bind_rows(nuts1_26N, nuts2_26N, nuts3_26N) |>
  dplyr::rename_with(.fn = col_rename) |>
  drop_cols() |>
  tibble::add_column(nuts_level = c("I", "II", "III"),
                     nuts_name = "Região Autónoma dos Açores",
                     .after = "nuts_code")

nuts1_25N <- sf::st_read(gpks_files[2], layer = "raa_oci_nuts1")
nuts2_25N <- sf::st_read(gpks_files[2], layer = "raa_oci_nuts2")
nuts3_25N <- sf::st_read(gpks_files[2], layer = "raa_oci_nuts3")

nuts_25N <- dplyr::bind_rows(nuts1_25N, nuts2_25N, nuts3_25N) |>
  dplyr::rename_with(.fn = col_rename) |>
  drop_cols() |>
  tibble::add_column(nuts_level = c("I", "II", "III"),
                     nuts_name = "Região Autónoma dos Açores",
                     .after = "nuts_code")

#
# Boundary segments
#
boundary_segments_26N <-
  sf::st_read(gpks_files[1], layer = "raa_cen_ori_trocos") |>
  drop_cols() |>
  dplyr::rename_with(.fn = col_rename) |>
  boundary_type_recode() |>
  is_confirmed_recode() |>
  boundary_level_recode()

boundary_segments_25N <-
  sf::st_read(gpks_files[2], layer = "raa_oci_trocos") |>
  drop_cols() |>
  dplyr::rename_with(.fn = col_rename) |>
  boundary_type_recode() |>
  is_confirmed_recode() |>
  boundary_level_recode()

#
# Export
#
readr::write_rds(x = parishes_26N, file = "inst/extdata/parishes_26N.rds", compress = "xz")
readr::write_rds(x = parishes_25N, file = "inst/extdata/parishes_25N.rds", compress = "xz")

readr::write_rds(x = municipalities_26N, file = "inst/extdata/municipalities_26N.rds", compress = "xz")
readr::write_rds(x = municipalities_25N, file = "inst/extdata/municipalities_25N.rds", compress = "xz")

readr::write_rds(x = districts_26N, file = "inst/extdata/districts_26N.rds", compress = "xz")
readr::write_rds(x = districts_25N, file = "inst/extdata/districts_25N.rds", compress = "xz")

readr::write_rds(x = boundary_segments_26N, file = "inst/extdata/boundary_segments_26N.rds", compress = "xz")
readr::write_rds(x = boundary_segments_25N, file = "inst/extdata/boundary_segments_25N.rds", compress = "xz")

readr::write_rds(x = nuts_26N, file = "inst/extdata/nuts_26N.rds", compress = "xz")
readr::write_rds(x = nuts_25N, file = "inst/extdata/nuts_25N.rds", compress = "xz")
