# run_readGPX_v3.R
# Runs readGPX_with laser v3 batch.R on all subdirectories in one root directory

# To use this script, place this script and readGPS_with_laser_fcn.R into a same
# directory. Enter a relative or full path to the directory that contains log
# directories on line 8 (between double quotation marks).

rm(list=ls())
source("readGPX_with_laser_fcn.R")
in.dir <- "data/Gray whale PB 2022"

output <- readGPX_v3(in.dir, 
                     write.file = T, 
                     save.fig = T, 
                     over.write.data = F,   # Whether or not to overwrite data outputs
                     over.write.fig = T)    # Whether or not to overwrite figures
