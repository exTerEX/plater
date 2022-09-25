library(dplyr, quietly = TRUE)

#' Function to combine data with setup info
#'
#' @param setup A file with identification of what is in each well
#' @param data A file with data from each well
#'
#' @return A dataframe with combined data from setup and input
#' @export
combine_setup_data <- function(setup, data) {
    df <- dplyr::inner_join(data, setup, by = c("n", "well", "row", "col")) %>%
        dplyr::rename(setup = value.y, data = value.x) %>%
        dplyr::select(n, row, col, well, setup, data)

    return(df)
}
