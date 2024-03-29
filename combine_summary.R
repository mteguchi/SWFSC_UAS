# Combines all summary files
# This script can be used to combine all daily summary files into one. 
# readGPX_with laser v2 batch.R or run_readGPX_v3.R (preferred) should 
# be used to create daily summary files.
# 

# Tomo Eguchi
# 2021-08-05

rm(list=ls())
library(tidyverse)

#data.dir <- "data/Leatherback_2021/"
#data.dir <- "data/Leatherback_HMB_2022/"
data.dir <- "data/Piedras Blancas"
#data.dir <- "data/Jamul training/20230418_APH28R"

idx.slash.max <- str_locate_all(pattern = "/", data.dir) %>% unlist() %>% max()

if (idx.slash.max < str_length(data.dir)){
  data.dir <- paste0(data.dir, "/")
}

# find all directories within the project folder
dirs <- list.dirs(path = data.dir)

summary.dirs <- dirs[grep(pattern = "/summary",
                          dirs)]

k <- 1
cols <- readr::cols(ID = col_character(),
                    Start_GMT = col_datetime(format = "%Y-%m-%d %H:%M:%S"),
                    End_GMT = col_datetime(format = "%Y-%m-%d %H:%M:%S"),
                    Start_Lat = col_double(),
                    Start_Long = col_double(),
                    Duration_s = col_double(),
                    Max_elevation_m = col_double(),
                    Max_distance_m = col_double(),
                    Total_distance_m = col_double(),
                    Max_vel_ms = col_double(),
                    Mean_vel_ms = col_double())

summary.file <- list() 
for (k in 1:length(summary.dirs)){
  fname <- list.files(path = summary.dirs[k], pattern = "SUMMARY.csv")
  summary.file[[k]] <- readr::read_csv(paste0(summary.dirs[k], "/", fname),
                                     col_types = cols)
      
}

summary.data <- bind_rows(summary.file) %>% mutate(Duration_m = Duration_s/60)

readr::write_csv(summary.data, file = paste0(data.dir, "flight_summary.csv"))
