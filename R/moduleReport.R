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


#' @title module_report_server
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
#'   module_report_server,
#'   "moduleReport",
#'   rv = rv,
#'   input_re = reactive(input)
#' )
#' }
#'
#' @export
#'
# module_report_server
module_report_server <- function(input,
                                 output,
                                 session,
                                 rv,
                                 input_re) {

  observe({
    # wait here for flag to create report; this can be done, when everything
    # we need for the report is there
    req(rv$create_report)

    if (is.null(rv$report_created)) {
      DQAstats::create_pdf_report(
        rv = shiny::reactiveValuesToList(rv),
        utils_path = rv$utilspath,
        outdir = tempdir(),
        headless = rv$headless
      )
      rv$report_created <- TRUE
    }
  })

  observe({
    req(rv$report_created)

    if (is.null(rv$aggregated_exported)) {
      DQAstats::export_aggregated(
        output_dir = tempdir(),
        rv = rv
      )
      rv$aggregated_exported <- TRUE
    }
    waiter::waiter_hide()
  })


  output$download_report <- downloadHandler(
    filename = function() {
      paste0("DQA_report_",
             gsub("\\-|\\:| ",
                  "",
                  substr(rv$start_time, 1, 16)),
             "_",
             rv$sitename,
             ".pdf")
    },
    content = function(file) {

      outfile <- sort(
        list.files(
          path = tempdir(),
          pattern = "^DQA_report_.*\\.pdf",
          full.names = TRUE
        ),
        decreasing = TRUE
      )
      print(outfile)
      if (length(outfile) < 1) {
        warning("An error occurred finding the pdf-file.")
      } else {
        file.copy(
          from = outfile[1],
          to = file
        )
      }
    },
    contentType = "application/pdf"
  )


  output$download_results <- downloadHandler(
    filename = function() {
      paste0("DQA_results_",
             gsub("\\-|\\:| ",
                  "",
                  substr(rv$start_time, 1, 16)),
             "_",
             rv$sitename,
             ".zip")
    },
    content = function(fname) {

      # temporarily set tempdir as wd
      oldwd <- getwd()
      on.exit(oldwd)
      setwd(tempdir())

      exportdir <- paste0(tempdir(), "/export/")

      # export files
      utils::zip(
        zipfile = fname,
        files = c(
          paste0("export/",
                 list.files(exportdir))
        ))

      # return to old wd
      setwd(oldwd)
    },
    contentType = "application/zip"
  )
}

#' @title module_report_ui
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
#'     tabName = "report",
#'     module_report_ui(
#'       "moduleReport"
#'     )
#'   )
#' )
#' }
#' @export
#'
# module_report_ui
module_report_ui <- function(id) {
  ns <- NS(id)

  tagList(
    fluidRow(
      column(
        6,
        box(
          title = "Reporting",
          downloadButton(
            ns("download_report"),
            "Download Report",
            style = paste0(
              "white-space: normal; ",
              "text-align:center; ",
              "padding: 9.5px 9.5px 9.5px 9.5px; ",
              "margin: 6px 10px 6px 10px;")),
          width = 12
        )
      ),
      column(
        6,
        box(
          title = "Results",
          downloadButton(
            ns("download_results"),
            "Download Results (ZIP)",
            style = paste0(
              "white-space: normal; ",
              "text-align:center; ",
              "padding: 9.5px 9.5px 9.5px 9.5px; ",
              "margin: 6px 10px 6px 10px;")),
          width = 12
        )
      )
    )
  )
}
