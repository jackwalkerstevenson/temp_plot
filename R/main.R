# load required libraries
library(tidyverse)
library(scales)
library(viridis)
library(ggprism)
# import data-----------------------------------------------
source("R/import.R")
input_file_path <- "input/07081226.TXT"
data <- import_temp(input_file_path)
# plot-----------------------------------------------
data |>
  group_by(channel) |> 
ggplot(aes(x = datetime, y = fahrenheit, color = channel)) +
  geom_point(size = 1) +
  geom_line() +
  scale_x_datetime(minor_breaks = breaks_width("1 hour"),
                   date_labels = "%Y-%m-%d %H:%M",
                   guide = guide_prism_minor())+
                   # expand = expansion(mult = c(0, 0.05))) +
  scale_y_continuous(breaks = breaks_width(10)) +
  scale_color_viridis(option = "turbo", discrete = TRUE,
                      begin = 0.9, end = 0.1) +
  theme_prism() +
  theme(panel.grid = element_line(color = "black", linewidth = 0.5),
        panel.grid.minor = element_line(color = "black",
                                        linewidth = 0.1,
                                        linetype = "dotted"),
        legend.title = element_text()) +
  labs(x = "time", y = "temperature (F)")
