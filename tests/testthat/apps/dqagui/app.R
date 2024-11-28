# DQAgui - A graphical user interface (GUI) to the functions implemented in the
# R package 'DQAstats'.
# Copyright (C) 2019-2024 Universitätsklinikum Erlangen
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

library(DQAgui)

# define base paths for shinyFiles::shinyDirChoose
Sys.setenv(
  "CSV_SOURCE_BASEPATH" = system.file("demo_data", package = "DQAstats")
)
Sys.setenv(
  "CSV_TARGET_BASEPATH" = system.file("demo_data", package = "DQAstats")
)

# define path to utilities-folder
utils_path <- system.file("demo_data/utilities",
                         package = "DQAstats")

# filename of the metadata repository
mdr_filename <- "mdr_example_data.csv"

# directory for storing logfiles
logfile_dir <- tempdir()

launch_app(
  port = 3838,
  utils_path = utils_path,
  mdr_filename = mdr_filename,
  logfile_dir = logfile_dir,
  parallel = FALSE
)
