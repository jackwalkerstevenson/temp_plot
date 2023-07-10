# key for channel names-----------------------------------------------
channel_names <- c(
  "1ch" = "compressor pipe",
  "2ch" = "ambient air",
  "3ch" = "water block",
  "4ch" = "freezer air"
)
# import function-----------------------------------------------
import_temp <- function(input_file_path){
  readr::read_table(input_file_path) |>
    mutate(datetime = lubridate::as_date(date) + lubridate::hms(time)) |> 
    pivot_longer(cols = c("1ch", "2ch", "3ch", "4ch"), names_to = "channel") |> 
    mutate(channel = channel_names[channel],
           fahrenheit = value * 1.8 + 32)
}