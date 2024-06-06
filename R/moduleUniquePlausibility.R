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

#' @title module_uniq_plaus_server
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
#'   module_uniq_plaus_server,
#'   "moduleUniquenessPlausibilities",
#'   rv = rv,
#'   input_re = reactive(input)
#' )
#' }
#'
#' @export
#'
# module_uniq_plaus_server
module_uniq_plaus_server <-
  function(input, output, session, rv, input_re) {
    observe({
      req(rv$results_plausibility_unique)

      if (is.null(rv$pl_uniq_vars_filter)) {
        # create rv$pl_atemp_vars_filter for rendering of results
        listvec <- names(rv$results_plausibility_unique)
        list_i <- 1
        rv$pl_uniq_vars_filter <- sapply(listvec, function(x) {
          outlist <- names(rv$results_plausibility_unique)[[list_i]]
          invisible(list_i <<- list_i + 1)
          return(outlist)
        },
        USE.NAMES = TRUE,
        simplify = FALSE
        )
        rm(list_i, listvec)
        gc()
      }

      # render select input here
      output$pl_selection_uiout <- renderUI({
        selectInput(
          "moduleUniquePlausibility-plausibility_sel",
          "Select plausibility item",
          rv$pl_uniq_vars_filter,
          multiple = FALSE,
          selectize = FALSE,
          size = 10
        )
      })

      # generate output tables
      observeEvent(input_re()[["moduleUniquePlausibility-plausibility_sel"]], {
        cat(input_re()[["moduleUniquePlausibility-plausibility_sel"]], "\n")

        sel_ob3 <- input_re()[["moduleUniquePlausibility-plausibility_sel"]]
        uniq_out <- rv$results_plausibility_unique[[sel_ob3]]


        # description
        output$pl_description <- renderText({
          d <- uniq_out$description
          # https://community.rstudio.com/t/rendering-markdown-text/11588
          out <- knitr::knit2html(text = d, fragment.only = TRUE)
          # output non-escaped HTML string
          shiny::HTML(out)
        })

        # render target statistics
        output$pl_selection_target_table <- renderUI({
          c1 <-
            h5(paste0(
              "Plausibility check: ",
              ifelse(
                uniq_out$target_data$error == "FALSE",
                "passed",
                "failed"
              )
            ))
          c3 <- h5(paste0("Message: ", uniq_out$target_data$message))

          do.call(tagList, list(c1, c3))
        })
        # render source statistics
        output$pl_selection_source_table <- renderUI({
          c1 <-
            h5(paste0(
              "Plausibility check: ",
              ifelse(
                uniq_out$source_data$error == "FALSE",
                "passed",
                "failed"
              )
            ))
          c3 <- h5(paste0("Message: ", uniq_out$source_data$message))

          do.call(tagList, list(c1, c3))
        })
      })
    })
  }

#' @title module_uniq_plaus_ui
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
#'     tabName = "uniq_plausis",
#'     module_uniq_plaus_ui(
#'       "moduleUniquenessPlausibilities"
#'     )
#'   )
#' )
#' }
#'
#' @export
#'
# module_uniq_plaus_ui
module_uniq_plaus_ui <- function(id) {
  ns <- NS(id)

  tagList(
    fluidRow(
      box(
        title = "Select variable",
        uiOutput(ns(
          "pl_selection_uiout"
        )),
        width = 4),
      box(
        title = "Description",
        htmlOutput(ns("pl_description")),
        width = 8)
    ),
    fluidRow(
      box(
        title = "Source Database",
        h5(tags$b("Results")),
        uiOutput(ns("pl_selection_source_table")),
        width = 6
      ),
      box(
        title = "Target Database",
        h5(tags$b("Results")),
        uiOutput(ns("pl_selection_target_table")),
        width = 6
      )
    ))
}
