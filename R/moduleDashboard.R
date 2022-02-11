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


#' @title module_dashboard_server
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
#'   module_dashboard_server,
#'   "moduleDashboard",
#'   rv = rv,
#'   input_re = reactive(input)
#' )
#' }
#'
#' @export
#'
# module_dashboard_server
module_dashboard_server <-
  function(input, output, session, rv, input_re) {
    output$dash_instruction <- renderText({
      paste0(
        "Please load your metadata repository first and then configure ",
        "and test your source and target parameters in the config tab.\n",
        "Results will be displayed here afterwards."
      )
    })

    observe({
      req(rv$start)

      if (isTRUE(rv$start)) {
        waiter::waiter_show(
          html = shiny::tagList(waiter::spin_timer(),
                                "Starting to load the data ..."))

        tryCatch({
          ## For runtime calculation:
          start_time <- Sys.time()

          # load all data here
          if (isTRUE(rv$getdata_target) && isTRUE(rv$getdata_source)) {
            stopifnot(length(rv$source$system_type) == 1)

            ## Save restricting date information to rv object:
            if (isFALSE(rv$restricting_date$use_it)) {
              DIZutils::feedback(
                print_this = paste0(
                  "No time contstraints will be applied to input data.",
                  " Either `restricting_date_start` or ",
                  " `restricting_date_end` was null."
                ),
                logfile = rv$log$logfile_dir,
                findme = "44d1fbe2e7"
              )
            } else {
              ### INFO:
              ### We are currently only using DATES without a time here.
              ### If you one time want to change this, you need to
              ### remove the appending of the time here and take care of
              ### time-zones!
              restricting_date_start_posixct <-
                parsedate::parse_date(
                  dates = paste0(rv$restricting_date$start, " 00:00:00"),
                  approx = FALSE
                )
              restricting_date_end_posixct <-
                parsedate::parse_date(
                  dates = paste0(rv$restricting_date$end, " 23:59:59"),
                  approx = FALSE
                )

              ## Check the start date:
              if (is.na(restricting_date_start_posixct)) {
                DIZutils::feedback(
                  print_this = paste0("Couldn't identify input date",
                                      " format for `restricting_date_start`."),
                  logfile = rv$log$logfile_dir,
                  type = "Error",
                  findme = "608ce7e278"
                )
                stop("See above.")
              }

              ## Check the end date:
              if (is.na(restricting_date_end_posixct)) {
                DIZutils::feedback(
                  print_this = paste0(
                    "Couldn't identify input date format for ",
                    " `restricting_date_end`.",
                    " Using current timestamp now."
                  ),
                  logfile = rv$log$logfile_dir,
                  type = "Error",
                  findme = "c3cce12c26"
                )
                stop("See above.")
                restricting_date_end_posixct <- as.POSIXct(Sys.time())
              }

              ## Check if start < end:
              if (restricting_date_end_posixct <=
                  restricting_date_start_posixct) {
                DIZutils::feedback(
                  print_this = paste0(
                    "`restricting_date_start` needs to be a timestamp",
                    " before `restricting_date_end`.",
                    "'",
                    restricting_date_start_posixct,
                    "' !< '",
                    restricting_date_end_posixct,
                    "'. ",
                    " Please change."
                  ),
                  logfile = rv$log$logfile_dir,
                  type = "Error",
                  findme = "4380e1d4a3"
                )
                stop("See above.")
              }

              rv$restricting_date$use_it <- TRUE
              rv$restricting_date$start <-
                restricting_date_start_posixct
              rv$restricting_date$end <- restricting_date_end_posixct

              DIZutils::feedback(
                print_this = paste0(
                  "Time contstraints from ",
                  rv$restricting_date$start,
                  " to ",
                  rv$restricting_date$end,
                  " will be applied to input data."
                ),
                logfile = rv$log$logfile_dir,
                findme = "2403fb1aa3"
              )
            }

            if (rv$restricting_date$use_it) {
              ## Check if the MDR contains valid information
              ## about the time restrictions:
              DQAstats::check_date_restriction_requirements(
                mdr = rv$mdr,
                system_names = c(rv$source$system_name, rv$target$system_name),
                # restricting_date = rv$restricting_date,
                logfile_dir = rv$log$logfile_dir,
                enable_stop = FALSE
              )
            } else {
              DIZutils::feedback(
                print_this = paste0(
                  "Don't checking the time filtering columns because",
                  " time filtering is not necessarry.",
                  " (`rv$restricting_date$use_it` is not TRUE)."
                ),
                logfile = rv$log$logfile_dir,
                findme = "3aaad06b31"
              )
            }

            selection_intersect <-
              input_re()[["moduleConfig-select_dqa_assessment_variables"]]

            intersect_keys <-
              rv$dqa_assessment[get("designation") %in% selection_intersect,
                                get("key")]

            reactive_to_append <- DQAstats::create_helper_vars(
              mdr = rv$mdr[get("key") %in% intersect_keys, ],
              target_db = rv$target$system_name,
              source_db = rv$source$system_name
            )

            # workaround, to keep "rv" an reactiveValues object in shiny app
            #% (rv <- c(rv, reactive_to_append)) does not work!
            for (i in names(reactive_to_append)) {
              rv[[i]] <- reactive_to_append[[i]]
            }
            rm(reactive_to_append)
            invisible(gc())


            # set start_time (e.g. when clicking
            # the 'Load Data'-button in shiny
            rv$start_time <- format(Sys.time(), usetz = TRUE, tz = "CET")

            waiter::waiter_update(html = shiny::tagList(
              waiter::spin_timer(),
              "Loading source data ..."))

            ## load source data:
            temp_dat <- DQAstats::data_loading(
              rv = rv,
              system = rv$source,
              keys_to_test = rv$keys_source
            )
            rv$data_source <- temp_dat$outdata
            rv$source$sql <- temp_dat$sql_statements
            rm(temp_dat)
            invisible(gc())

            # set flag that we have all data
            rv$getdata_source <- FALSE

            waiter::waiter_update(html = shiny::tagList(
              waiter::spin_timer(),
              "Loading target data ..."))

            ## load target_data
            if (isTRUE(rv$target_is_source)) {
              DIZutils::feedback(
                print_this = paste0(
                  "Source and Target settings are identical.",
                  " Using source data also as target data."
                ),
                findme = "f80e1639a4",
                logfile = rv$log$logfile_dir
              )
              # Assign source-values to target:
              rv <- set_target_equal_to_source(rv)
              rv$data_target <- rv$data_source
            } else {
              DIZutils::feedback(
                print_this = paste0(
                  "Source and Target settings are NOT identical.",
                  " Loading the target dataset now."
                ),
                findme = "d5b5d90aec",
                logfile = rv$log$logfile_dir
              )
              ## load target
              temp_dat <- DQAstats::data_loading(
                rv = rv,
                system = rv$target,
                keys_to_test = rv$keys_target
              )
              rv$data_target <- temp_dat$outdata
              rv$target$sql <- temp_dat$sql_statements
              rm(temp_dat)
              invisible(gc())
            }

            # set flag that we have all data
            rv$getdata_target <- FALSE

            waiter::waiter_update(html = shiny::tagList(
              waiter::spin_timer(),
              "Applying plausibility checks ..."
            ))

            if (nrow(rv$pl$atemp_vars) != 0 && rv$pl$atemp_possible) {
              # get atemporal plausibilities
              rv$data_plausibility$atemporal <-
                DQAstats::get_atemp_plausis(
                  rv = shiny::reactiveValuesToList(rv),
                  atemp_vars = rv$pl$atemp_vars,
                  mdr = rv$mdr,
                  headless = rv$headless
                )


              # add the plausibility raw data to data_target and data_source
              for (i in names(rv$data_plausibility$atemporal)) {
                for (k in c("source_data", "target_data")) {
                  w <- gsub("_data", "", k)
                  raw_data <- paste0("data_", w)
                  rv[[raw_data]][[i]] <-
                    rv$data_plausibility$atemporal[[i]][[k]][[raw_data]]
                  rv$data_plausibility$atemporal[[i]][[k]][[raw_data]] <-
                    NULL
                }
                gc()
              }
            }


            # calculate descriptive results
            rv$results_descriptive <-
              DQAstats::descriptive_results(
                rv = shiny::reactiveValuesToList(rv),
                headless = rv$headless)

            if (!is.null(rv$data_plausibility$atemporal)) {
              # calculate plausibilites
              rv$results_plausibility_atemporal <-
                DQAstats::atemp_plausi_results(
                  rv = shiny::reactiveValuesToList(rv),
                  atemp_vars = rv$data_plausibility$atemporal,
                  mdr = rv$mdr,
                  headless = rv$headless
                )
            }

            if (nrow(rv$pl$uniq_vars) != 0 && rv$pl$uniq_possible) {
              rv$results_plausibility_unique <- DQAstats::uniq_plausi_results(
                rv = shiny::reactiveValuesToList(rv),
                uniq_vars = rv$pl$uniq_vars,
                mdr = rv$mdr,
                headless = rv$headless
              )
            }

            # conformance
            rv$conformance$value_conformance <-
              DQAstats::value_conformance(
                rv = shiny::reactiveValuesToList(rv),
                scope = "descriptive",
                results = rv$results_descriptive,
                logfile_dir = rv$log$logfile_dir,
                headless = rv$headless
              )

            waiter::waiter_update(
              html = shiny::tagList(waiter::spin_timer(),
              "Cleaning the result data ..."))

            # delete raw data but atemporal plausis (we need them until
            # ids of errorneous cases are returend in value conformance)
            if (nrow(rv$pl$atemp_vars) > 0) {
              rv$data_source <-
                rv$data_source[names(rv$data_plausibility$atemporal)]
              rv$data_target <-
                rv$data_target[names(rv$data_plausibility$atemporal)]
            } else {
              rv$data_source <- NULL
              rv$data_target <- NULL
            }
            invisible(gc())


            # reduce categorical variables to display max. 25 values
            rv$results_descriptive <-
              DQAstats::reduce_cat(data = rv$results_descriptive,
                                   levellimit = 25)
            invisible(gc())

            if (!is.null(rv$results_plausibility_atemporal)) {
              add_value_conformance <- DQAstats::value_conformance(
                rv = shiny::reactiveValuesToList(rv),
                scope = "plausibility",
                results = rv$results_plausibility_atemporal,
                logfile_dir = rv$log$logfile_dir,
                headless = rv$headless
              )

              # workaround, to keep "rv" an reactiveValues object in shiny app
              for (i in names(add_value_conformance)) {
                rv$conformance$value_conformance[[i]] <-
                  add_value_conformance[[i]]
              }

              rm(add_value_conformance)
              rv$data_source <- NULL
              rv$data_target <- NULL
              invisible(gc())
            }
            # completeness
            rv$completeness <-
              DQAstats::completeness(
                results = rv$results_descriptive,
                logfile_dir = rv$log$logfile_dir,
                headless = rv$headless
              )

            # generate datamap
            rv$datamap <- DQAstats::generate_datamap(
              results = rv$results_descriptive,
              db = rv$target$system_name,
              mdr = rv$mdr,
              rv = rv,
              headless = rv$headless
            )

            if (!is.null(rv$datamap)) {
              DIZutils::feedback(print_this = paste0(
                "Datamap:", rv$datamap),
                findme = "43404a3f38")
            }

            # checks$value_conformance
            rv$checks$value_conformance <-
              DQAstats::value_conformance_checks(
                results = rv$conformance$value_conformance)

            # checks$etl
            rv$checks$etl <-
              DQAstats::etl_checks(results = rv$results_descriptive)

            # set flag to create report here
            rv$create_report <- TRUE
          }
        }, error = function(cond) {
          DIZutils::feedback(
            print_this = paste0(cond),
            findme = "32b84ec323",
            type = "Error",
            logfile_dir = rv$log$logfile_dir
          )
          ## Trigger the modal for the user/UI:
          rv$error <- TRUE
          show_failure_alert(
            paste0(
              "Executing the script to load all the data",
              " from source and target system failed"
            )
          )
          rv$start <- NULL
        })
        waiter::waiter_hide()
        print_runtime(
          start_time = start_time,
          name = "module_dashboard_server -> rv$start",
          logfile_dir = rv$log$logfile_dir
        )
      } else {
        rv$start <- NULL
      }
    })


    # observe for load data button
    observe({
      if (!is.null(rv$db_con_target)) {
        shinyjs::hide("dash_instruction")
        return(TRUE)
      }
    })


    # render dashboard summary
    observe({
      req(rv$datamap$target_data)

      output$dash_datamap_target <- renderUI({
        outlist <- list(
          h5(tags$b(paste0("System name: ", rv$target$system_name))),
          tags$hr(),
          tableOutput("moduleDashboard-dash_datamap_target_tbl")
        )
        do.call(tagList, outlist)
      })

      output$dash_datamap_target_tbl <- renderTable({
        tab <- rv$datamap$target_data
        colnames(tab) <-
          c("Variable", "# n", "# Valid", "# Missing", "# Distinct")
        tab
      })
    })

    observe({
      req(rv$datamap$source_data)

      output$dash_datamap_source <- renderUI({
        outlist <- list(
          h5(tags$b(paste0("System name: ", rv$source$system_name))),
          tags$hr(),
          tableOutput("moduleDashboard-dash_datamap_source_tbl")
        )
        do.call(tagList, outlist)
      })

      output$dash_datamap_source_tbl <- renderTable({
        tab <- rv$datamap$source_data
        colnames(tab) <-
          c("Variable", "# n", "# Valid", "# Missing", "# Distinct")
        tab
      })
    })

    observe({
      req(rv$aggregated_exported)

      # workaround to tell ui, that db_connection is there
      output$etl_results <- reactive({
        return(TRUE)
      })
      outputOptions(output, "etl_results", suspendWhenHidden = FALSE)

      output$dash_quick_etlchecks <- DT::renderDataTable({
        render_quick_checks(rv$checks$etl)
      })
    })

    observe({
      req(rv$aggregated_exported)

      # workaround to tell ui, that db_connection is there
      output$valueconformance_results <- reactive({
        return(TRUE)
      })
      outputOptions(output,
                    "valueconformance_results",
                    suspendWhenHidden = FALSE)

      output$dash_quick_val_conf_checks <-
        DT::renderDataTable({
          render_quick_checks(rv$checks$value_conformance)
        })
    })

    # observe rv$duration
    observe({
      req(rv$duration)
      output$dash_instruction <- renderText({
        paste0(
          "Started: ",
          rv$start_time,
          "\nFinished: ",
          rv$end_time,
          "\nDuration: ",
          round(rv$duration, 2),
          " min."
        )
      })
      shinyjs::show("dash_instruction")
    })
  }


