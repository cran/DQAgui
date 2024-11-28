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

#' @title button_send_datamap
#' @description This function is an exported wrapper around the actual function
#'   to send the datamap. This actual function can be customized by the user.
#'
#' @param rv The global rv object. rv$datamap needs to be valid.
#'
#' @return This functions is used to trigger logic when clicking the "Send
#'   Datamap" button on the dashboard (default: triggers the composing of an
#'   email by making use of the java-script command
#'   `window.open('mailto: ...')`). When customizing `DQAgui`, the function
#'   `button_send_datamap` can be overwritten in the namespace to trigger any
#'   other logic, wanted by the user.
#'
#' @examples
#' if (interactive()) {
#'   button_send_datamap(rv=rv)
#' }
#'
#' @export
button_send_datamap <- function(rv) {
  DIZtools::feedback(
    print_this = "Sending the datamap",
    logfile_dir = rv$log$logfile_dir,
    headless = rv$headless
  )
  return(send_datamap_to_mail(rv))
}

send_datamap_to_mail <- function(rv) {
  # encode datamap to json string
  json_string <-
    jsonlite::toJSON(c(
      list(
        "sitename" = rv$sitename,
        "lastrun" = as.character(rv$end_time),
        "run_duration" = as.character(round(rv$duration, 2)),
        "version_R" = as.character(
          paste(R.version[c("major", "minor")], collapse = ".")),
        "version_dizutils" = as.character(utils::packageVersion("DIZutils")),
        "version_dqastats" = as.character(utils::packageVersion("DQAstats")),
        "version_dqagui" = as.character(utils::packageVersion("DQAgui"))
      ),
      lapply(rv$datamap, function(x) {
        unname(split(x, seq_len(nrow(x))))
      })
    ))

  # https://stackoverflow.com/questions/27650331/adding-an-email-
  # button-in-shiny-using-tabletools-or-otherwise
  # https://stackoverflow.com/questions/37795760/r-shiny-add-
  # weblink-to-actionbutton
  # https://stackoverflow.com/questions/45880437/r-shiny-use-onclick-
  # option-of-actionbutton-on-the-server-side
  # https://stackoverflow.com/questions/45376976/use-actionbutton-to-
  # send-email-in-rshiny
  return(
    paste0(
      "window.open('mailto:",
      rv$datamap_email,
      "?",
      "body=",
      utils::URLencode(
        paste0(
          "Site name: ",
          rv$sitename,
          "\n\n(this is an automatically created email)\n\n",
          "\n\nLast run: ",
          rv$end_time,
          "\nRun duration: ",
          round(rv$duration, 2),
          " min.",
          "\n\nDatamap (JSON):\n",
          json_string
        )
      ),
      "&subject=",
      paste0("Data Map - ", rv$sitename),
      "')"
    )
  )
}


button_mdr <-
  function(utils_path,
           mdr_filename,
           logfile_dir,
           headless) {
    DIZtools::feedback(print_this = "Loading the metadata repository",
                       logfile_dir = logfile_dir,
                       headless = headless)
    shiny::withProgress(message = "Loading MDR", value = 0, {
      incProgress(1 / 1,
                  detail = "... from local file ...")
      # read MDR
      mdr <- DQAstats::read_mdr(utils_path = utils_path,
                                mdr_filename = mdr_filename)
    })
    return(list("mdr" = mdr, "sqls" = NULL))
  }
