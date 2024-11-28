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


#' @title module_mdr_server
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
#'   module_mdr_server,
#'   "moduleMDR",
#'   rv = rv,
#'   input_re = reactive(input)
#' )
#' }
#'
#' @export
#'
# module_mdr_server
module_mdr_server <- function(input, output, session, rv, input_re) {

  output$mdr_table <- DT::renderDataTable({
    DT::datatable(
      data = rv$mdr,
      class = "display nowrap",
      options = list(
        scrollX = TRUE,
        scrollY = "70vh",
        pageLength = 20,
        dom = "ltip"
      ),
      rownames = FALSE,
      selection = "single"
    )
  })
}


#' @title module_mdr_ui
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
#'     tabName = "mdr",
#'     module_mdr_ui(
#'       "moduleMDR"
#'     )
#'   )
#' )
#' }
#'
#' @export
#'
# module_mdr_ui
module_mdr_ui <- function(id) {
  ns <- NS(id)

  tagList(fluidRow(
    box(
      title = "DQ Metadatarepository",
      DT::dataTableOutput(ns("mdr_table")),
      width = 12
    )
  ))
}
