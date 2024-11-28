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


#' @title module_differences_server
#'
#' @inheritParams module_atemp_pl_server
#'
#' @return The function returns a shiny server module.
#'
#' @seealso \url{https://shiny.rstudio.com/articles/modules.html}
#'
#' @examples
#' if (interactive()) {
#' rv <- list()
#' shiny::callModule(
#'   module_differences_server,
#'   "moduleDifferences",
#'   rv = rv,
#'   input_re = reactive(input)
#' )
#' }
#'
#' @export
#'
# module_differences_server
module_differences_server <-
  function(input, output, session, rv, input_re) {
    observe({
      req(rv$time_compare_results)

      # render select input here
      output$descr_selection_uiout <- renderUI({
        selectInput(
          inputId = "moduleDifferences-var_select",
          label = "Select data item",
          choices = names(rv$time_compare_results),
          multiple = FALSE,
          selectize = FALSE,
          size = 10
        )
      })

       output$source_database <- renderText({
         paste0("Source Data (", rv$source$system_name, ") ")
       })

       output$target_database <- renderText({
         paste0("Target Data (", rv$target$system_name, ") ")
       })

      # generate output tables
      observeEvent(input_re()[["moduleDifferences-var_select"]], {
        cat(input_re()[["moduleDifferences-var_select"]], "\n")

        sel_ob <- input_re()[["moduleDifferences-var_select"]]
        # get description object
        desc_out <- rv$results_descriptive[[sel_ob]]$description
        summary_out <- rv$time_compare_results[[sel_ob]]$result_table
        count_out <- rv$results_descriptive[[sel_ob]]$counts
        target_out <- rv$time_compare_results[[sel_ob]]$suspect_data_target
        source_out <- rv$time_compare_results[[sel_ob]]$suspect_data_source

        value_conf <- rv$conformance$value_conformance[[sel_ob]]


        output$descr_description <- renderTable({
          utils::head(summary_out, 50)
        })

        # render source statistics
        output$descr_selection_source_table <- renderTable({
          utils::head(source_out, 200)
          }
        )

        # render target statistics
        output$descr_selection_target_table <- renderTable({
          utils::head(target_out, 200)
        })

        # handling the download options
        output$download_data <- downloadHandler(
          filename = function() {
            time <- format(Sys.time(), "%Y_%m_%d_%H_%M")
            paste("DQA-Difference-Data-", time, ".rds", sep = "")
          },
          content = function(file) {
            difference_results <- list()
            difference_results$source <- rv$source$system_name
            difference_results$target <- rv$target$system_name
            difference_results$time_restriction <- rv$restricting_date
            difference_results$start_time <- rv$start_time
            difference_results$time_compare_results <- rv$time_compare_results
            saveRDS(difference_results, file)
          },
          contentType = "application/rds"
        )

        output$download_source <- downloadHandler(
          filename = function() {
            time <- format(Sys.time(), "%Y_%m_%d_%H_%M")
            paste("Diff-source-",sel_ob ,time , ".csv", sep = "")
          },
          content = function(file) {
            data.table::fwrite(
              x = source_out,
              file = file
            )
          },
          contentType = "text/csv"
        )

        output$download_target <- downloadHandler(
          filename = function() {
            time <- format(Sys.time(), "%Y_%m_%d_%H_%M")
            paste("Diff-target-",sel_ob ,time , ".csv", sep = "")
          },
          content = function(file) {
            data.table::fwrite(
              x = target_out,
              file = file
            )
          },
          contentType = "text/csv"
        )
      })
    })

  }


#' @title module_differences_ui
#'
#' @param id A character. The identifier of the shiny object
#'
#' @return The function returns a shiny ui module.
#'
#' @seealso \url{https://shiny.rstudio.com/articles/modules.html}
#'
#' @examples
#' if (interactive()) {
#' shinydashboard::tabItems(
#'   shinydashboard::tabItem(
#'     tabName = "differences",
#'     module_differences_ui(
#'       "moduleDifferences"
#'     )
#'   )
#' )
#' }
#'
#' @export
#'
# module_differences_ui
module_differences_ui <- function(id) {
  ns <- NS(id)

  tagList(
    fluidRow(
         box(title = "Select data item",
          uiOutput(ns("descr_selection_uiout")),
          width = 4),

        box(title = "Summary",
          style = "height: 300px; overflow-y: scroll;",
          htmlOutput(ns("descr_description")),
          width = 8)
    ),
    fluidRow(
      box(
        width = 4,
        "If the available resources for a given TIMESTAMP",
        "differ, it is likely that a resource is missing in either the source",
        "or the target database. The following tables contain all resources",
        "with differences in their TIMESTAMP count (if too many, displayed ",
        "items are limited for performance reasons)."
      ),
      box(
        width = 8,
        column(
          width = 6,
          "The .pdf report contains only the first 30 lines ",
          "of the summary table. You can download the shown source or target",
          "result-table as .csv file. Or you can download all results ",
          "including some metadata as .rds file for further analysis in R."
        ),
        column(
          width = 2,
          downloadButton(
            ns("download_data"), "All (.rds)"
          )
        ),
        column(
          width = 4,
          downloadButton(
            ns("download_source"), "Source Data (.csv)",
            style = "width: 140px; margin-bottom: 6px;"
            ),
          tags$br(),
          downloadButton(
            ns("download_target"), "Target Data (.csv)",
            style = "width: 140px;"
            )
        )
      )
    ),
    fluidRow(
      box(
        title = textOutput(ns("source_database")),
        width = 6,
        style = "overflow-x: scroll; overflow-y: scroll; height: 600px;",
        tableOutput(
          ns("descr_selection_source_table"))
      ),
      box(
        title = textOutput(ns("target_database")),
        width = 6,
        style = "overflow-X: scroll; overflow-y: scroll; height: 600px;",
        tableOutput(
          ns("descr_selection_target_table"))
      )
    ))
}
