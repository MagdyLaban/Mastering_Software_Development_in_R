context("Columns Data types checking")

test_that("Path Constructing and Data Types testing", {
    file_path <- system.file("extdata", "signif.txt", package = "msdr")
    NOAA <- read_delim(file_path, delim = "\t") %>%
        eq_clean_data() %>%
        eq_location_clean()

    expect_is(NOAA$DATE, class = 'Date')
    expect_is(NOAA$LOCATION, class = 'character')
})
