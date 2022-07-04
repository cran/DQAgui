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


#' @title get_db_settings
#'
#' @param input Shiny server input object.
#' @param target A boolean (default: TRUE).
#' @param db_type (String) "postgres" or "oracle".
#' @param displayname_gui (String) "i2b2 (Prod)"
#' @inheritParams module_config_server
#'
#' @return This functions returns a data table of key-value pairs for the
#'   database settings, which are parsed from the respective config tab
#'   from the shiny application.
#'
#' @examples
#' if (interactive()) {
#'  get_db_settings(
#'   input = input,
#'   target = TRUE,
#'   db_type = "postgres"
#'  )
#' }
#'
#' @export
#'
get_db_settings <-
  function(input,
           target = TRUE,
           db_type,
           displayname_gui,
           rv) {
  # create description of column selections
  vec <- c("dbname", "host", "port", "user", "password")
  source_target <- ifelse(target, "target", "source")
  if (db_type == "oracle") {
    vec <- c(vec, "sid")
  }

  tab <- lapply(vec, function(g) {
    input_label_tmp <-
      paste0("config_", source_target, "_", db_type, "_", g)
    data.table::data.table("keys" = g, "value" = input[[input_label_tmp]])
  })

  tab <- do.call(rbind, tab)

  # if one column is selected multiple times
  if ("" %in% tab[, get("value")] ||
      any(tab[, grepl("\\s", get("value"))])) {
    shiny::showModal(
      modalDialog(
        title = "Invalid database configuration",
        "No empty strings or spaces allowed in database configurations."
      )
    )
    return(NULL)

  } else {
    outlist <-
      lapply(stats::setNames(
        object = tab[["keys"]],
        nm = tab[["keys"]]
      ), function(g) {
        tab[get("keys") == g, get("value")]
      })
    return(outlist)
  }
}

#' @title This function is used in the config-tab and displays the selected
#'   system to the user.
#' @param system (String) e.g. "i2b2", "OMOP" or "CSV"
#' @param type (String) "source" or "target"
#' @return String containing the input params in a propper manner
#'
#'
feedback_txt <- function(system, type) {
  result <- paste0(
    "\U2714 ",
    tags$b(system),
    " will be used as ",
    DIZtools::firstup(type),
    " database.",
    "\n\n",
    "To change, simply select and save another one."
  )
  return(result)
}


#' @title This function is called when the user clicks on the button
#' @description "Set target == source". It sets target settings = source
#'   settings.
#'
#' @inheritParams module_dashboard_server
#'
#'
set_target_equal_to_source <- function(rv) {
  rv$target <- rv$source
  return(rv)
}

