library(tidyr, quietly = TRUE)
library(dplyr, quietly = TRUE)
library(readr, quietly = TRUE)
library(readxl, quietly = TRUE)

#' Function convert plate format into machine readable table
#'
#' @param df Dataframe in plate format (see below for csv-like example)
#'
#' plate, 1, 2, 3, 4, ...
#' A, ...
#' B, ...
#' C, ...
#' ..., ...
#'
#' @param cols String with name of plate in top-left corner of plate (like
#'             "plate" in csv-like example above)
#'
#' @param n Integer to identify plate (i.e. 1, 2, 3...)
#'
#' @return Dataframe with microtiter plate content
#' @export
read_plate <- function(df, cols = "plate", n = 1) {
    data <- df %>%
        tidyr::pivot_longer(-cols, names_to = "well", values_to = "value") %>%
        dplyr::mutate(
            n = n,
            row = match(get(cols), LETTERS),
            col = as.integer(well),
            well = paste(get(cols), well, sep = "")
        ) %>%
        dplyr::select(n, well, row, col, value)

    return(data)
}

#' Function convert plate format into machine readable table
#'
#' @param fp File path to csv file with plate data
#' @param cols String with name of plate in top-left corner of plate (like
#'             "plate" in csv-like example above)
#' @param  n Integer to identify plate (i.e. 1, 2, 3...)
#'
#' @return Dataframe with microtiter plate content
#' @export
read_plate_csv <- function(fp, cols = "plate", n = 1) {
    data <- readr::read_delim(fp, delim = ",") %>%
        read_plate(., cols, n)

    return(data)
}

#' Function convert plate format into machine readable table
#'
#' @param fp File path to tsv file with plate data
#' @param cols String with name of plate in top-left corner of plate (like
#'             "plate" in csv-like example above)
#' @param  n Integer to identify plate (i.e. 1, 2, 3...)
#'
#' @return Dataframe with microtiter plate content
#' @export
read_plate_tsv <- function(fp, cols = "plate", n = 1) {
    data <- readr::read_delim(fp, delim = "\t") %>%
        read_plate(., cols, n)

    return(data)
}

#' Function convert plate format into machine readable table
#'
#' @param fp File path to xlsx file with plate data
#' @param sheet Worksheet number (1, 2, 3, 4, ...) in excel worksbook
#' @param cols String with name of plate in top-left corner of plate (like
#'             "plate" in csv-like example above)
#' @param  n Integer to identify plate (i.e. 1, 2, 3...)
#'
#' @return Dataframe with microtiter plate content
#' @export
read_plate_xlsx <- function(fp, sheet, cols = "plate", n = 1) {
    data <- read_excel(fp, sheet = sheet) %>%
        read_plate(., cols, n)

    return(data)
}
