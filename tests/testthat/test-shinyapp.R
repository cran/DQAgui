# DQAgui - A graphical user interface (GUI) to the functions implemented in the
# R package 'DQAstats'.
# Copyright (C) 2019-2022 Universitätsklinikum Erlangen
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


# This file is for testing the applications in the inst/ directory.
test_that("DQAgui shiny app / launch_app() works", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()

  #%app <- shiny::shinyAppDir("tests/testthat/apps/dqagui/")
  app <- shiny::shinyAppDir("apps/dqagui/")

  local_edition(3)

  # https://mastering-shiny.org/scaling-testing.html#testing-reactivity
  # https://rstudio.github.io/shinytest/articles/shinytest.html
  # https://rstudio.github.io/shinytest/articles/in-depth.html
  shiny::testServer(app = app, expr = {
    session$setInputs(tabs = "tab_config")
    session$setInputs(`moduleConfig-config_load_mdr` = "click")
    rv$restricting_date$use_it <- FALSE
    rv$source$system_name <- "exampleCSV_source"
    rv$target$system_name <- "exampleCSV_target"
    rv$source$system_type <- "csv"
    rv$target$system_type <- "csv"
    rv$target_is_source <- FALSE
    rv$source$settings$path <- Sys.getenv("CSV_SOURCE_BASEPATH")
    rv$target$settings$path <- Sys.getenv("CSV_SOURCE_BASEPATH")
    DQAgui:::check_load_data_button(rv, session)
    session$flushReact()
    session$setInputs(`moduleConfig-config_sitename` = "DEMO")
    session$setInputs(`moduleConfig-date_restriction_slider` = FALSE)
    session$setInputs(`moduleConfig-select_dqa_assessment_variables` =
                        rv$dqa_assessment[["designation"]])
    session$setInputs(`moduleConfig-dash_load_btn` = "click")

    # reactive values to list
    output <- shiny::reactiveValuesToList(rv)

    # delete time-specific fields
    output$start_time <- NULL
    output$end_time <- NULL
    output$duration <- NULL

    expect_snapshot_value(
      x = names(output),
      style = "json2",
      cran = FALSE,
      tolerance = 10e-1,
      ignore_function_env = TRUE
    )

    expect_snapshot_value(
      x = output$results_plausibility_atemporal,
      style = "json2",
      cran = FALSE,
      tolerance = 10e-1,
      ignore_function_env = TRUE
    )

    expect_snapshot_value(
      x = output$conformance$value_conformance,
      style = "json2",
      cran = FALSE,
      tolerance = 10e-1,
      ignore_function_env = TRUE
    )

    expect_snapshot_value(
      x = output$completeness,
      style = "json2",
      cran = FALSE,
      tolerance = 10e-1,
      ignore_function_env = TRUE
    )

    expect_snapshot_value(
      x = output$checks$value_conformance,
      style = "json2",
      cran = FALSE,
      tolerance = 10e-1,
      ignore_function_env = TRUE
    )

    expect_snapshot_value(
      x = output$checks$etl,
      style = "json2",
      cran = FALSE,
      tolerance = 10e-1,
      ignore_function_env = TRUE
    )

    expect_snapshot_value(
      x = output$datamap,
      style = "json2",
      cran = FALSE,
      tolerance = 10e-1,
      ignore_function_env = TRUE
    )
  })
})