#' @title This function checks if all necessary input parameters
#'   for source and target exist and are valid.
#'
#' @inheritParams module_dashboard_server
#'
#'
validate_inputs <- function(rv, input, output, session) {
  error_tmp <- FALSE
  if (!is.null(rv$source$system_type) &&
      !is.null(rv$target$system_type)) {
    for (source_target in c("source", "target")) {
      # Only start computing if there is no error yet:
      if (!error_tmp) {
        if (rv[[source_target]]$system_type == "csv") {
          # Check if -path is valid:
          if (typeof(rv[[source_target]]$settings$path) == "character" &&
              !is.null(rv[[source_target]]$settings$path) &&
              length(rv[[source_target]]$settings$path) > 0) {
            DIZtools::feedback(
              print_this = paste0(source_target, " settings seem valid."),
              findme = "c0bcc9aa31",
              logfile_dir = rv$log$logfile_dir,
              headless = rv$headless
            )
            # valid path, so check if files exist:
            test_csv_tmp <- DQAstats::test_csv(
              settings = rv[[source_target]]$settings,
              source_db = rv[[source_target]]$system_name,
              mdr = rv$mdr,
              logfile_dir = rv$log$logfile_dir,
              headless = rv$headless
            )
            if (isTRUE(test_csv_tmp)) {
              DIZtools::feedback(
                print_this = paste0("All ",
                                    source_target,
                                    " csv-files were found."),
                findme = "794c6f3160",
                logfile_dir = rv$log$logfile_dir,
                headless = rv$headless
              )
            } else {
              DIZtools::feedback(
                print_this = paste0("Some ",
                                    source_target,
                                    " csv-files are MISSING."),
                type = "Error",
                findme = "926b0c567c",
                logfile_dir = rv$log$logfile_dir,
                headless = rv$headless
              )
              error_tmp <- TRUE
            }
          } else {
            # invalid path:
            DIZtools::feedback(
              print_this = paste0(source_target, " settings not valid."),
              type = "warning",
              findme = "10d5e79d44",
              ui = TRUE,
              logfile_dir = rv$log$logfile_dir,
              headless = rv$headless
            )
            DIZtools::feedback(
              print_this = paste0(
                "rv$",
                source_target,
                "$settings$path = ",
                rv[[source_target]]$settings$path
              ),
              findme = "d9b43110bb",
              logfile_dir = rv$log$logfile_dir,
              headless = rv$headless
            )
            error_tmp <- TRUE
          }
        } else if (rv[[source_target]]$system_type == "postgres") {
          error_tmp <- test_connection_button_clicked(
            rv = rv,
            source_target = source_target,
            db_type = "postgres",
            input = input,
            output = output,
            session = session
          )
        } else if (rv[[source_target]]$system_type == "oracle") {
          error_tmp <- test_connection_button_clicked(
            rv = rv,
            source_target = source_target,
            db_type = "oracle",
            input = input,
            output = output,
            session = session
          )
        } else {
          ## This system name is not known/implemented here:
          DIZtools::feedback(
            print_this = paste0(
              source_target,
              " database ",
              rv[[source_target]]$system_name,
              " not yet implemented."
            ),
            type = "Error",
            findme = "d0f0bfa2f3",
            ui = TRUE,
            logfile_dir = rv$log$logfile_dir,
            headless = rv$headless
          )
          error_tmp <- TRUE
        }
      }
    }
  } else {
    DIZtools::feedback(
      print_this = "Either source or target database is not set.",
      type = "Warning",
      findme = "4e9400f8c9",
      ui = TRUE,
      logfile_dir = rv$log$logfile_dir,
      headless = rv$headless
    )
    error_tmp <- TRUE
  }
  return(!error_tmp)
}

fix_sql_display <- function(text) {
  t <- text
  t <- gsub("\\\n", "<br>\n", t)
  t <- gsub("\\\t", "&nbsp;&nbsp;&nbsp;&nbsp;", t)
  return(t)
}



