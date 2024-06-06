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


#' @title module_config_server
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
#'   module_config_server,
#'   "moduleConfig",
#'   rv = rv,
#'   input_re = reactive(input)
#' )
#' }
#'
#' @export
#'
# module_config_server
module_config_server <-
  function(input, output, session, rv, input_re) {
    # filepath roots dir
    roots <- c(
      # home = "/home/",
      home = "~",
      source = Sys.getenv("CSV_SOURCE_BASEPATH"),
      target = Sys.getenv("CSV_TARGET_BASEPATH")
    )


    ## Mapping between system_type and tab_name:
    system_types_mapping <-
      list("postgres" = "PostgreSQL",
           "csv" = "CSV",
           "oracle" = "Oracle")

    # If source-csv-path-button is clicked, read the path and save it:
    # root-folder of shinyFiles::shinyDirChoose
    shinyFiles::shinyDirChoose(
      input = input,
      id = "config_sourcedir_in",
      roots = roots,
      defaultRoot = ifelse(roots[["source"]] == "", "home", "source"),
      allowDirCreate = FALSE,
      session = session
    )

    shinyFiles::shinyDirChoose(
      input = input,
      id = "config_targetdir_in",
      roots = roots,
      defaultRoot = ifelse(roots[["target"]] == "", "home", "target"),
      allowDirCreate = FALSE,
      session = session
    )

    # observe click button event
    observeEvent(
      eventExpr = input$config_sourcedir_in,
      ignoreInit = TRUE,
      ignoreNULL = TRUE,
      handlerExpr = {
        rv$csv_dir_src_clicked <- FALSE
        rv$csv_dir_src <- as.character(
          DIZtools::clean_path_name(
            shinyFiles::parseDirPath(
              roots = roots,
              selection = input$config_sourcedir_in
            )))

        rv$source$settings$path <- rv$csv_dir_src

        if (!identical(rv$source$settings$path, character(0)) &&
            !is.null(rv$source$settings$path) &&
            rv$source$settings$path != "") {
          # workaround to tell ui, that it is there
          output$source_csv_dir <- reactive({
            DIZtools::feedback(
              paste0("Source file dir: ",
                     rv$source$settings$path),
              findme = "ad440c9fcb",
              logfile_dir = rv$log$logfile_dir,
              headless = rv$headless
            )
            paste(rv$source$settings$path)
          })
          outputOptions(output, "source_csv_dir", suspendWhenHidden = FALSE)
          rv$source$system_name <-
            input_re()[["moduleConfig-source_csv_presettings_list"]]
          rv$source$system_type <- "csv"

          ## Fixes #42 (GitLab):
          env_var_name <-
            paste0(toupper(rv$source$system_name), "_PATH")
          DIZtools::feedback(
            print_this = paste0(
              "CSV path '",
              rv$source$settings$path,
              "' was assigned in the GUI.",
              " Assigning it to the environment variable '",
              env_var_name,
              "' now."
            ),
            findme = "272f922ab2",
            logfile_dir = rv$log$logfile_dir,
            headless = rv$headless
          )
          ## Setting the path as environment variable (this must be done via
          ## `do.call` because otherwise the name `env_var_name` will
          ## become the name of the env-var and not its value.
          ## Sys.setenv(env_var_name = rv$source$settings$path) leads to
          ## `env_var_name = "path"` be created and not
          ## `example_name = "path"`):
          DIZtools::setenv2(key = env_var_name, val = rv$source$settings$path)
          rm(env_var_name)

          DIZtools::feedback(
            paste0("rv$source$system_type = ",
                   rv$source$system_type),
            findme = "91ebdd5a1d")
          output$source_system_feedback_txt <-
            renderText({
              feedback_txt(system = "CSV", type = "source")
            })
        }
        check_load_data_button(rv, session)
      }
    )
    observeEvent(
      eventExpr = input$config_targetdir_in,
      ignoreInit = TRUE,
      ignoreNULL = TRUE,
      handlerExpr = {
        rv$csv_dir_tar_clicked <- FALSE
        rv$csv_dir_tar <- as.character(
          DIZtools::clean_path_name(
            shinyFiles::parseDirPath(
              roots = roots,
              selection = input$config_targetdir_in
            )))
        rv$target$settings$path <- rv$csv_dir_tar

        if (!identical(rv$target$settings$path, character(0)) &&
            !is.null(rv$target$settings$path) &&
            rv$target$settings$path != "") {
          # workaround to tell ui, that it is there
          output$target_csv_dir <- reactive({
            DIZtools::feedback(
              paste0("Target file dir: ",
                     rv$target$settings$path),
              findme = "6f18c181e5",
              logfile_dir = rv$log$logfile_dir,
              headless = rv$headless
            )
            paste(rv$target$settings$path)
          })
          outputOptions(output, "target_csv_dir", suspendWhenHidden = FALSE)
          rv$target$system_name <-
            input_re()[["moduleConfig-target_csv_presettings_list"]]
          rv$target$system_type <- "csv"

          ## Fixes #42 (GitLab):
          env_var_name <-
            paste0(toupper(rv$target$system_name), "_PATH")
          DIZtools::feedback(
            print_this = paste0(
              "CSV path '",
              rv$target$settings$path,
              "' was assigned in the GUI.",
              " Assigning it to the environment variable '",
              env_var_name,
              "' now."
            ),
            findme = "fe2b85dc3c",
            logfile_dir = rv$log$logfile_dir,
            headless = rv$headless
          )
          ## Setting the path as environment variable (this must be done via
          ## `do.call` because otherwise the name `env_var_name` will
          ## become the name of the env-var and not its value.
          ## Sys.setenv(env_var_name = rv$target$settings$path) leads to
          ## `env_var_name = "path"` be created and not
          ## `example_name = "path"`):
          DIZtools::setenv2(key = env_var_name, val = rv$target$settings$path)
          rm(env_var_name)

          DIZtools::feedback(
            paste0("rv$target$system_type = ",
                   rv$target$system_type),
            findme = "4690c52739")
          output$target_system_feedback_txt <-
            renderText({
              feedback_txt(system = "CSV", type = "target")
            })
        }
        check_load_data_button(rv, session)
      }
    )

    # load mdr
    observeEvent(
      eventExpr = input_re()[["moduleConfig-config_load_mdr"]],
      handlerExpr = {
        if (is.null(rv$mdr)) {
          DIZtools::feedback(
            print_this = "Reading MDR ...",
            findme = "f877fee7d2",
            logfile_dir = rv$log$logfile_dir,
            headless = rv$headless
          )
          DIZtools::feedback(
            print_this = paste0("MDR-Filename:",
                                rv$mdr_filename),
            findme = "582d6a39c6",
            logfile_dir = rv$log$logfile_dir,
            headless = rv$headless
          )
          DIZtools::feedback(
            print_this = paste0("rv$utilspath:",
                                rv$utilspath),
            findme = "b5c71849f9",
            logfile_dir = rv$log$logfile_dir,
            headless = rv$headless
          )

          mdr_sql_list <- button_mdr(
            utils_path = rv$utilspath,
            mdr_filename = rv$mdr_filename,
            logfile_dir = rv$log$logfile_dir,
            headless = rv$headless
          )
          rv$mdr <- mdr_sql_list$mdr
          rv$sql_statements <- mdr_sql_list$sqls
          stopifnot(data.table::is.data.table(rv$mdr))

          ## Read in the settings
          # - Determine the different systems from mdr:
          vec <-
            c("source_system_name",
              "source_system_type")
          rv$systems <- unique(rv$mdr[, vec, with = FALSE])
          rv$systems <- rv$systems[!is.na(get("source_system_name"))]
          DIZtools::feedback(
            print_this = paste0(
              "Different databases found in the MDR: ",
              paste(unique(rv$systems[["source_system_name"]]),
                    collapse = ", ")
            ),
            findme = "4451da82ad",
            logfile_dir = rv$log$logfile_dir,
            headless = rv$headless
          )

          # - Read the settings for all these systems:
          unique_systems <-
            rv$systems[!is.na(get("source_system_name")),
                       unique(get("source_system_name"))]

          # FIXME remove settings reading in the future
          settings_pattern <- paste0(
            "^%s_(\\d+_)?DBNAME$"
          )

          rv$settings <-
            sapply(
              X = unique_systems,
              FUN = function(sys_name) {
                grep_res <- grepl(
                  pattern = sprintf(settings_pattern, toupper(sys_name)),
                  x = names(Sys.getenv())
                )
                if (sum(grep_res) > 1) {
                  env_res <- names(Sys.getenv())[grep_res]
                  include_pattern <- paste0(
                    "^%s_(\\d+_)DBNAME$"
                  )
                  subsystems <- env_res[grepl(
                    pattern = sprintf(include_pattern, toupper(sys_name)),
                    x = env_res
                  )]
                  subsystems <- gsub(
                    pattern = "_DBNAME$",
                    replacement = "",
                    x = subsystems
                  )
                  ret <- lapply(X = subsystems, FUN = get_from_env)
                  ret[["nested"]] <- TRUE
                  return(ret)
                } else {
                  return(get_from_env(sys_name))
                }
              },
              USE.NAMES = TRUE,
              simplify = FALSE
            )


          ## Create mapping for display names:
          rv$displaynames <- data.table::data.table(
            "source_system_name" = character(),
            "displayname" = character())

          for (system_name_tmp in names(rv$settings)) {
            rv$displaynames <- data.table::rbindlist(list(
              rv$displaynames,
              list(
                "source_system_name" = system_name_tmp,
                "displayname" =
                  get_display_name_from_settings(settings = rv$settings,
                                                 prefilter = system_name_tmp)
              )
            ), use.names = TRUE)
          }

          # - Different system-types:
          rv$system_types <-
            rv$systems[!is.na(get("source_system_type")),
                       unique(get("source_system_type"))]

          DIZtools::feedback(
            print_this = rv$system_types,
            prefix = "System types:  ",
            findme = "9aec84fcca",
            logfile_dir = rv$log$logfile_dir,
            headless = rv$headless
          )
          if (!("csv" %in% tolower(rv$system_types))) {
            # Remove CSV-Tabs:
            DIZtools::feedback(
              "Removing csv-tab from source ...",
              findme = "3c2f368001",
              logfile_dir = rv$log$logfile_dir,
              headless = rv$headless
            )
            shiny::removeTab(inputId = "source_tabs",
                             target = system_types_mapping[["csv"]])

            DIZtools::feedback(
              "Removing csv-tab from target ...",
              findme = "337b20a126",
              logfile_dir = rv$log$logfile_dir,
              headless = rv$headless
            )
            shiny::removeTab(inputId = "target_tabs",
                             target = system_types_mapping[["csv"]])
          } else {
            csv_system_names <-
              rv$systems[get("source_system_type") == "csv" &
                           !is.na(get("source_system_name")),
                         unique(get("source_system_name"))]
            DIZtools::feedback(
              paste0(csv_system_names, collapse = ", "),
              prefix = "csv_system_names: ",
              findme = "5a083a3d53",
              logfile_dir = rv$log$logfile_dir,
              headless = rv$headless
            )

            csv_system_names <-
              rv$displaynames[get("source_system_name") %in%
                                csv_system_names, get("displayname")] %>%
              unlist(use.names = FALSE)

            if (length(csv_system_names) > 0) {
              # Show buttons to prefill diff. systems presettings:
              # - Add a button/choice/etc. for each system:
              shiny::updateSelectInput(
                session = session,
                inputId = "source_csv_presettings_list",
                choices = csv_system_names,
                selected = unlist(ifelse(
                  test = isTRUE(rv$demo_usage),
                  yes = csv_system_names[[1]],
                  no = list(NULL)
                ))
              )
              shiny::updateSelectInput(
                session = session,
                inputId = "target_csv_presettings_list",
                choices = csv_system_names,
                selected = unlist(ifelse(
                  test = isTRUE(rv$demo_usage),
                  yes = csv_system_names[[2]],
                  no = list(NULL)
                ))
              )
            }
          }
          if (!("postgres" %in% tolower(rv$system_types))) {
            # Remove Postgres-Tabs:
            DIZtools::feedback(
              "Removing postgres-tab from source ...",
              logfile_dir = rv$log$logfile_dir,
              headless = rv$headless
            )
            shiny::removeTab(inputId = "source_tabs",
                             target = system_types_mapping[["postgres"]])

            DIZtools::feedback(
              "Removing postgres-tab from target ...",
              logfile_dir = rv$log$logfile_dir,
              headless = rv$headless
            )
            shiny::removeTab(inputId = "target_tabs",
                             target = system_types_mapping[["postgres"]])
          } else {
            # Fill the tab with presettings
            # - filter for all system_names with
            #% system_type == postgres
            #% select source_system_name from
            #% rv$systems where source_system_type == postgres
            #% GROUP BY source_system_name
            postgres_system_names <-
              rv$systems[get("source_system_type") == "postgres" &
                           !is.na(get("source_system_name")), ] %>%
              .[["source_system_name"]] %>%
              unique()
            DIZtools::feedback(
              print_this = paste(postgres_system_names, collapse = ", "),
              prefix = "postgres_system_names: ",
              findme = "be136f5ab6",
              logfile_dir = rv$log$logfile_dir,
              headless = rv$headless
            )

            postgres_system_names <-
              rv$displaynames[get("source_system_name") %in%
                                postgres_system_names, ][["displayname"]] %>%
              unlist(use.names = FALSE)

            if (length(postgres_system_names) > 0) {
              # Show buttons to prefill diff. systems presettings:
              # - Add a button/choice/etc. for each system:
              shiny::updateSelectInput(session = session,
                                inputId = "source_postgres_presettings_list",
                                choices = postgres_system_names)
              shiny::updateSelectInput(session = session,
                                inputId = "target_postgres_presettings_list",
                                choices = postgres_system_names)
            }
          }
          if (!("oracle" %in% tolower(rv$system_types))) {
            # Remove Oracle-Tabs:
            DIZtools::feedback(
              "Removing oracle-tab from source ...",
              logfile_dir = rv$log$logfile_dir,
              headless = rv$headless,
              findme = "8e93367dec"
            )
            shiny::removeTab(inputId = "source_tabs",
                             target = system_types_mapping[["oracle"]])

            DIZtools::feedback(
              "Removing oracle-tab from target ...",
              logfile_dir = rv$log$logfile_dir,
              headless = rv$headless,
              findme = "1c2023da56"
            )
            shiny::removeTab(inputId = "target_tabs",
                             target = system_types_mapping[["oracle"]])
          } else {
            # Fill the tab with presettings
            # - filter for all system_names with
            #% system_type == oracle
            #% select source_system_name from
            #% rv$systems where source_system_type == oracle
            #% GROUP BY source_system_name
            oracle_system_names <-
              rv$systems[get("source_system_type") == "oracle" &
                           !is.na(get("source_system_name")), ] %>%
              .[["source_system_name"]] %>%
              unique()

            DIZtools::feedback(
              oracle_system_names,
              prefix = "oracle_system_names: ",
              findme = "bea2cd91a1",
              logfile_dir = rv$log$logfile_dir,
              headless = rv$headless
            )

            oracle_system_names <-
              rv$displaynames[get("source_system_name") %in%
                                oracle_system_names, ][["displayname"]] %>%
              unlist(use.names = FALSE)

            if (length(oracle_system_names) > 0) {
              # Show buttons to prefill diff. systems presettings:
              # - Add a button/choice/etc. for each system:
              updateSelectInput(session = session,
                                inputId = "source_oracle_presettings_list",
                                choices = oracle_system_names)
              updateSelectInput(session = session,
                                inputId = "target_oracle_presettings_list",
                                choices = oracle_system_names)
            }
          }

          first_system <- tolower(rv$system_types)[[1]]
          DIZtools::feedback(
            print_this = paste0("Setting tab '",
                                first_system,
                                "' as active tab for source",
                                " and target on config page."),
            findme = "46c03705a8",
            logfile_dir = rv$log$logfile_dir
          )
          shiny::updateTabsetPanel(
            session = session,
            inputId = "source_tabs",
            selected = system_types_mapping[[first_system]])
          shiny::updateTabsetPanel(
            session = session,
            inputId = "target_tabs",
            selected = system_types_mapping[[first_system]])


          # Store the system-types in output-variable to only
          # show these tabs on the config page:
          output$system_types <- reactive({
            rv$system_types
          })
          outputOptions(output,
                        "system_types",
                        suspendWhenHidden = FALSE)

          # workaround to tell ui, that mdr is there
          output$mdr_present <- reactive({
            return(TRUE)
          })
          outputOptions(output,
                        "mdr_present",
                        suspendWhenHidden = FALSE)

          # workaround to tell ui, that mdr is there
          output$source_system_type <- reactive({
            return(input_re()
                   [["moduleConfig-config_source_system_type"]])
          })
          outputOptions(output,
                        "source_system_type",
                        suspendWhenHidden = FALSE)
          output$source_system_feedback_txt <-
            renderText({
              "\U26A0 Please select a source database to load the data."
            })
        }
        check_load_data_button(rv, session)
      })


    # If the "load presets"-button was pressed, startload & show the presets:
    # observeEvent(input$source_pg_presettings_btn, {
    observeEvent(input$source_postgres_presettings_list, {
      DIZtools::feedback(
        print_this =
          paste0(
            "Input-preset '",
            input$source_postgres_presettings_list,
            "' was chosen as SOURCE.",
            " Loading presets ..."
          ),
        findme = "e9832b3092",
        logfile_dir = rv$log$logfile_dir,
        headless = rv$headless
      )
      config_stuff <-
        rv$settings[[tolower(input$source_postgres_presettings_list)]]
      config_stuff <-
        get_settings_from_displayname(
          displayname = input$source_postgres_presettings_list,
          settings = rv$settings
        )

      DIZtools::feedback(
        print_this = paste(
          "Loaded successfully.",
          "Filling presets to global rv-object and UI ..."
        ),
        findme = "3c9136d49f",
        logfile_dir = rv$log$logfile_dir,
        headless = rv$headless
      )
      if (length(config_stuff) != 0) {
        updateTextInput(session = session,
                        inputId = "config_source_postgres_dbname",
                        value = config_stuff[["dbname"]])
        updateTextInput(session = session,
                        inputId = "config_source_postgres_host",
                        value = config_stuff[["host"]])
        updateTextInput(session = session,
                        inputId = "config_source_postgres_port",
                        value = config_stuff[["port"]])
        updateTextInput(session = session,
                        inputId = "config_source_postgres_user",
                        value = config_stuff[["user"]])
        updateTextInput(session = session,
                        inputId = "config_source_postgres_password",
                        value = config_stuff[["password"]])
      } else {
        updateTextInput(session = session,
                        inputId = "config_source_postgres_dbname",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_source_postgres_host",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_source_postgres_port",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_source_postgres_user",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_source_postgres_password",
                        value = "")
      }
      updateActionButton(
        session = session,
        inputId = "source_postgres_test_connection",
        label = "Test & Save connection",
        icon = icon("database")
      )
      shinyjs::enable("source_postgres_test_connection")
    })

    observeEvent(input$source_oracle_presettings_list, {
      DIZtools::feedback(
        print_this =
          paste0(
            "Input-preset ",
            input$source_oracle_presettings_list,
            " was chosen as SOURCE.",
            " Loading presets ..."
          ),
        findme = "44179e7b1f",
        logfile_dir = rv$log$logfile_dir,
        headless = rv$headless
      )
      config_stuff <-
        get_settings_from_displayname(
          displayname = input$source_oracle_presettings_list,
          settings = rv$settings
        )

      DIZtools::feedback(
        print_this = paste(
          "Loaded successfully.",
          "Filling presets to global rv-object and UI ..."
        ),
        findme = "ff874cb58d",
        logfile_dir = rv$log$logfile_dir,
        headless = rv$headless
      )
      if (length(config_stuff) != 0) {
        updateTextInput(session = session,
                        inputId = "config_source_oracle_dbname",
                        value = config_stuff[["dbname"]])
        updateTextInput(session = session,
                        inputId = "config_source_oracle_host",
                        value = config_stuff[["host"]])
        updateTextInput(session = session,
                        inputId = "config_source_oracle_port",
                        value = config_stuff[["port"]])
        updateTextInput(session = session,
                        inputId = "config_source_oracle_user",
                        value = config_stuff[["user"]])
        updateTextInput(session = session,
                        inputId = "config_source_oracle_password",
                        value = config_stuff[["password"]])
        updateTextInput(session = session,
                        inputId = "config_source_oracle_sid",
                        value = config_stuff[["sid"]])
      } else {
        updateTextInput(session = session,
                        inputId = "config_source_oracle_dbname",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_source_oracle_host",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_source_oracle_port",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_source_oracle_user",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_source_oracle_password",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_source_oracle_sid",
                        value = "")
      }
      updateActionButton(
        session = session,
        inputId = "source_oracle_test_connection",
        label = "Test & Save connection",
        icon = icon("database")
      )
      shinyjs::enable("source_oracle_test_connection")
    })


    #observeEvent(input$target_pg_presettings_btn, {
    observeEvent(input$target_postgres_presettings_list, {
      DIZtools::feedback(
        paste0(
          "Input-preset ",
          input$target_postgres_presettings_list,
          " was chosen as TARGET.",
          " Loading presets ..."
        ),
        findme = "d603f8127a",
        logfile_dir = rv$log$logfile_dir,
        headless = rv$headless
      )
      # config_stuff <-
      config_stuff <-
        get_settings_from_displayname(
          displayname = input$target_postgres_presettings_list,
          settings = rv$settings
        )

      DIZtools::feedback(
        paste(
          "Loaded successfully.",
          "Filling presets to global rv-object and UI ..."
        ),
        findme = "fa908f0035",
        logfile_dir = rv$log$logfile_dir,
        headless = rv$headless
      )
      if (length(config_stuff) != 0) {
        updateTextInput(session = session,
                        inputId = "config_target_postgres_dbname",
                        value = config_stuff[["dbname"]])
        updateTextInput(session = session,
                        inputId = "config_target_postgres_host",
                        value = config_stuff[["host"]])
        updateTextInput(session = session,
                        inputId = "config_target_postgres_port",
                        value = config_stuff[["port"]])
        updateTextInput(session = session,
                        inputId = "config_target_postgres_user",
                        value = config_stuff[["user"]])
        updateTextInput(session = session,
                        inputId = "config_target_postgres_password",
                        value = config_stuff[["password"]])
      } else {
        updateTextInput(session = session,
                        inputId = "config_target_postgres_dbname",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_target_postgres_host",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_target_postgres_port",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_target_postgres_user",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_target_postgres_password",
                        value = "")
      }
      updateActionButton(
        session = session,
        inputId = "target_postgres_test_connection",
        label = "Test & Save connection",
        icon = icon("database")
      )
      shinyjs::enable("target_postgres_test_connection")
    })

    observeEvent(input$target_oracle_presettings_list, {
      DIZtools::feedback(
        paste0(
          "Input-preset ",
          input$target_oracle_presettings_list,
          " was chosen as TARGET.",
          " Loading presets ..."
        ),
        findme = "1156504e13",
        logfile_dir = rv$log$logfile_dir,
        headless = rv$headless
      )
       # config_stuff <-
      config_stuff <-
        get_settings_from_displayname(
          displayname = input$target_oracle_presettings_list,
          settings = rv$settings
        )

      DIZtools::feedback(
        paste(
          "Loaded successfully.",
          "Filling presets to global rv-object and UI ..."
        ),
        findme = "3d39553c3c",
        logfile_dir = rv$log$logfile_dir,
        headless = rv$headless
      )
      if (length(config_stuff) != 0) {
        updateTextInput(session = session,
                        inputId = "config_target_oracle_dbname",
                        value = config_stuff[["dbname"]])
        updateTextInput(session = session,
                        inputId = "config_target_oracle_host",
                        value = config_stuff[["host"]])
        updateTextInput(session = session,
                        inputId = "config_target_oracle_port",
                        value = config_stuff[["port"]])
        updateTextInput(session = session,
                        inputId = "config_target_oracle_user",
                        value = config_stuff[["user"]])
        updateTextInput(session = session,
                        inputId = "config_target_oracle_password",
                        value = config_stuff[["password"]])
        updateTextInput(session = session,
                        inputId = "config_target_oracle_sid",
                        value = config_stuff[["sid"]])
      } else {
        updateTextInput(session = session,
                        inputId = "config_target_oracle_dbname",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_target_oracle_host",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_target_oracle_port",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_target_oracle_user",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_target_oracle_password",
                        value = "")
        updateTextInput(session = session,
                        inputId = "config_target_oracle_sid",
                        value = "")
      }
      updateActionButton(
        session = session,
        inputId = "target_oracle_test_connection",
        label = "Test & Save connection",
        icon = icon("database")
      )
      shinyjs::enable("target_oracle_test_connection")
    })


    observeEvent(input$source_postgres_test_connection, {
      test_connection_button_clicked(
        rv = rv,
        source_target = "source",
        db_type = "postgres",
        input = input,
        output = output,
        session = session
      )
    })

    observeEvent(input$source_oracle_test_connection, {
      test_connection_button_clicked(
        rv = rv,
        source_target = "source",
        db_type = "oracle",
        input = input,
        output = output,
        session = session
      )
    })

    observeEvent(input$target_postgres_test_connection, {
      test_connection_button_clicked(
        rv = rv,
        source_target = "target",
        db_type = "postgres",
        input = input,
        output = output,
        session = session
      )
    })

    observeEvent(input$target_oracle_test_connection, {
      test_connection_button_clicked(
        rv = rv,
        source_target = "target",
        db_type = "oracle",
        input = input,
        output = output,
        session = session
      )
    })


    observeEvent(input$target_system_to_source_system_btn, {
      if (isTRUE(input$target_system_to_source_system_btn)) {
        ## Target was != source and should become equal:
        # Hide target-setting-tabs:
        hideTab(inputId = "target_tabs", target = "CSV")
        hideTab(inputId = "target_tabs", target = "PostgreSQL")
        hideTab(inputId = "target_tabs", target = "Oracle")
        # Assign source-values to target:
        rv <- set_target_equal_to_source(rv)
        # Set internal flag that target == source:
        rv$target_is_source <- TRUE
        # Show feedback-box in the UI:
        output$target_system_feedback_txt <-
          renderText({
            feedback_txt(system = "The source database", type = "target")
          })
        # Feedback to the console:
        DIZtools::feedback(
          "Target == source now.",
          findme = "94d3a2090c",
          logfile_dir = rv$log$logfile_dir,
          headless = rv$headless
        )
      } else if (isFALSE(input$target_system_to_source_system_btn)) {
        ## Target was == source but should become different now:
        rv$target_is_source <- FALSE
        rv$target <- NULL
        output$target_system_feedback_txt <- NULL
        # Show target-settings-tabs again:
        showTab(inputId = "target_tabs", target = "CSV")
        showTab(inputId = "target_tabs", target = "PostgreSQL")
        showTab(inputId = "target_tabs", target = "Oracle")
        # Feedback to the console:
        DIZtools::feedback(
          "Target != source now.",
          findme = "ec51b122ee",
          logfile_dir = rv$log$logfile_dir,
          headless = rv$headless
        )
      }
      check_load_data_button(rv, session)
    })

    observe({
      if (is.null(rv$sitenames)) {
        # check, if user has provided custom site names
        rv$sitenames <- tryCatch({
          outlist <- jsonlite::fromJSON(
            paste0(rv$utilspath, "/MISC/sitenames.JSON")
          )
          outlist
        }, error = function(e) {
          outlist <- list("undefined" = "undefined")
          outlist
          # TODO instead of dropdown menu, render text input field in the
          # case, users have not provided sitenames. This allows them
          # to specify a name of the DQA session (which will be included
          # into the report's title)
        }, finally = function(f) {
          return(outlist)
        })

        updateSelectInput(
          session = session,
          inputId = "config_sitename",
          choices = rv$sitenames,
          selected = ifelse(
            test = !is.null(rv$sitename),
            yes = rv$sitename,
            no = ifelse(
              test = isTRUE(rv$demo_usage),
              yes = rv$sitenames[[1]],
              no = character(0)
            )
          )
        )
      }
    })

    observeEvent(input_re()[["moduleConfig-dash_load_btn"]], {
      tryCatch({
        ## For runtime calculation:
        start_time <- Sys.time()

        DIZtools::feedback(
          paste0(
            "Restricting date slider state: ",
            input$date_restriction_slider
          ),
          type = "Info",
          findme = "1dcsdfg37b8",
          logfile_dir = rv$log$logfile_dir,
          headless = rv$headless
        )
        rv$restricting_date$use_it <- input$date_restriction_slider

        # The button is on "moduleConfig".
        # This tab here will be set active below if all inputs are valid.

        # Error flag: If an error occurs, the flag will be set to true
        # and the main calculation won't start:
        error_tmp <- FALSE

        # check, if mdr is present. without mdr, we cannot perform any
        # further operations
        if (is.null(rv$mdr)) {
          DIZtools::feedback(
            "No MDR found. Please provide a metadata repository (MDR).",
            type = "Warning",
            findme = "1dc68937b8",
            logfile_dir = rv$log$logfile_dir,
            headless = rv$headless
          )
          error_tmp <- TRUE
          # mdr is present:
        } else {
          # check if sitename is present
          if (
            nchar(input_re()[["moduleConfig-config_sitename"]]) < 2 ||
            any(grepl("\\s", input_re()[["moduleConfig-config_sitename"]]))
          ) {
            msg <- paste0("There are no empty strings or spaces allowed in",
            " the site name configuration.",
            " Please select your site name."
            )
            DIZtools::feedback(
              print_this = msg,
              type = "Error",
              ui = FALSE,
              findme = "54362a3ab6",
              logfile_dir = rv$log$logfile_dir
            )
            # site name is missing:
            shiny::showModal(shiny::modalDialog(
              title = "The sitename is missing",
              paste0(msg)
            ))
            error_tmp <- TRUE
          } else {
            # site name is present:
            rv$sitename <-
              input_re()[["moduleConfig-config_sitename"]]

            DIZtools::feedback(
              print_this = paste0("The site-name is: ", rv$sitename),
              type = "Info",
              ui = FALSE,
              findme = "143f343ab6",
              logfile_dir = rv$log$logfile_dir
            )
          }

          # Check if at least one data element was selected for analyzation:
          if (length(input_re()[[paste0("moduleConfig-select_dqa_assessment",
                                        "_variables")]]) <= 0) {
            DIZtools::feedback(
              print_this = paste0(
                "You didn't specify a data element to",
                " analyze. Please select at least one data element",
                " and try again."
              ),
              type = "UI",
              ui = TRUE,
              findme = "57562a3092",
              logfile_dir = rv$log$logfile_dir
            )
            error_tmp <- TRUE
          }

          # If target should be identical to source, set it here again:
          if (isTRUE(rv$target_is_source)) {
            rv <- set_target_equal_to_source(rv)
            DIZtools::feedback(print_this = "Source == Target",
                               findme = "c14c17bf15",
                               logfile_dir = rv$log$logfile_dir,
                               headless = rv$headless
            )
          } else {
            DIZtools::feedback(print_this = "Source != Target",
                               findme = "54fe9a5717",
                               logfile_dir = rv$log$logfile_dir,
                               headless = rv$headless
            )
          }

          DIZtools::feedback(
            paste0("Source database is ", rv$source$system_name),
            findme = "1d61685355",
            logfile_dir = rv$log$logfile_dir,
            headless = rv$headless
          )
          DIZtools::feedback(
            paste0("Target database is ", rv$target$system_name),
            findme = "eaf72ed747",
            logfile_dir = rv$log$logfile_dir,
            headless = rv$headless
          )
        }

        if (validate_inputs(rv,
                            input = input,
                            output = output,
                            session = session) &&
            !error_tmp) {
          # set flags to inactivate config-widgets and start loading of
          # data
          rv$getdata_target <- TRUE
          rv$getdata_source <- TRUE
          rv$start <- TRUE

          if (!dir.exists(paste0(tempdir(), "/_settings/"))) {
            dir.create(paste0(tempdir(), "/_settings/"))
          }

          # save user settings
          writeLines(
            jsonlite::toJSON(
              list(
                "source_system" = rv$source$settings,
                "target_system" = rv$target$settings,
                "site_name" = rv$sitename
              ),
              pretty = TRUE,
              auto_unbox = FALSE
            ),
            paste0(tempdir(), "/_settings/global_settings.JSON")
          )
        } else {
          stop("An error occurred!")
        }
      }, error = function(cond) {
        DIZtools::feedback(
          print_this = paste0(cond),
          findme = "05c96798f8",
          type = "Error",
          logfile_dir = rv$log$logfile_dir
        )
        ## Trigger the modal for the user/UI:
        rv$error <- TRUE
        show_failure_alert(
          paste0(
            "Executing the script to pre-check the",
            " input parameters before data-loading failed"
          )
        )
      })
      print_runtime(
        start_time = start_time,
        name = "moduleConfig-dash_load_btn",
        logfile_dir = rv$log$logfile_dir
      )
    })

    observeEvent(input$select_all_assessment_variables, {
      updateCheckboxGroupInput(
        session = session,
        inputId = "select_dqa_assessment_variables",
        choices = sort(rv$dqa_assessment[["designation"]]),
        selected = rv$dqa_assessment[["designation"]]
      )
    })

    observeEvent(input$select_no_assessment_variables, {
      updateCheckboxGroupInput(
        session = session,
        inputId = "select_dqa_assessment_variables",
        choices = sort(rv$dqa_assessment[["designation"]]),
        selected = NULL
      )
    })

    shiny::observeEvent(eventExpr = input$date_restriction_slider,
                        handlerExpr = {
                          if (isTRUE(input$date_restriction_slider)) {
                            DIZtools::feedback(
                              print_this = "Date restriction will be applied",
                              findme = "4736de090c",
                              logfile_dir = rv$log$logfile_dir
                            )
                            shinyjs::show(id = "datetime_picker")
                            shinyjs::enable(id = "datetime_picker")
                            rv$restricting_date$use_it <- TRUE
                            rv$restricting_date$start <-
                              as.Date(input$datetime_picker[[1]])
                            rv$restricting_date$end <-
                              as.Date(input$datetime_picker[[2]])
                          } else {
                            DIZtools::feedback(
                              print_this = paste0("Date restriction will",
                                                  " NOT be applied"),
                              findme = "508c7f34f9",
                              logfile_dir = rv$log$logfile_dir
                            )
                            shinyjs::disable(id = "datetime_picker")
                            shinyjs::hide(id = "datetime_picker")
                            rv$restricting_date$use_it <- FALSE
                            rv$restricting_date$start <- NULL
                            rv$restricting_date$end <- NULL
                          }
                        }
                        , ignoreInit = TRUE
                        )

    ## Date-time picker for date restriction:
    shiny::observeEvent(eventExpr = input$datetime_picker,
                        handlerExpr = {
                          rv$restricting_date$use_it <- TRUE
                          rv$restricting_date$start <-
                            as.Date(input$datetime_picker[[1]])
                          rv$restricting_date$end <-
                            as.Date(input$datetime_picker[[2]])

                          output$datetime_picker_info_start <-
                            shiny::renderText({
                              paste0(
                                "Start timestamp: ",
                                input$datetime_picker[[1]]
                              )
                            })
                          output$datetime_picker_info_end <-
                            shiny::renderText({
                              paste0(
                                "End timestamp: ",
                                input$datetime_picker[[2]]
                              )
                            })
                          DIZtools::feedback(
                            print_this = paste0(
                              "Using ",
                              rv$restricting_date$start,
                              " as start and ",
                              rv$restricting_date$end,
                              " as end timestamp for filtering the data."
                            ),
                            findme = "04bf478581",
                            logfile_dir = rv$log$logfile_dir,
                            headless = rv$headless
                          )
                        })


  }

