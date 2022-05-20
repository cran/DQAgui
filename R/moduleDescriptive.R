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


#' @title module_descriptive_server
#'
#' @param input Shiny server input object
#' @param output Shiny server output object
#' @param session Shiny session object
#' @param rv The global 'reactiveValues()' object, defined in server.R
#' @param input_re The Shiny server input object, wrapped into a reactive
#'   expression: input_re = reactive({input})
#'
#' @return The function returns a shiny server module.
#'
#' @seealso \url{https://shiny.rstudio.com/articles/modules.html}
#'
#' @examples
#' if (interactive()) {
#' rv <- list()
#' shiny::callModule(
#'   module_descriptive_server,
#'   "moduleDescriptive",
#'   rv = rv,
#'   input_re = reactive(input)
#' )
#' }
#'
#' @export
#'
# module_descriptive_server
module_descriptive_server <-
  function(input, output, session, rv, input_re) {
    observe({
      req(rv$results_descriptive)

      # render select input here
      output$descr_selection_uiout <- renderUI({
        selectInput(
          inputId = "moduleDescriptive-var_select",
          label = "Select variable",
          choices = names(rv$variable_list),
          multiple = FALSE,
          selectize = FALSE,
          size = 10
        )
      })


      # generate output tables
      observeEvent(input_re()[["moduleDescriptive-var_select"]], {
        cat(input_re()[["moduleDescriptive-var_select"]], "\n")

        sel_ob <- input_re()[["moduleDescriptive-var_select"]]
        # get description object
        desc_out <- rv$results_descriptive[[sel_ob]]$description
        count_out <- rv$results_descriptive[[sel_ob]]$counts
        stat_out <- rv$results_descriptive[[sel_ob]]$statistics

        value_conf <- rv$conformance$value_conformance[[sel_ob]]


        output$descr_description <- renderText({
          d <- desc_out$source_data$description
          # https://community.rstudio.com/t/rendering-markdown-text/11588
          out <- knitr::knit2html(text = d, fragment.only = TRUE)
          # output non-escaped HTML string
          shiny::HTML(out)
        })

        # render source description
        output$descr_selection_descr_source <- renderTable({
          o <- desc_out$source_data
          c <- count_out$source_data
          data.table::data.table(
            " " = c(
              "Variable name:",
              "Source table:",
              #"FHIR ressource:",
              "DQ-internal Variable Name:",
              "Variable type:"
            ),
            " " = c(
              o$var_name,
              o$table_name,
              #o$fhir,
              c$cnt$variable,
              c$type
            )
          )

        })

        # render target description
        output$descr_selection_descr_target <- renderTable({
          o <- desc_out$target_data
          c <- count_out$target_data
          data.table::data.table(
            " " = c(
              "Variable name:",
              "Source table:",
              #"FHIR ressource:",
              "DQ-internal Variable Name:",
              "Variable type:"
            ),
            " " = c(
              o$var_name,
              o$table_name,
              #o$fhir,
              c$cnt$variable,
              c$type
            )
          )

        })

        # render source counts
        output$descr_selection_counts_source <- renderTable({
          tryCatch({
            o <-
              count_out$source_data$cnt[, c(
                "variable",
                "n",
                "valids",
                "missings",
                "distinct"
              ), with = FALSE]
            data.table::data.table(
              " " = c(
                "n:",
                "Valid values:",
                "Missing values:",
                "Distinct values:"
              ),
              " " = c(o$n, o$valids, o$missings, o$distinct)
            )
          }, error = function(e) {
            shinyjs::logjs(e)
          })
        })

        # render target counts
        output$descr_selection_counts_target <- renderTable({
          tryCatch({
            o <-
              count_out$target_data$cnt[, c(
                "variable",
                "n",
                "valids",
                "missings",
                "distinct"
              ), with = FALSE]
            data.table::data.table(
              " " = c(
                "n:",
                "Valid values:",
                "Missing values:",
                "Distinct values:"
              ),
              " " = c(o$n, o$valids, o$missings, o$distinct)
            )
          }, error = function(e) {
            shinyjs::logjs(e)
          })
        })


        # render source statistics
        output$descr_selection_source_table <- renderTable({
          stat_out$source_data
        })

        # render target statistics
        output$descr_selection_target_table <- renderTable({
          stat_out$target_data
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

            output[[paste0("descr_checks_", i)]] <- renderUI({
              h <- h5(tags$b("Constraining values/rules:"))
              v <- verbatimTextOutput(
                outputId = paste0(
                  "moduleDescriptive-descr_checks_", i, "_valueset"
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
                  "moduleDescriptive-descr_conformance_", i
                )
              )
              do.call(tagList, list(h, v, tags$hr(), ch, ce, cu))
            })



            if (is.null(value_conformance_formatted$kable)) {
              output[[paste0("descr_checks_", i, "_valueset")]] <- renderText({
                gsub(
                  pattern = "Constraining values\\/rules\\: ",
                  replacement = "",
                  x = value_conformance_formatted$constraining_rules
                )
              })
            } else {
              output[[paste0("descr_checks_", i, "_valueset")]] <- renderPrint({
                as.list(value_conformance_formatted$kable)
              })
            }

            # render automatic conformance checks source
            # value conformance
            if (!is.null(value_conformance_formatted$conformance_results)) {
              output[[paste0("descr_conformance_", i)]] <- renderUI({
                v <- verbatimTextOutput(
                  outputId = paste0(
                    "moduleDescriptive-descr_conform_", i, "_results"
                  )
                )
                do.call(tagList, list(v))
              })

              output[[paste0("descr_conform_", i, "_results")]] <- renderText({
                value_conformance_formatted$conformance_results
              })
            } else {
              output[[paste0("descr_conformance_", i)]] <- renderUI({

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

    observe({
      req(rv$source$system_type)

      if (rv$source$system_type %in% DIZutils::get_db_systems()) {
        output$descr_source_sql <- renderUI({
          actionButton(
            inputId = "moduleDescriptive-descr_source_sql_btn",
            label = "Source SQL"
          )
        })
      }
    })

    observe({
      req(rv$target$system_type)

      if (rv$target$system_type %in% DIZutils::get_db_systems()) {
        output$descr_target_sql <- renderUI({
          actionButton(
            inputId = "moduleDescriptive-descr_target_sql_btn",
            label = "Target SQL"
          )
        })
      }
    })

    observeEvent(
      eventExpr = input_re()[["moduleDescriptive-descr_source_sql_btn"]],
      handlerExpr = {
        sel_ob <- input_re()[["moduleDescriptive-var_select"]]
        sel_map <- unique(rv$dqa_assessment[get("designation") == sel_ob,
                                            get("key")])
        showModal(modalDialog(
          title = "Source SQL statement",
          shiny::HTML(fix_sql_display(rv$source$sql[[sel_map]])),
          easyClose = TRUE,
          footer = NULL
        ))
      }
    )

    observeEvent(
      eventExpr = input_re()[["moduleDescriptive-descr_target_sql_btn"]],
      handlerExpr = {
        sel_ob <- input_re()[["moduleDescriptive-var_select"]]
        sel_map <- unique(rv$dqa_assessment[get("designation") == sel_ob,
                                            get("key")])
        showModal(modalDialog(
          title = "Target SQL statement",
          shiny::HTML(fix_sql_display(rv$target$sql[[sel_map]])),
          easyClose = TRUE,
          footer = NULL
        ))
      }
    )
  }


#' @title module_descriptive_ui
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
#'     tabName = "descriptive",
#'     module_descriptive_ui(
#'       "moduleDescriptive"
#'     )
#'   )
#' )
#' }
#'
#' @export
#'
# module_descriptive_ui
module_descriptive_ui <- function(id) {
  ns <- NS(id)

  tagList(
    fluidRow(
      box(title = "Select variable",
          uiOutput(ns("descr_selection_uiout")),
          width = 4),
      box(title = "Description",
          htmlOutput(ns("descr_description")),
          width = 8)
    ),
    fluidRow(
      box(
        title = "Source Data System",
        width = 6,
        fluidRow(
          column(8,
                 h5(
                   tags$b("Metadata")
                 ),
                 tableOutput(
                   ns("descr_selection_descr_source")
                 )),
          column(4,
                 h5(
                   tags$b("Completeness Overview")
                 ),
                 tableOutput(
                   ns("descr_selection_counts_source")
                 ),
                 tags$hr(),
                 uiOutput(ns("descr_source_sql"))
          )),
        fluidRow(
          column(8,
                 h5(
                   tags$b("Results")
                 ),
                 tableOutput(
                   ns("descr_selection_source_table")
                 )),
          column(
            4,
            conditionalPanel(
              condition = "output['moduleDescriptive-got_valueset_s']",
              uiOutput(ns("descr_checks_source")))
          ))
      ),
      box(
        title = "Target Data System",
        width = 6,
        fluidRow(
          column(8,
                 h5(
                   tags$b("Metadata")
                 ),
                 tableOutput(
                   ns("descr_selection_descr_target")
                 )),
          column(4,
                 h5(
                   tags$b("Completeness Overview")
                 ),
                 tableOutput(
                   ns("descr_selection_counts_target")
                 ),
                 tags$hr(),
                 uiOutput(ns("descr_target_sql"))
          )),
        fluidRow(
          column(8,
                 h5(
                   tags$b("Results")
                 ),
                 tableOutput(
                   ns("descr_selection_target_table")
                 )),
          column(
            4,
            conditionalPanel(
              condition = "output['moduleDescriptive-got_valueset_t']",
              uiOutput(ns("descr_checks_target")))
          ))
      )
    ))
}