#' @title Evaluates whether the load-data button needs to be shown or not.
#' @description If there is a valid source system and a valid target system
#'   (this is also the case if the user set target == source), the result
#'   of this function will be TRUE and the button will be displayed via
#'   shinyjs. Otherwise the result is FALSE and the button will be hidden.
#'   This function also displays (or hides) the variables which can be
#'   assessed.
#'
#' @inheritParams module_config_server
#'
#'
check_load_data_button <- function(rv, session) {
  debugging <- FALSE
  if (debugging) {
    systems <- c("csv", "postgres", "oracle")
  } else {
    systems <- tolower(rv$system_types)
  }

  res <- ""
  if (!is.null(rv$source$system_type)) {
    if (rv$source$system_type %in% systems &&
        isTRUE(rv$target_is_source)) {
      # Source is set and target is not necessary:
      res <- TRUE

      # Catch the case where target should be source but rv$target
      # is not set yet (so assign it):
      if (is.null(rv$target$system_type) ||
          (rv$source$system_type != rv$target$system_type)) {
        rv$target <- rv$source
      }
    } else if (rv$source$system_type %in% systems &&
               !is.null(rv$target$system_type) &&
               rv$target$system_type %in% systems) {
      # Source and target are set:
      res <- TRUE
    } else {
      res <- FALSE
    }
  } else {
    res <- FALSE
  }

  if (res) {
    DIZtools::feedback(
      print_this = paste0(
        "Determining the dataelements for source_db = '",
        rv$source$system_name,
        "' and target_db = '",
        rv$target$system_name,
        "' using DQAstats::create_helper_vars()."
      ),
      findme = "28f400ebb3"
    )
    # Determine the different dataelements:
    helper_vars_tmp <- DQAstats::create_helper_vars(
      mdr = rv$mdr,
      source_db = rv$source$system_name,
      target_db = rv$target$system_name
    )
    rv$dqa_assessment <- helper_vars_tmp$dqa_assessment

    # Update the checkboxgroup to the determined dataelemets:
    updateCheckboxGroupInput(
      session = session,
      inputId = "select_dqa_assessment_variables",
      choices = sort(rv$dqa_assessment[["designation"]]),
      selected = rv$dqa_assessment[["designation"]]
    )

    # Show the checkboxgroup:
    shinyjs::show("config_select_dqa_assessment_box")

    ## Determine if time filtering is available for the source and the target
    ## system:
    time_filtering_possible <- DQAstats::check_date_restriction_requirements(
      mdr = rv$mdr,
      system_names = c(rv$source$system_name, rv$target$system_name),
      # restricting_date = rv$restricting_date,
      logfile_dir = rv$log$logfile_dir,
      headless = rv$headless,
      enable_stop = FALSE
    )

    if (debugging) {
      message(time_filtering_possible)
      message(rv$source$system_name)
      message(rv$target$system_name)
      message(rv$restricting_date)
    }

    if (time_filtering_possible) {
      ## Time filtering is possible, so enable the elements in the GUI:
      DIZtools::feedback(
        print_this = paste0(
          "Date restriction is possible.",
          " Showing date-picking elements in the GUI now."
        ),
        findme = "794ca3f55e",
        logfile_dir = rv$log$logfile_dir
      )

      # do not use "inputId" with moduleConfig here. doesn't work.
      shinyWidgets::updateSwitchInput(
        session = session,
        inputId = "date_restriction_slider",
        label = "Apply time-filtering?",
        disabled = FALSE,
        value = FALSE,
        onLabel = "Yes",
        offLabel = "No"
      )

    } else {
      ## Time filtering is NOT possible, so disable the elements in the GUI:
      DIZtools::feedback(
        print_this = paste0(
          "Date restriction is NOT possible or needed.",
          " Hiding date-picking elements in the GUI now."
        ),
        findme = "adda589187",
        logfile_dir = rv$log$logfile_dir
      )
      shinyWidgets::updateSwitchInput(
        session = session,
        inputId = "date_restriction_slider",
        label = "No time-filtering possible",
        disabled = TRUE,
        value = FALSE
      )
      rv$restricting_date$use_it <- FALSE
      if (debugging) {
        message(rv$restricting_date)
      }
    }

    # Show load-data button:
    shinyjs::show("dash_load_btn")

    # Show sitename-configuration:
    shinyjs::show("config_sitename")
  } else {
    shinyjs::hide("config_select_dqa_assessment_box", anim = TRUE)
    shinyjs::hide("dash_load_btn")
    shinyjs::hide("datetime_picker")

    # Hide sitename-configuration:
    shinyjs::hide("config_sitename")
  }
  return(res)
}