#' @title module_dashboard_ui
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
#'     tabName = "dashboard",
#'     module_dashboard_ui(
#'       "moduleDashboard"
#'     )
#'   )
#' )
#' }
#'
#' @export
#'
# module_dashboard_ui
module_dashboard_ui <- function(id) {
  ns <- NS(id)

  tagList(fluidRow(
    waiter::use_waiter(),
    box(
      title = "Welcome to your Data-Quality-Analysis Dashboard",
      verbatimTextOutput(ns("dash_instruction")),
      width = 12
    ),
    column(
      6,
      conditionalPanel(
        condition = "output['moduleDashboard-etl_results']",
        box(
          title = "Completeness Checks (Validation): ",
          helpText(
            paste0(
              "Completeness checks (validation) evaluate the ",
              "'correctness' of the ETL (extract transform load) jobs. ",
              "They compare for each variable the exact matching ",
              "of the number of distinct values, the number of ",
              "valid values, and the number of missing values ",
              "between the source data system and the target data system."
            )
          ),
          DT::dataTableOutput(ns("dash_quick_etlchecks")),
          width = 12
        )
      ),
      conditionalPanel(
        condition = "output['moduleDashboard-valueconformance_results']",
        box(
          title = "Value Conformance Checks (Verification): ",
          helpText(
            paste0(
              "Value conformance checks (verification) compare for ",
              "each variable the values of each data system to ",
              "predefined constraints. Those constraints can be ",
              "defined for each variable and data system individually ",
              "in the metadata repository (MDR)."
            )
          ),
          DT::dataTableOutput(ns("dash_quick_val_conf_checks")),
          width = 12
        )
      )
    ),
    column(
      6,
      conditionalPanel(
        condition = "output['moduleDashboard-etl_results']",
        box(
          title = "Target System Overview (Data Map)",
          uiOutput(ns("dash_datamap_target")),
          tags$hr(),
          actionButton(
            ns("dash_send_datamap_btn"),
            "Send Datamap",
            icon = icon("server")
          ),
          width = 12
        ),
        box(
          title = "Source System Overview",
          uiOutput(ns("dash_datamap_source")),
          width = 12
        )
      )
    )
  ))
}
