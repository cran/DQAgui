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


#' @title module_atemp_pl_server
#'
#' @param input Shiny server input object
#' @param output Shiny server output object
#' @param session Shiny session object
#' @param rv The global 'reactiveValues()' object, defined in server.R
#' @param input_re The Shiny server input object, wrapped into a reactive
#'   expression: \code{input_re = reactive({input})}
#'
#' @return The function returns a shiny server module.
#'
#' @seealso \url{https://shiny.rstudio.com/articles/modules.html}
#'
#' @examples
#' if (interactive()) {
#' rv <- list()
#' shiny::callModule(
#'   module_atemp_pl_server,
#'   "moduleAtemporalPlausibilities",
#'   rv = rv,
#'   input_re = reactive(input)
#' )
#' }
#'
#' @export
#'
# module_atemp_pl_server
module_atemp_pl_server <- function(input, output, session, rv, input_re) {
  observe({
    req(rv$checks$value_conformance)

    if (is.null(rv$pl_atemp_vars_filter)) {
      # create rv$pl_atemp_vars_filter for rendering of results
      listvec <- unname(
        sapply(
          names(rv$data_plausibility$atemporal),
          function(x) {
            # only plausibilities assigned to source data are being read
            rv$data_plausibility$atemporal[[x]]$source_data$name
          }, simplify = TRUE)
      )
      list_i <- 1
      rv$pl_atemp_vars_filter <- sapply(
        listvec,
        function(x) {
          outlist <- names(rv$data_plausibility$atemporal)[[list_i]]
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
        "moduleAtempPlausibility-plausibility_sel",
        "Select plausibility item",
        rv$pl_atemp_vars_filter,
        multiple = FALSE,
        selectize = FALSE,
        size = 10
      )
    })

    # generate output tables
    observeEvent(
      eventExpr = input_re()[["moduleAtempPlausibility-plausibility_sel"]],
      handlerExpr = {
        cat(input_re()[["moduleAtempPlausibility-plausibility_sel"]], "\n")

        # get description object
        sel_ob <- input_re()[["moduleAtempPlausibility-plausibility_sel"]]
        desc_out <- rv$results_plausibility_atemporal[[sel_ob]]$description
        count_out <- rv$results_plausibility_atemporal[[sel_ob]]$counts
        stat_out <- rv$results_plausibility_atemporal[[sel_ob]]$statistics

        value_conf <- rv$conformance$value_conformance[[sel_ob]]


        # render source description
        output$pl_selection_descr_source <- renderTable({
          o <- desc_out$source_data
          c <- count_out$source_data
          data.table::data.table(
            " " = c(
              "Variable 1:",
              "Variable 2:",
              "Filter Criterion Variable 2 (regex):",
              "Join Criterion:",
              "DQ-internal Variable Name:",
              "Variable type:"
            ),
            " " = c(
              o$var_dependent,
              o$var_independent,
              o$filter,
              o$join_crit,
              c$cnt$variable,
              c$type
            )
          )

        })

        output$pl_description <- renderText({
          d <- desc_out$source_data$description
          # https://community.rstudio.com/t/rendering-markdown-text/11588
          out <- knitr::knit2html(text = d, fragment.only = TRUE)
          # output non-escaped HTML string
          shiny::HTML(out)
        })

        # render target description
        output$pl_selection_descr_target <- renderTable({
          o <- desc_out$target_data
          c <- count_out$target_data
          data.table::data.table(
            " " = c(
              "Variable 1:",
              "Variable 2:",
              "Filter Criterion Variable 2 (regex):",
              "Join Criterion:",
              "DQ-internal Variable Name:",
              "Variable type:"
            ),
            " " = c(
              o$var_dependent,
              o$var_independent,
              o$filter,
              o$join_crit,
              c$cnt$variable,
              c$type
            )
          )

        })

        # render source counts
        output$pl_selection_counts_source <- renderTable({
          tryCatch({
            o <- count_out$source_data$cnt[, c(
              "variable",
              "n",
              "valids",
              "missings",
              "distinct"), with = FALSE]
            data.table::data.table(
              " " = c(
                "n:",
                "Valid values:",
                "Missing values:",
                "Distinct values:"
              ),
              " " = c(
                o$n,
                o$valids,
                o$missings,
                o$distinct
              )
            )
          }, error = function(e) {
            shinyjs::logjs(e)
            DIZtools::feedback(
              print_this = paste0(
                "Error while rendering the source counts while",
                " determining the atemporal plausibilities."
              ),
              type = "Error",
              findme = "b4af226576",
              logfile_dir = rv$log$logfile_dir,
              headless = rv$headless
            )
          })
        })
        # render target counts
        output$pl_selection_counts_target <- renderTable({
          tryCatch({
            o <- count_out$target_data$cnt[, c(
              "variable",
              "n",
              "valids",
              "missings",
              "distinct"), with = FALSE]
            data.table::data.table(
              " " = c(
                "n:",
                "Valid values:",
                "Missing values:",
                "Distinct values:"
              ),
              " " = c(
                o$n,
                o$valids,
                o$missings,
                o$distinct
              )
            )
          }, error = function(e) {
            shinyjs::logjs(e)
          })
        })


        # render target statistics
        output$pl_selection_target_table <- renderTable({
          stat_out$target_data
        })
        # render source statistics
        output$pl_selection_source_table <- renderTable({
          stat_out$source_data
        })


        # for some strange reason, lapply is required to dynamically assign
        # shiny outputs (for-loop doesn't work)
        lapply(
          X = c("source", "target"),
          FUN = function(i) {

            raw_data <- paste0(i, "_data")
            vset <- paste0("got_valueset_", substring(raw_data, 1, 1))

            # conformance source
            # render conformance checks (only if value set present)
            if (!is.null(value_conf[[raw_data]])) {
              # workaround to tell ui, that value_set is there
              output[[vset]] <- reactive({
                return(TRUE)
              })

              value_conformance_formatted <-
                DQAstats::format_value_conformance_results(
                  results = value_conf,
                  desc_out = desc_out,
                  source = raw_data
                )

              output[[paste0("pl_checks_", i)]] <- renderUI({
                h <- h5(tags$b("Constraining values/rules:"))
                v <- verbatimTextOutput(
                  outputId = paste0(
                    "moduleAtempPlausibility-pl_checks_", i, "_valueset"
                  )
                )


                ch <- h5(tags$b("Value conformance:"))
                ce <- h5(paste0(
                  "Conformance check: ",
                  gsub(
                    pattern = "Conformance check\\: ",
                    replacement = "",
                    x = value_conformance_formatted$conformance_check
                  )
                ))
                cu <- uiOutput(
                  paste0(
                    "moduleAtempPlausibility-pl_conformance_", i
                  )
                )
                do.call(tagList, list(h, v, tags$hr(), ch, ce, cu))
              })



              if (is.null(value_conformance_formatted$kable)) {
                output[[paste0("pl_checks_", i, "_valueset")]] <- renderText({
                  gsub(
                    pattern = "Constraining values\\/rules\\: ",
                    replacement = "",
                    x = value_conformance_formatted$constraining_rules
                  )
                })
              } else {
                output[[paste0("pl_checks_", i, "_valueset")]] <- renderPrint({
                  as.list(value_conformance_formatted$kable)
                })
              }

              # render automatic conformance checks source
              # value conformance
              if (!is.null(value_conformance_formatted$conformance_results)) {
                output[[paste0("pl_conformance_", i)]] <- renderUI({
                  v <- verbatimTextOutput(
                    outputId = paste0(
                      "moduleAtempPlausibility-pl_conformance_", i, "_results"
                    )
                  )
                  do.call(tagList, list(v))
                })

                output[[paste0("pl_conformance_", i, "_results")]] <-
                  renderText({
                    value_conformance_formatted$conformance_results
                  })
              } else {
                output[[paste0("pl_conformance_", i)]] <- renderUI({

                })
              }

            } else {
              # workaround to tell ui, that value_set is not there
              output[[vset]] <- reactive({
                return(FALSE)
              })
            }
            outputOptions(output, vset, suspendWhenHidden = FALSE)
          })
      })
  })
}