#' @title module_config_ui
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
#'     tabName = "config",
#'     module_config_ui(
#'       "moduleConfig"
#'     )
#'   )
#' )
#' }
#'
#' @export
#'
# module_config_ui
module_config_ui <- function(id) {
  ns <- NS(id)

  tagList(
    fluidRow(
      column(
        9,
        ## This will be displayed after the MDR is loaded successfully:
        conditionalPanel(
          condition =
            "typeof output['moduleConfig-system_types'] !== 'undefined'",
          box(
            title =  "SOURCE settings",
            width = 6,
            #solidHeader = TRUE,
            tabsetPanel(
              # The id lets us use input$source_tabs
              # on the server to find the current tab
              id = ns("source_tabs"),
              # selected = "PostgreSQL",
              tabPanel(
                # ATTENTION: If you change the title, you also have to change
                # the
                # corresponding part above for the "source == source" button
                # reaction. Otherwise the tabs won't hide/show up anymore.
                # >> ATTENTION <<
                title = "CSV",
                # >> ATTENTION << for title. See above.
                id = ns("source_tab_csv"),
                h4("Source CSV Upload"),
                box(
                  title = "Available CSV-Systems",
                  # background = "blue",
                  # solidHeader = TRUE,
                  width = 12,
                  selectInput(
                    # This will be filled in the server part.
                    inputId = ns("source_csv_presettings_list"),
                    label = NULL,
                    choices = NULL,
                    selected = NULL
                  ),
                  style = "text-align:center;"
                ),
                div(
                  paste(
                    "Please choose the directory of your",
                    " source data in csv format (default: '/home/input')."
                  )
                ),
                br(),
                # If the path is already set, display it
                conditionalPanel(
                  condition = paste0(
                    "typeof ",
                    "output['moduleConfig-source_csv_dir']",
                    " !== 'undefined'"
                  ),
                  verbatimTextOutput(ns("source_csv_dir")),
                  style = "text-align:center;"
                ),
                br(),

                # If there is no path set yet: Display the button to choose it
                shinyFiles::shinyDirButton(
                  id = ns("config_sourcedir_in"),
                  label = "Source Dir",
                  title = "Please select the source directory",
                  buttonType = "default",
                  icon = icon("folder"),
                  class = NULL,
                  style = "text-align:center;"
                )
              ),
              tabPanel(
                # ATTENTION: If you change the title, you also have to change
                # the
                # corresponding part above for the "source == source" button
                # reaction. Otherwise the tabs won't hide/show up anymore.
                # >> ATTENTION <<
                title = "PostgreSQL",
                # >> ATTENTION << for title. See above.
                id = ns("source_tab_pg"),
                h4("Source Database Connection"),
                box(
                  title = "Preloadings",
                  # background = "blue",
                  #solidHeader = TRUE,
                  width = 12,
                  selectInput(
                    # This will be filled in the server part.
                    inputId = ns("source_postgres_presettings_list"),
                    label = NULL,
                    choices = NULL,
                    selected = NULL
                  ),
                  style = "text-align:center;"
                ),
                textInput(
                  inputId = ns("config_source_postgres_dbname"),
                  label = "DB Name",
                  placeholder = "Enter the name of the database ..."
                ),
                textInput(
                  inputId = ns("config_source_postgres_host"),
                  label = "IP",
                  placeholder = "Enter the IP here in format '192.168.1.1' ..."
                ),
                textInput(
                  inputId = ns("config_source_postgres_port"),
                  label = "Port",
                  placeholder = "Enter the Port of the database connection ..."
                ),
                textInput(
                  inputId = ns("config_source_postgres_user"),
                  label = "Username",
                  placeholder =
                    "Enter the Username for the database connection ..."
                ),
                passwordInput(
                  inputId = ns("config_source_postgres_password"),
                  label = "Password",
                  placeholder = "Enter the database password ..."
                ),
                br(),
                actionButton(
                  inputId = ns("source_postgres_test_connection"),
                  label = "Test & Save connection",
                  icon = icon("database"),
                  style = "text-align:center;"
                )
              ),
              tabPanel(
                # ATTENTION: If you change the title, you also have to change
                # the
                # corresponding part above for the "target == source" button
                # reaction. Otherwise the tabs won't hide/show up anymore.
                # >> ATTENTION <<
                title = "Oracle",
                # >> ATTENTION << for title. See above.
                id = ns("source_tab_oracle"),
                h4("Source Database Connection"),
                box(
                  title = "Preloadings",
                  # background = "blue",
                  #solidHeader = TRUE,
                  width = 12,
                  selectInput(
                    # This will be filled in the server part.
                    inputId = ns("source_oracle_presettings_list"),
                    label = NULL,
                    choices = NULL,
                    selected = NULL
                  ),
                  style = "text-align:center;"
                ),
                textInput(
                  inputId = ns("config_source_oracle_dbname"),
                  label = "DB Name",
                  placeholder = "Enter the name of the database ..."
                ),
                textInput(
                  inputId = ns("config_source_oracle_host"),
                  label = "IP",
                  placeholder = "Enter the IP here in format '192.168.1.1' ..."
                ),
                textInput(
                  inputId = ns("config_source_oracle_port"),
                  label = "Port",
                  placeholder = "Enter the Port of the database connection ..."
                ),
                textInput(
                  inputId = ns("config_source_oracle_user"),
                  label = "Username",
                  placeholder =
                    "Enter the Username for the database connection ..."
                ),
                passwordInput(
                  inputId = ns("config_source_oracle_password"),
                  label = "Password",
                  placeholder = "Enter the database password ..."
                ),
                textInput(
                  inputId = ns("config_source_oracle_sid"),
                  label = "SID",
                  placeholder =
                    "Enter the SID for the database connection ..."
                ),
                br(),
                actionButton(
                  inputId = ns("source_oracle_test_connection"),
                  label = "Test & Save connection",
                  icon = icon("database"),
                  style = "text-align:center;"
                )
              )
            )
          ),
          box(
            title =  "TARGET settings",
            width = 6,
            #solidHeader = TRUE,
            tabsetPanel(
              # The id lets us use input$target_tabs
              # on the server to find the current tab
              id = ns("target_tabs"),
              # selected = "PostgreSQL",
              tabPanel(
                # ATTENTION: If you change the title, you also have to change
                # the
                # corresponding part above for the "target == source" button
                # reaction. Otherwise the tabs won't hide/show up anymore.
                # >> ATTENTION <<
                title = "CSV",
                # >> ATTENTION << for title. See above.
                id = ns("target_tab_csv"),
                h4("Target CSV Upload"),
                box(
                  title = "Available CSV-Systems",
                  # background = "blue",
                  # solidHeader = TRUE,
                  width = 12,
                  selectInput(
                    # This will be filled in the server part.
                    inputId = ns("target_csv_presettings_list"),
                    label = NULL,
                    choices = NULL,
                    selected = NULL
                  ),
                  style = "text-align:center;"
                ),
                div(
                  paste(
                    "Please choose the directory of your",
                    " target data in csv format (default: '/home/input')."
                  )
                ),
                br(),
                # If the path is already set, display it
                conditionalPanel(
                  condition = paste0(
                    "typeof ",
                    "output['moduleConfig-target_csv_dir']",
                    " !== 'undefined'"
                  ),
                  verbatimTextOutput(ns("target_csv_dir")),
                  style = "text-align:center;"
                ),
                br(),

                # If there is no path set yet: Display the button to choose it
                shinyFiles::shinyDirButton(
                  id = ns("config_targetdir_in"),
                  label = "Target Dir",
                  title = "Please select the target directory",
                  buttonType = "default",
                  icon = icon("folder"),
                  class = NULL,
                  style = "text-align:center;"
                )
              ),
              tabPanel(
                # ATTENTION: If you change the title, you also have to change
                # the
                # corresponding part above for the "target == source" button
                # reaction. Otherwise the tabs won't hide/show up anymore.
                # >> ATTENTION <<
                title = "PostgreSQL",
                # >> ATTENTION << for title. See above.
                id = ns("target_tab_pg"),
                h4("Target Database Connection"),
                box(
                  title = "Preloadings",
                  # background = "blue",
                  #solidHeader = TRUE,
                  width = 12,
                  selectInput(
                    # This will be filled in the server part.
                    inputId = ns("target_postgres_presettings_list"),
                    label = NULL,
                    choices = NULL,
                    selected = NULL
                  ),
                  style = "text-align:center;"
                ),
                textInput(
                  inputId = ns("config_target_postgres_dbname"),
                  label = "DB Name",
                  placeholder = "Enter the name of the database ..."
                ),
                textInput(
                  inputId = ns("config_target_postgres_host"),
                  label = "IP",
                  placeholder = "Enter the IP here in format '192.168.1.1' ..."
                ),
                textInput(
                  inputId = ns("config_target_postgres_port"),
                  label = "Port",
                  placeholder = "Enter the Port of the database connection ..."
                ),
                textInput(
                  inputId = ns("config_target_postgres_user"),
                  label = "Username",
                  placeholder =
                    "Enter the Username for the database connection ..."
                ),
                passwordInput(
                  inputId = ns("config_target_postgres_password"),
                  label = "Password",
                  placeholder = "Enter the database password ..."
                ),
                br(),
                actionButton(
                  inputId = ns("target_postgres_test_connection"),
                  label = "Test & Save connection",
                  icon = icon("database"),
                  style = "text-align:center;"
                )
              ),
              tabPanel(
                # ATTENTION: If you change the title, you also have to change
                # the
                # corresponding part above for the "target == source" button
                # reaction. Otherwise the tabs won't hide/show up anymore.
                # >> ATTENTION <<
                title = "Oracle",
                # >> ATTENTION << for title. See above.
                id = ns("target_tab_oracle"),
                h4("Target Database Connection"),
                box(
                  title = "Preloadings",
                  # background = "blue",
                  #solidHeader = TRUE,
                  width = 12,
                  selectInput(
                    # This will be filled in the server part.
                    inputId = ns("target_oracle_presettings_list"),
                    label = NULL,
                    choices = NULL,
                    selected = NULL
                  ),
                  style = "text-align:center;"
                ),
                textInput(
                  inputId = ns("config_target_oracle_dbname"),
                  label = "DB Name",
                  placeholder = "Enter the name of the database ..."
                ),
                textInput(
                  inputId = ns("config_target_oracle_host"),
                  label = "IP",
                  placeholder = "Enter the IP here in format '192.168.1.1' ..."
                ),
                textInput(
                  inputId = ns("config_target_oracle_port"),
                  label = "Port",
                  placeholder = "Enter the Port of the database connection ..."
                ),
                textInput(
                  inputId = ns("config_target_oracle_user"),
                  label = "Username",
                  placeholder =
                    "Enter the Username for the database connection ..."
                ),
                passwordInput(
                  inputId = ns("config_target_oracle_password"),
                  label = "Password",
                  placeholder = "Enter the database password ..."
                ),
                textInput(
                  inputId = ns("config_target_oracle_sid"),
                  label = "SID",
                  placeholder =
                    "Enter the SID for the database connection ..."
                ),
                br(),
                actionButton(
                  inputId = ns("target_oracle_test_connection"),
                  label = "Test & Save connection",
                  icon = icon("database"),
                  style = "text-align:center;"
                )
              )
            ),
            tags$hr(),
            checkboxInput(
              inputId = ns("target_system_to_source_system_btn"),
              # inputId = ns("randomstringhere"),
              label = paste0(" Use SOURCE also as TARGET",
                             " (Compare source with itself)"),
              value = FALSE
            ),
            tags$hr()
          )
        )
      ),
      column(
        3,
        conditionalPanel(
          condition =
            "typeof output['moduleConfig-mdr_present'] == 'undefined'",
          box(
            title = "Load Metadata Repository",
            actionButton(
              inputId = ns("config_load_mdr"),
              label = "Load MDR",
              icon = icon("table")
            ),
            width = 12
          )
        ),
        conditionalPanel(
          condition =
            "typeof output['moduleConfig-mdr_present'] !== 'undefined'",
          box(
            title = "Load the data",
            h4(htmlOutput(ns("source_system_feedback_txt"))),
            br(),
            h4(htmlOutput(ns("target_system_feedback_txt"))),
            hr(),
            selectInput(
              ns("config_sitename"),
              "Please enter the name of your site",
              selected = FALSE,
              choices = NULL,
              multiple = FALSE
            ),
            hr(),
            actionButton(ns("dash_load_btn"),
                         "Load data",
                         icon = icon("file-upload"),
                         style = paste0("color: #fff;",
                                        "background-color: #337ab7;",
                                        "border-color: #2e6da4;",
                                        "display:center-align;")),
            width = 12
          ),
          box(
            id = ns("config_select_datetime_picker_box"),
            title = "Do you want to time-filter the input data?",
            shinyWidgets::switchInput(inputId = ns("date_restriction_slider"),
                                      label = "Apply time-filtering",
                                      labelWidth = 150,
                                      value = NULL,
                                      disabled = TRUE
                                      # , labelWidth = "80px"
                                      ),
            daterangepicker::daterangepicker(
              inputId = ns("datetime_picker"),
              label = "Click to change the date range:",
              start = as.Date("1970-01-01"),
              end = Sys.Date(),
              # style = "width:100%; border-radius:4px",
              ranges = datepicker_get_list_of_ranges(),
              options = list(
                showDropdowns = TRUE,
                # timePicker = TRUE,
                # timePicker24Hour = TRUE,
                autoApply = TRUE,
                locale = list(separator = " <-> ",
                              format = "DD.MM.Y",
                              firstDay = 1)
              )
              # ,icon = shiny::icon("datetime")
            ),
            width = 12
          ),
          box(
            id = ns("config_select_dqa_assessment_box"),
            title = "Analyze the following data elements",
            hr(),
            actionButton(
              inputId = ns("select_all_assessment_variables"),
              label = "Select all"
            ),
            actionButton(
              inputId = ns("select_no_assessment_variables"),
              label = "Unselect all"
            ),
            hr(),
            checkboxGroupInput(
              inputId = ns("select_dqa_assessment_variables"),
              label = NULL,
              choices = NULL),
            width = 12
          )
        )
      )
    )
  )
}
