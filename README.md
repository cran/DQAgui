# DQAgui

<!-- badges: start -->
[![R CMD Check via {tic}](https://github.com/miracum/dqa-dqagui/workflows/R%20CMD%20Check%20via%20{tic}/badge.svg?branch=master)](https://github.com/miracum/dqa-dqagui/actions)
[![linting](https://github.com/miracum/dqa-dqagui/workflows/lint/badge.svg?branch=master)](https://github.com/miracum/dqa-dqagui/actions)
[![test-coverage](https://github.com/miracum/dqa-dqagui/workflows/test-coverage/badge.svg?branch=master)](https://github.com/miracum/dqa-dqagui/actions)
[![codecov](https://codecov.io/gh/miracum/dqa-dqagui/branch/master/graph/badge.svg)](https://app.codecov.io/gh/miracum/dqa-dqagui)
[![pipeline status](https://gitlab.miracum.org/miracum/dqa/dqagui/badges/master/pipeline.svg)](https://gitlab.miracum.org/miracum/dqa/dqagui/-/commits/master)
[![coverage report](https://gitlab.miracum.org/miracum/dqa/dqagui/badges/master/coverage.svg)](https://gitlab.miracum.org/miracum/dqa/dqagui/-/commits/master)
[![CRAN Status Badge](https://www.r-pkg.org/badges/version-ago/DQAgui)](https://cran.r-project.org/package=DQAgui)
[![CRAN Checks](https://cranchecks.info/badges/worst/DQAgui)](https://cran.r-project.org/web/checks/check_results_DQAgui.html)
<!-- badges: end -->

This is the repository of the R package 'DQAgui'. It provides a graphical user interface to the functionalities implemented in [`DQAstats`](https://github.com/miracum/dqa-dqastats).


## Installation

You can install `DQAgui` with:

``` r
install.packages("remotes")
remotes::install_github("miracum/dqa-dqagui")
```

## Configuration 

The database connection can be configured using environment variables. These can be set using the base R command `Sys.setenv()`.

A detailed description, which environment variables need to be set for the specific databases can be found [here](https://github.com/miracum/misc-dizutils/blob/master/README.md).

## Example

This is a basic example to demonstrate how to perform the data quality assessment with `DQAgui`:

```r
library(DQAgui)

# define base paths for shinyFiles::shinyDirChoose
Sys.setenv(
  "CSV_SOURCE_BASEPATH" = system.file("demo_data", package = "DQAstats")
)
Sys.setenv(
  "CSV_TARGET_BASEPATH" = system.file("demo_data", package = "DQAstats")
)

# define path to utilities-folder
utils_path = system.file("demo_data/utilities",
                         package = "DQAstats")

# filename of the metadata repository
mdr_filename = "mdr_example_data.csv"

# directory for storing logfiles
logfile_dir <- tempdir()

launch_app(
  port = 3838,
  utils_path = utils_path,
  mdr_filename = mdr_filename,
  logfile_dir = logfile_dir
)
```
To open the shiny application in your web-browser, go to http://localhost:3838.

## More Infos:

- about MIRACUM: [https://www.miracum.org/](https://www.miracum.org/)
- about the Medical Informatics Initiative: [https://www.medizininformatik-initiative.de/index.php/de](https://www.medizininformatik-initiative.de/index.php/de)
- about Shiny: https://www.rstudio.com/products/shiny/  
- RStudio and Shiny are trademarks of RStudio, Inc. 