#' @title module_atemp_pl_ui
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
#'     tabName = "atemp_plausi",
#'     module_atemp_pl_ui(
#'       "moduleAtemporalPlausibilities"
#'     )
#'   )
#' )
#' }
#'
#' @export
#'
# module_atemp_pl_ui
module_atemp_pl_ui <- function(id) {
  ns <- NS(id)

  tagList(
    fluidRow(
      box(title = "Select variable",
          uiOutput(ns("pl_selection_uiout")),
          width = 4),
      box(title = "Description",
          htmlOutput(ns("pl_description")),
          width = 8)
    ),
    fluidRow(
      box(
        title = "Source Database",
        width = 6,
        fluidRow(
          column(8,
                 h5(
                   tags$b("Metadata")
                 ),
                 tableOutput(ns("pl_selection_descr_source"))
          ),
          column(4,
                 h5(
                   tags$b("Completeness Overview")
                 ),
                 tableOutput(ns("pl_selection_counts_source"))
          )
        ),
        fluidRow(
          column(8,
                 h5(
                   tags$b("Results")
                 ),
                 tableOutput(ns("pl_selection_source_table"))
          ),
          column(
            4,
            conditionalPanel(
              condition = "output['moduleAtempPlausibility-got_valueset_s']",
              uiOutput(ns("pl_checks_source"))
            )
          ))
      ),
      box(
        title = "Target Database",
        width = 6,
        fluidRow(
          column(8,
                 h5(
                   tags$b("Metadata")
                 ),
                 tableOutput(ns("pl_selection_descr_target"))
          ),
          column(4,
                 h5(
                   tags$b("Completeness Overview")
                 ),
                 tableOutput(
                   ns("pl_selection_counts_target")
                 ))
        ),
        fluidRow(
          column(8,
                 h5(
                   tags$b("Results")
                 ),
                 tableOutput(ns("pl_selection_target_table"))
          ),
          column(
            4,
            conditionalPanel(
              condition = "output['moduleAtempPlausibility-got_valueset_t']",
              uiOutput(ns("pl_checks_target"))
            )
          ))
      )
    ))
}
