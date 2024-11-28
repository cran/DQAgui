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


#' @title Launch the DQA graphical user interface (GUI)
#'
#' @param port The port, the MIRACUM DQA Tool is running on (default: 3838)
#' @param utils_path The path to the utilities-folder, containing the metadata
#'   repository files (`mdr.csv` inside the folder `MDR`), JSON files with SQL
#'   statements (inside the folder `SQL`), config files for the database
#'   connection (`settings_default.yml`) and the email address used for the
#'   data map (`email.yml`), a JSON file containing site names (inside the
#'   folder `MISC`) and a markdown template to create the PDF report
#'   (`DQA_report.Rmd` inside the folder `RMD`).
#' @param mdr_filename The filename of the mdr (e.g. "mdr_example_data.csv").
#' @param logfile_dir Is the absolute path to the directory where the logfile
#'   will be stored. If not path is provided the tempdir() will be used.
#' @param parallel A boolean. If `TRUE`, initializing a `future::plan()`
#'   for running the code (default: `FALSE`).
#' @param ncores A integer. The number of cores to use. Caution: you would
#'   probably like to choose a low number when operating on large datasets.
#'   Default: 2.
#' @param demo_usage A boolean. If `TRUE`, a box is shown on the dashboard with
#'   further instructions on how to use / configure the tool.
#'
#' @return Executing this function returns a DQAgui shiny application.
#'
#' @examples
#' if (interactive()) {
#'   launch_app()
#' }
#'
#' @export

launch_app <- function(port = 3838,
                       utils_path = system.file("demo_data/utilities",
                                                package = "DQAstats"),
                       mdr_filename = "mdr_example_data.csv",
                       logfile_dir = tempdir(),
                       parallel = FALSE,
                       ncores = 2,
                       demo_usage = FALSE) {

  DIZtools::assign_to_R_env(key = "utils_path",
                            val = utils_path,
                            pos = 1L)

  DIZtools::assign_to_R_env(key = "mdr_filename",
                            val = mdr_filename,
                            pos = 1L)

  DIZtools::assign_to_R_env(key = "logfile_dir",
                            val = logfile_dir,
                            pos = 1L)

  DIZtools::assign_to_R_env(key = "parallel",
                            val = parallel,
                            pos = 1L)

  DIZtools::assign_to_R_env(key = "ncores",
                            val = ncores,
                            pos = 1L)

  DIZtools::assign_to_R_env(key = "demo_usage",
                            val = demo_usage,
                            pos = 1L)

  options(shiny.port = port)

  message(
    paste0(
      "\nVersion DIZtools: ", utils::packageVersion("DIZtools"),
      "\nVersion DIZutils: ", utils::packageVersion("DIZutils"),
      "\nVersion DQAstats: ", utils::packageVersion("DQAstats"),
      "\nVersion DQAgui: ", utils::packageVersion("DQAgui"),
      "\n"
    )
  )

  shiny::shinyAppDir(
    appDir = system.file("application", package = "DQAgui")
  )
}
