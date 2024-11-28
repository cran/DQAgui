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

# assign global variable here

# source external functions here
options(kableExtra.auto_format = FALSE)
options(knitr.table.format = "latex")

# nolint start

## !!! ------------------------------------------------------------------
## Everything below here is only needed to deploy the app to shinyapps.io
## Please uncomment it in normal use!
## !!! ------------------------------------------------------------------

#
# library(markdown)
# library(DQAgui)
#
# Sys.setenv("CSV_SOURCE_BASEPATH" = system.file("demo_data", package = "DQAstats"))
# Sys.setenv("CSV_TARGET_BASEPATH" = system.file("demo_data", package = "DQAstats"))
#
# tinytex::install_tinytex(force = TRUE)
#
# # debugging default for Lorenz
# #Sys.setenv("CSV_SOURCE_BASEPATH" = "~/development/Rpackages")
# #Sys.setenv("CSV_TARGET_BASEPATH" = "~/development/Rpackages")
#
# ## debugging testdata:
# ## ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓
# utils_path = system.file("demo_data/utilities",
#                          package = "DQAstats")
# mdr_filename = "mdr_example_data.csv"
# logfile_dir <- tempdir()
# ##	↑	↑	↑	↑	↑	↑	↑	↑	↑	↑	↑
#
# logfile_dir = tempdir()
# parallel = FALSE
# ncores = 4
# demo_usage = TRUE
#
# ## To build and upload the package, run:
# # rsconnect::setAccountInfo(name = 'uker',
# #                           token = 'XXX',
# #                           secret = 'XXX')
# # rsconnect::deployApp(
# #   appDir = "./inst/application",
# #   appName = "DQAgui-demo",
# #   forceUpdate = TRUE
# # )

# nolint end