#' @title Checks if an connection can be established to the system.
#' @description After the button "Check connection" is pressed in the GUI,
#'   this function will be called and tries to connect to this system
#'   and feedbacks the result to the user.
#'   If the connection is successfully established, the button will be
#'   disabled and this connection will be stored as valid for the given
#'   source/target system.
#'
#' @param source_target (String) "source" or "target"
#' @param db_type (String) "postgres" or "oracle"
#' @inheritParams module_config_server
#'
#' @return true if the connection could be established and false otherwise
#'   (also if an error occurred)
#'
test_connection_button_clicked <-
  function(rv,
           source_target,
           db_type,
           input,
           output,
           session) {
    error <- TRUE
    DIZtools::feedback(
      print_this = paste0(
        "Trying to connect to ",
        db_type,
        " as ",
        source_target,
        " database ..."
      ),
      findme = "7218f2e0fb",
      logfile_dir = rv$log$logfile_dir,
      headless = rv$headless
    )
    source_target <- tolower(source_target)
    db_type <- tolower(db_type)
    target <- ifelse(source_target == "target", TRUE, FALSE)

    ## If the button "set target to source" is clicked, all the gui elements
    ## are invisible for the target system but his function is also called
    ## before the final data-loading process starts to make sure that there
    ## are valid connections for source and target. So in this case
    ## (target == source is clicked), the (invisible prefilled) settings
    ## from the target gui elements are incorrectly loaded instead of the
    ## source elements. So we need to check if source == target is set and
    ## load all the source data if so:
    if (target && isTRUE(rv$target_is_source)) {
      source_target <- "source"
      target <- FALSE
    }

    ## If we don't assign (= copy) it (input$source_oracle_presettings_list)
    ## here, the value will stay reactive and change every time we
    ## select another system. But it should only change if
    ## we also successfully tested the connection:
    system_name_tmp <-
      paste0(source_target, "_", db_type, "_presettings_list")
    input_system <- input[[system_name_tmp]]


    ## Info:
    ## `input_system` is e.g. "i2b2 (Prod)" = displayname
    ## `db_type` is e.g. "postgres"

    rv[[source_target]]$settings <-
      DQAgui::get_db_settings(
        input = input,
        target = target,
        db_type = db_type,
        displayname = input_system,
        rv = rv
      )

    if (db_type == "oracle") {
      lib_path_tmp <- Sys.getenv("KDB_DRIVER")
    } else {
      lib_path_tmp <- NULL
    }

    if (!is.null(rv[[source_target]]$settings)) {
      # set new environment variables here
      # https://stackoverflow.com/a/12533155
      lapply(
        X = names(rv[[source_target]]$settings),
        FUN = function(envvar_names) {
          args <- list(rv[[source_target]]$settings[[envvar_names]])
          names(args) <- paste0(
            toupper(rv[[source_target]]$settings$dbname), "_",
            toupper(envvar_names)
          )
          do.call(Sys.setenv, args)
        }
      )

      rv[[source_target]]$db_con <- DIZutils::db_connection(
        ## db_name = rv[[source_target]]$settings$dbname,
        db_type = db_type,
        system_name = rv[[source_target]]$settings$dbname,
        headless = rv$headless,
        timeout = 2,
        logfile_dir = rv$log$logfile_dir,
        from_env = TRUE,
        lib_path = lib_path_tmp
      )


      if (!is.null(rv[[source_target]]$db_con)) {
        DIZtools::feedback(
          paste0(
            "Connection to ",
            input_system,
            " successfully established."
          ),
          findme = "4cec24dc1b",
          logfile_dir = rv$log$logfile_dir,
          headless = rv$headless
        )
        shiny::showNotification(paste0(
          "\U2714 Connection to ",
          input_system,
          " successfully established"
        ))
        button_label <-
          paste0(source_target, "_", db_type, "_test_connection")
        shiny::updateActionButton(
          session = session,
          inputId = button_label,
          label = paste0("Connection to ",
                         input_system,
                         " established"),
          icon = shiny::icon("check")
        )
        shinyjs::disable(button_label)

        rv[[source_target]]$system_name <-
          rv$displaynames[get("displayname") == input_system,
                          get("source_system_name")]

        rv[[source_target]]$system_type <- db_type
        label_feedback_txt <-
          paste0(source_target, "_system_feedback_txt")
        output[[label_feedback_txt]] <-
          shiny::renderText({
            feedback_txt(system = input_system,
                         type = source_target)
          })
        error <- FALSE
      } else {
        shiny::showNotification(paste0("\U2718 Connection to ",
                                       input_system,
                                       " failed"))
        rv[[source_target]]$system <- ""
      }
    }
    check_load_data_button(rv, session)
    return(error)
  }

