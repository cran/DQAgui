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

#' @title module_log_server
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
#'   module_log_server,
#'   "moduleLogging",
#'   rv = rv,
#'   input_re = reactive(input)
#' )
#' }
#'
#' @export
#'
# module_log_server
module_log_server <-
  function(input, output, session, rv, input_re) {

    observe({
      req(rv$log$logfile_dir)

      if (is.null(rv$log$populated_old_logfiles_list)) {
        updateSelectInput(
          session = session,
          inputId = "old_logfiles_list",
          choices = sort(
            list.files(
              path = rv$log$logfile_dir,
              pattern = paste0(
                "^logfile",
                "(\\_[[:digit:]]{4}\\-",
                "[[:digit:]]{2}\\-",
                "[[:digit:]]{2}\\-",
                "[[:digit:]]{6}){0,1}\\.log$" # nolint
              )),
            decreasing = TRUE
          )
        )
        rv$log$populated_old_logfiles_list <- TRUE
      }
    })

    observeEvent(input$old_logfiles_list, {

      if (input$old_logfiles_list != "logfile.log") {
        shinyjs::show("show_current_logfile_btn")
      } else {
        shinyjs::hide("show_current_logfile_btn")
      }

      if (input$old_logfiles_list != "") {

        path_of_selected_file <-
          paste0(rv$log$logfile_dir, input$old_logfiles_list)

        rv$log$raw_text <-
          reactiveFileReader(
            intervalMillis = 500,
            filePath = path_of_selected_file,
            readFunc = readLines,
            session = session
          )

        rv$log$current_log <- reactive({
          paste0(rv$log$raw_text(), collapse = "\n")
        })
      }
    })

    observe({
      output$log_out <- renderText({
        rv$log$current_log()
      })
    })

    observeEvent(input$show_current_logfile_btn, {
      if (!is.null(rv$log$raw_text())) {
        # Show the current log:
        rv$current_log <-
          reactive({
            paste0(rv$log$raw_text(), collapse = "\n")
          })
        # ... and show update the list of old logfiles to have the current
        # one selected:
        updateSelectInput(session = session,
                          inputId = "old_logfiles_list",
                          selected = "logfile.log")
      }
    })

    # Button to scroll down:
    observeEvent(input$moduleLog_scrolldown_btn, {
      shinyjs::runjs(
        paste0(
          "var element = document.getElementById('moduleLog-log_out');",
          "element.scrollTop = element.scrollHeight;"
        )
      )
    })

    # Button to scroll up:
    observeEvent(input$moduleLog_scrollup_btn, {
      shinyjs::runjs(
        paste0(
          "var element = document.getElementById('moduleLog-log_out');",
          "element.scrollTop = 0;"
        )
      )
    })

    output$download_logfile <- downloadHandler(
      filename = function() {
        input$old_logfiles_list
      },
      content = function(file) {
        path_with_file <- paste0(rv$log$logfile_dir, input$old_logfiles_list)
        file.copy(from = path_with_file, file)
      },
      contentType = "text/plain"
    )

  }

#' @title module_log_ui
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
#'     tabName = "logging",
#'     module_log_ui(
#'       "moduleLogging"
#'     )
#'   )
#' )
#' }
#'
#' @export
#'
# module_log_ui
module_log_ui <- function(id) {
  ns <- NS(id)
  tagList(fluidRow(
    # Appearance of the console output:
    # 'padding-left' & 'text-intend' are for auto intending every line
    #   except the first one so that over-long sentences will clearly
    #   be intended after the word/line-wrap.
    # 'margin' & 'line-heigth' reduce the gap between two lines to show
    #   as much information as possible while still be good readable.
    tags$head(
      tags$style(
        ".logmsg p {
        font-family: 'consolas';
        line-height: 1;
        margin: 0px 0px 2px 0px;
        padding-left: 5%;
        text-indent:-5%;
        }"
      )
    ),
    box(
      title = "Log",
      verbatimTextOutput(ns("log_out")),
      tags$head(tags$style(
        paste0(
          "#moduleLog-log_out{overflow-y:scroll; ",
          "max-height: 70vh; background: ghostwhite;}"
        )
      )),
      actionButton(
        inputId = ns("moduleLog_scrolldown_btn"),
        label = "Scroll to bottom",
        icon = icon("chevron-down")
      ),
      actionButton(
        inputId = ns("moduleLog_scrollup_btn"),
        label = "Scroll to top",
        icon = icon("chevron-up")
      ),
      width = 9
    ),

    box(
      title = "Download Log File",
      div(
        class = "row",
        style = "text-align: center;",
        downloadButton(ns("download_logfile"), "Download Log File")),
      tags$hr(),
      selectInput(
        # This will be filled in the server part.
        inputId = ns("old_logfiles_list"),
        label = "Load old logfiles",
        choices = NULL,
        selected = NULL
      ),
      actionButton(
        inputId = ns("show_current_logfile_btn"),
        label = "Show current logfile",
        icon = icon("terminal")
      ),
      width = 3
    )
  ))
}
