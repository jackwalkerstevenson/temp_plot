# load required libraries
library(tidyverse)
library(scales) # for axis breaks
library(viridis) # for coloring
library(ggprism) # for pretty theme
# import data-----------------------------------------------
source("R/import.R")
input_file_path <- "input/temp_combined.TXT"
data <- import_temp(input_file_path)
# helper timestamp function-----------------------------------------------
get_timestamp <- function(){format(Sys.time(), "%Y-%m-%dT%H%M%S")}
# plot-----------------------------------------------
data |>
  # filter(datetime > ymd_h("2023-07-12 00")) |>
  group_by(channel) |> 
  ggplot(aes(x = datetime, y = temp_celsius, color = channel)) +
  geom_point(size = 1) +
  geom_line() +
  scale_x_datetime(breaks = breaks_width ("12 hours"),
                   minor_breaks = breaks_width("1 hour"),
                   date_labels = "%m-%d %H",
                   guide = guide_prism_minor(),
                   expand = expansion(mult = c(0, 0.05))) +
  scale_y_continuous(breaks = breaks_width(5), # 10-degree axis ticks
                     minor_breaks = breaks_width(1),
                     sec.axis = dup_axis()) + 
  scale_color_viridis(option = "turbo", discrete = TRUE,
                      begin = 0.9, end = 0.1) +
  theme_prism() +
  # set grid lines
  theme(panel.grid = element_line(color = "black", linewidth = 0.5),
        panel.grid.minor = element_line(color = "black",
                                        linewidth = 0.1,
                                        linetype = "dotted"),
        legend.title = element_text()) + # restore legend title
  labs(x = "time", y = "temperature (C)")
ggsave(str_glue("temp_plot_{get_timestamp()}.pdf"),
       width = 14, height = 6)