#' @title Sjows an error alert modal with the hint to look into the logfile.
#'
#' @description See title.
#'
#' @param what_failed Short description of what failed.Like:
#'   "Getting the data failed."
#' '
#' @return Nothing - Just shows the alert modal.
#'
show_failure_alert <- function(what_failed) {
  text <- paste0(
    what_failed,
    ".",
    "\n\nYou can check the logfile (in the main menu) to ",
    " get more information about the cause of this error.",
    "\nSorry for that!\n\nYou can try again by reloading this page."
  )
  shinyalert::shinyalert(
    title = "Oops - This shouldn't happen!",
    text = text,
    closeOnEsc = TRUE,
    closeOnClickOutside = TRUE,
    html = FALSE,
    type = "error",
    showConfirmButton = TRUE,
    showCancelButton = FALSE,
    confirmButtonText = "OK",
    confirmButtonCol = "#AEDEF4",
    timer = 0,
    imageUrl = "",
    animation = TRUE
  )
}

print_runtime <-
  function(start_time,
           name = "",
           logfile_dir = NULL) {
    if (name == "") {
      text <- "Execution took "
    } else {
      text <- paste0("Execution of ", name, " took ")
    }
    DIZtools::feedback(
      print_this = paste0(
        text,
        format(Sys.time() - start_time),
        " using ",
        data.table::getDTthreads(),
        " threads."
      ),
      findme = "8c9db99829",
      logfile_dir = logfile_dir
    )
  }


datepicker_get_list_of_ranges <- function() {
  res <- list(
    "DQ check" = c(Sys.Date() - 99, Sys.Date() - 7),
    "Today" = c(Sys.Date(), Sys.Date()),
    "Yesterday" = c(Sys.Date() - 1, Sys.Date()),
    # "Last 3 days" = c(Sys.Date() - 2, Sys.Date()),
    "Last 7 days" = c(Sys.Date() - 6, Sys.Date()),
    "Last 45 days" = c(Sys.Date() - 44, Sys.Date()),
    "Current month" = c(as.Date(format(
      Sys.Date(), "%Y-%m-01"
    )), as.Date(format(
      Sys.Date(), paste0("%Y-%m-", lubridate::days_in_month(Sys.Date())[[1]])
    ))),
    "Last calendar year" = c(
      as.Date(
        paste0(substr(Sys.Date(), 1, 4) %>%
                 as.numeric() %>%
                 -1 %>%
                 as.character(),
               "-01-01"
        )
      ),
      as.Date(
        paste0(substr(Sys.Date(), 1, 4) %>%
                 as.numeric() %>%
                 -1 %>%
                 as.character(),
               "-12-31"
        )
      )
    ),
    ">= 2010" = c(as.Date("2010-01-01"), Sys.Date()),
    ">= 2015" = c(as.Date("2015-01-01"), Sys.Date()),
    ">= 2020" = c(as.Date("2020-01-01"), Sys.Date()),
    "Everything" = c(as.Date("1970-01-01"), Sys.Date())
  )

  ## Get list of years:
  for (i in 0:4) {
    if (i == 0) {
      ## end, today:
      end <- Sys.Date()
    } else {
      end <- as.Date(paste0(as.numeric(format(
        Sys.Date(), format = "%Y"
      )) - i, "-12-31"))
    }
    year <-
      as.character(as.numeric(format(Sys.Date(), format = "%Y")) - i)
    start <- as.Date(paste0(year, "-01-01"))
    res[[year]] <- c(start, end)
  }
  return(res)
}


get_display_name_from_settings <-
  function(settings,
           inner_name = NULL,
           prefilter = NULL) {
    if (!is.null(prefilter)) {
      settings <- settings[names(settings) %in% prefilter]
    }
    return(unlist(lapply(seq_along(settings), function(i) {
      if (!is.null(settings[[i]]$nested) && settings[[i]]$nested) {
        settings[[i]]$nested <- NULL
        ## Since there is no information left of where we are now in the
        ## next recursive step, we need to provide the name of the current
        ## system as `inner_name`:
        return(get_display_name_from_settings(settings = settings[[i]],
                                              inner_name = inner_name))
      } else {
        if (is.null(settings[[i]]$displayname)) {
          if (is.null(inner_name)) {
            return(names(settings)[[i]])
          } else {
            return(inner_name)
          }
        } else {
          return(settings[[i]]$displayname)
        }
      }
    })))
  }

get_settings_from_displayname <-
  function(displayname, settings, inner_name = NULL) {
    res <- lapply(seq_along(settings), function(i) {
      if (!is.null(settings[[i]]$nested) && settings[[i]]$nested) {
        settings[[i]]$nested <- NULL
        return(
          get_settings_from_displayname(
            displayname = displayname,
            settings = settings[[i]],
            inner_name = inner_name
          )
        )
      } else {
        if (is.null(settings[[i]]$displayname)) {
          if (is.null(inner_name)) {
            name_to_check <- names(settings)[[i]]
          } else {
            name_to_check <- inner_name
          }
        } else {
          name_to_check <- settings[[i]]$displayname
        }
        if (DIZtools::equals2(name_to_check, displayname)) {
          return(settings[[i]])
        } else {
          return(NA)
        }
      }
    })

    ## Remove empty elements of the list:
    res <-
      res[lapply(res, function(x) {
        return(all(is.null(x)) || all(is.na(x)))
      }) == FALSE]

    if (length(res) > 1) {
      DIZtools::feedback(
        print_this = paste0(
          "Found more than one setting-list while searching for '",
          displayname,
          "'. Returning NA now."
        ),
        type = "Warning",
        findme = "f035f4923c"
      )
    } else if (length(res) == 1) {
      return(res[[1]])
    } else {
      return(NULL)
    }
  }



# create summary tables
summary_table <- function() {
  return(
    data.table::data.table(
      "variable" = character(),
      "distinct" = integer(),
      "valids" = integer(),
      "missings" = integer()
    )
  )
}

# render quick check tables
render_quick_checks <- function(dat_table) {
  out <-
    DT::datatable(
      dat_table,
      options = list(
        dom = "t",
        scrollY = "30vh",
        pageLength = nrow(dat_table)
      ),
      rownames = FALSE
    ) %>%
    DT::formatStyle(columns = 2,
                    backgroundColor = DT::styleEqual(
                      c("passed", "failed", "no data available"),
                      c("lightgreen", "red", "orange"))) %>%
    DT::formatStyle(columns = 3,
                    backgroundColor = DT::styleEqual(
                      c("passed", "failed", "no data available"),
                      c("lightgreen", "red", "orange"))) %>%
    DT::formatStyle(columns = 4,
                    backgroundColor = DT::styleEqual(
                      c("passed", "failed", "no data available"),
                      c("lightgreen", "red", "orange"))) %>%
  return(out)
}

get_from_env <- function(sysname) {
  env_field_list <- c("dbname", "host", "port", "user", "password",
                      "sid", "path", "driver", "displayname")

  outlist <- sapply(
    X = env_field_list,
    function(field) {
      do.call(Sys.getenv, list(
        paste(toupper(sysname),
               toupper(field),
               sep = "_")
      ))
    },
    simplify = FALSE,
    USE.NAMES = TRUE
  )

  return(outlist[outlist != ""])
}
