# DQAgui shiny app / launch_app() works

    Code
      rv
    Output
      <ReactiveValues> 
        Values:    affectedids_exported, aggregated_exported, checks, completeness, conformance, create_report, current_date, data_plausibility, data_source, data_target, datamap, datamap_email, displaynames, dqa_assessment, duration, end_time, finished_onstart, getdata_source, getdata_target, headless, keys_source, keys_target, log, mdr, mdr_filename, ncores, parallel, pl, pl_atemp_vars_filter, pl_uniq_vars_filter, report_created, restricting_date, results_descriptive, results_plausibility_atemporal, results_plausibility_unique, settings, sitename, sitenames, source, start, start_time, system_types, systems, target, target_is_source, utilspath, variable_list 
        Readonly:  FALSE 

---

    Code
      rv$results_descriptive
    Output
      $`Age in years`
      $`Age in years`$description
      $`Age in years`$description$source_data
      $`Age in years`$description$source_data$name
      [1] "Age in years"
      
      $`Age in years`$description$source_data$internal_variable_name
      [1] "dqa_age_years"
      
      $`Age in years`$description$source_data$description
      [1] "The age of the person at the time of contact."
      
      $`Age in years`$description$source_data$var_name
      [1] "AGE"
      
      $`Age in years`$description$source_data$table_name
      [1] "dqa_example_data_01.csv"
      
      $`Age in years`$description$source_data$checks
      $`Age in years`$description$source_data$checks$var_type
      [1] "integer"
      
      $`Age in years`$description$source_data$checks$constraints
      [1] "{\"range\":{\"min\":0,\"max\":110,\"unit\":\"a\"}} "
      
      
      
      $`Age in years`$description$target_data
      $`Age in years`$description$target_data$var_name
      [1] "AGE"
      
      $`Age in years`$description$target_data$table_name
      [1] "dqa_example_data_02.csv"
      
      $`Age in years`$description$target_data$checks
      $`Age in years`$description$target_data$checks$var_type
      [1] "integer"
      
      $`Age in years`$description$target_data$checks$constraints
      [1] "{\"range\":{\"min\":0,\"max\":110,\"unit\":\"a\"}} "
      
      
      
      
      $`Age in years`$counts
      $`Age in years`$counts$source_data
      $`Age in years`$counts$source_data$cnt
              variable  n valids missings distinct      sourcesystem
      1: dqa_age_years 23     23        0       21 exampleCSV_source
      
      $`Age in years`$counts$source_data$type
      [1] "integer"
      
      
      $`Age in years`$counts$target_data
      $`Age in years`$counts$target_data$cnt
              variable  n valids missings distinct      sourcesystem
      1: dqa_age_years 23     23        0       21 exampleCSV_target
      
      $`Age in years`$counts$target_data$type
      [1] "integer"
      
      
      
      $`Age in years`$statistics
      $`Age in years`$statistics$source_data
                        
       1:     Mean    63
       2:  Minimum    22
       3:   Median    64
       4:  Maximum    94
       5:       SD 22.56
       6:  Negativ     0
       7:     Zero     0
       8: Positive    23
       9:    OutLo     0
      10:    OutHi     0
      11: Variance   509
      12:    Range    72
      
      $`Age in years`$statistics$target_data
                          
       1:     Mean   67.35
       2:  Minimum      22
       3:   Median      64
       4:  Maximum     175
       5:       SD   32.45
       6:  Negativ       0
       7:     Zero       0
       8: Positive      23
       9:    OutLo       0
      10:    OutHi       1
      11: Variance 1052.87
      12:    Range     153
      
      
      
      $`Amount of credit`
      $`Amount of credit`$description
      $`Amount of credit`$description$source_data
      $`Amount of credit`$description$source_data$name
      [1] "Amount of credit"
      
      $`Amount of credit`$description$source_data$internal_variable_name
      [1] "dqa_credit_amount"
      
      $`Amount of credit`$description$source_data$description
      [1] "That's the amount of credit the person has used"
      
      $`Amount of credit`$description$source_data$var_name
      [1] "CREDIT-AMOUNT"
      
      $`Amount of credit`$description$source_data$table_name
      [1] "dqa_example_data_01.csv"
      
      $`Amount of credit`$description$source_data$checks
      $`Amount of credit`$description$source_data$checks$var_type
      [1] "integer"
      
      $`Amount of credit`$description$source_data$checks$constraints
      [1] "{\"range\":{\"min\":0,\"max\":\"Inf\",\"unit\":\"money\"}} "
      
      
      
      $`Amount of credit`$description$target_data
      $`Amount of credit`$description$target_data$var_name
      [1] "CREDIT-AMOUNT"
      
      $`Amount of credit`$description$target_data$table_name
      [1] "dqa_example_data_02.csv"
      
      $`Amount of credit`$description$target_data$checks
      $`Amount of credit`$description$target_data$checks$var_type
      [1] "integer"
      
      $`Amount of credit`$description$target_data$checks$constraints
      [1] "{\"range\":{\"min\":0,\"max\":\"Inf\",\"unit\":\"money\"}} "
      
      
      
      
      $`Amount of credit`$counts
      $`Amount of credit`$counts$source_data
      $`Amount of credit`$counts$source_data$cnt
                  variable  n valids missings distinct      sourcesystem
      1: dqa_credit_amount 23     10       13       10 exampleCSV_source
      
      $`Amount of credit`$counts$source_data$type
      [1] "integer"
      
      
      $`Amount of credit`$counts$target_data
      $`Amount of credit`$counts$target_data$cnt
                  variable  n valids missings distinct      sourcesystem
      1: dqa_credit_amount 23     10       13       10 exampleCSV_target
      
      $`Amount of credit`$counts$target_data$type
      [1] "integer"
      
      
      
      $`Amount of credit`$statistics
      $`Amount of credit`$statistics$source_data
                               
       1:     Mean        39220
       2:  Minimum        12200
       3:   Median        33350
       4:  Maximum        72800
       5:       SD     21447.19
       6:  Negativ            0
       7:     Zero            0
       8: Positive           10
       9:    OutLo            0
      10:    OutHi            0
      11: Variance 459981777.78
      12:    Range        60600
      
      $`Amount of credit`$statistics$target_data
                               
       1:     Mean        39220
       2:  Minimum        12200
       3:   Median        33350
       4:  Maximum        72800
       5:       SD     21447.19
       6:  Negativ            0
       7:     Zero            0
       8: Positive           10
       9:    OutLo            0
      10:    OutHi            0
      11: Variance 459981777.78
      12:    Range        60600
      
      
      
      $Birthdate
      $Birthdate$description
      $Birthdate$description$source_data
      $Birthdate$description$source_data$name
      [1] "Birthdate"
      
      $Birthdate$description$source_data$internal_variable_name
      [1] "dqa_birthdate"
      
      $Birthdate$description$source_data$description
      [1] "The date of birth written as dd.mm.yyyy"
      
      $Birthdate$description$source_data$var_name
      [1] "BIRTHDATE"
      
      $Birthdate$description$source_data$table_name
      [1] "dqa_example_data_01.csv"
      
      $Birthdate$description$source_data$checks
      $Birthdate$description$source_data$checks$var_type
      [1] "datetime"
      
      $Birthdate$description$source_data$checks$constraints
      [1] "{\"datetime\": {\"min\": \"1950-01-01\",\"max\": \"1989-12-31\", \"format\": \"%d.%m.%Y\"}}"
      
      
      
      $Birthdate$description$target_data
      $Birthdate$description$target_data$var_name
      [1] "BIRTHDATE"
      
      $Birthdate$description$target_data$table_name
      [1] "dqa_example_data_02.csv"
      
      $Birthdate$description$target_data$checks
      $Birthdate$description$target_data$checks$var_type
      [1] "datetime"
      
      $Birthdate$description$target_data$checks$constraints
      [1] "{\"datetime\": {\"min\": \"1950-01-01\",\"max\": \"1989-12-31\", \"format\": \"%d.%m.%Y\"}}"
      
      
      
      
      $Birthdate$counts
      $Birthdate$counts$source_data
      $Birthdate$counts$source_data$cnt
              variable  n valids missings distinct      sourcesystem
      1: dqa_birthdate 23     23        0       16 exampleCSV_source
      
      $Birthdate$counts$source_data$type
      [1] "datetime"
      
      
      $Birthdate$counts$target_data
      $Birthdate$counts$target_data$cnt
              variable  n valids missings distinct      sourcesystem
      1: dqa_birthdate 23     23        0       16 exampleCSV_target
      
      $Birthdate$counts$target_data$type
      [1] "datetime"
      
      
      
      $Birthdate$statistics
      $Birthdate$statistics$source_data
                          
      1    Min. 1921-02-19
      2 1st Qu. 1932-09-17
      3  Median 1951-07-03
      4    Mean 1950-09-25
      5 3rd Qu. 1965-05-10
      6    Max. 1990-05-26
      
      $Birthdate$statistics$target_data
                          
      1    Min. 1921-02-19
      2 1st Qu. 1932-09-17
      3  Median 1951-07-03
      4    Mean 1950-09-25
      5 3rd Qu. 1965-05-10
      6    Max. 1990-05-26
      
      
      
      $`Credit worthy?`
      $`Credit worthy?`$description
      $`Credit worthy?`$description$source_data
      $`Credit worthy?`$description$source_data$name
      [1] "Credit worthy?"
      
      $`Credit worthy?`$description$source_data$internal_variable_name
      [1] "dqa_credit_worthy"
      
      $`Credit worthy?`$description$source_data$description
      [1] "Indicates whether the person is creditworthy at the time of the contact"
      
      $`Credit worthy?`$description$source_data$var_name
      [1] "CREDIT-WORTHY"
      
      $`Credit worthy?`$description$source_data$table_name
      [1] "dqa_example_data_01.csv"
      
      $`Credit worthy?`$description$source_data$checks
      $`Credit worthy?`$description$source_data$checks$var_type
      [1] "enumerated"
      
      $`Credit worthy?`$description$source_data$checks$constraints
      [1] "{\"value_set\": [\"yes\", \"no\"]}"
      
      
      
      $`Credit worthy?`$description$target_data
      $`Credit worthy?`$description$target_data$var_name
      [1] "CREDIT-WORTHY"
      
      $`Credit worthy?`$description$target_data$table_name
      [1] "dqa_example_data_02.csv"
      
      $`Credit worthy?`$description$target_data$checks
      $`Credit worthy?`$description$target_data$checks$var_type
      [1] "enumerated"
      
      $`Credit worthy?`$description$target_data$checks$constraints
      [1] "{\"value_set\": [\"yes\", \"no\"]}"
      
      
      
      
      $`Credit worthy?`$counts
      $`Credit worthy?`$counts$source_data
      $`Credit worthy?`$counts$source_data$cnt
                  variable  n valids missings distinct      sourcesystem
      1: dqa_credit_worthy 23     23        0        2 exampleCSV_source
      
      $`Credit worthy?`$counts$source_data$type
      [1] "enumerated"
      
      
      $`Credit worthy?`$counts$target_data
      $`Credit worthy?`$counts$target_data$cnt
                  variable  n valids missings distinct      sourcesystem
      1: dqa_credit_worthy 23     23        0        2 exampleCSV_target
      
      $`Credit worthy?`$counts$target_data$type
      [1] "enumerated"
      
      
      
      $`Credit worthy?`$statistics
      $`Credit worthy?`$statistics$source_data
         dqa_credit_worthy Freq  % Valid
      1:                no   13 56.52174
      2:               yes   10 43.47826
      
      $`Credit worthy?`$statistics$target_data
         dqa_credit_worthy Freq  % Valid
      1:                no   13 56.52174
      2:               yes   10 43.47826
      
      
      
      $`Current bank balance`
      $`Current bank balance`$description
      $`Current bank balance`$description$source_data
      $`Current bank balance`$description$source_data$name
      [1] "Current bank balance"
      
      $`Current bank balance`$description$source_data$internal_variable_name
      [1] "dqa_bank_balance"
      
      $`Current bank balance`$description$source_data$description
      [1] "The bank-balance at the time of contact"
      
      $`Current bank balance`$description$source_data$var_name
      [1] "BANK-BALANCE"
      
      $`Current bank balance`$description$source_data$table_name
      [1] "dqa_example_data_01.csv"
      
      $`Current bank balance`$description$source_data$checks
      $`Current bank balance`$description$source_data$checks$var_type
      [1] "integer"
      
      $`Current bank balance`$description$source_data$checks$constraints
      [1] "{\"range\":{\"min\":\"-Inf\",\"max\":\"Inf\",\"unit\":\"money\"}} "
      
      
      
      $`Current bank balance`$description$target_data
      $`Current bank balance`$description$target_data$var_name
      [1] "BANK-BALANCE"
      
      $`Current bank balance`$description$target_data$table_name
      [1] "dqa_example_data_02.csv"
      
      $`Current bank balance`$description$target_data$checks
      $`Current bank balance`$description$target_data$checks$var_type
      [1] "integer"
      
      $`Current bank balance`$description$target_data$checks$constraints
      [1] "{\"range\":{\"min\":\"-Inf\",\"max\":\"Inf\",\"unit\":\"money\"}} "
      
      
      
      
      $`Current bank balance`$counts
      $`Current bank balance`$counts$source_data
      $`Current bank balance`$counts$source_data$cnt
                 variable  n valids missings distinct      sourcesystem
      1: dqa_bank_balance 23     23        0       22 exampleCSV_source
      
      $`Current bank balance`$counts$source_data$type
      [1] "integer"
      
      
      $`Current bank balance`$counts$target_data
      $`Current bank balance`$counts$target_data$cnt
                 variable  n valids missings distinct      sourcesystem
      1: dqa_bank_balance 23     23        0       22 exampleCSV_target
      
      $`Current bank balance`$counts$target_data$type
      [1] "integer"
      
      
      
      $`Current bank balance`$statistics
      $`Current bank balance`$statistics$source_data
                                
       1:     Mean      35152.17
       2:  Minimum        -34200
       3:   Median         18800
       4:  Maximum        124100
       5:       SD      39516.63
       6:  Negativ             2
       7:     Zero             0
       8: Positive            21
       9:    OutLo             0
      10:    OutHi             0
      11: Variance 1561564426.88
      12:    Range        158300
      
      $`Current bank balance`$statistics$target_data
                                
       1:     Mean      26395.65
       2:  Minimum        -64200
       3:   Median         12800
       4:  Maximum        124100
       5:       SD       46097.8
       6:  Negativ             4
       7:     Zero             0
       8: Positive            19
       9:    OutLo             0
      10:    OutHi             0
      11: Variance 2125006798.42
      12:    Range        188300
      
      
      
      $`Date of contact`
      $`Date of contact`$description
      $`Date of contact`$description$source_data
      $`Date of contact`$description$source_data$name
      [1] "Date of contact"
      
      $`Date of contact`$description$source_data$internal_variable_name
      [1] "dqa_contact_date"
      
      $`Date of contact`$description$source_data$description
      [1] "Date of contact"
      
      $`Date of contact`$description$source_data$var_name
      [1] "CONTACT-DATE"
      
      $`Date of contact`$description$source_data$table_name
      [1] "dqa_example_data_01.csv"
      
      $`Date of contact`$description$source_data$checks
      $`Date of contact`$description$source_data$checks$var_type
      [1] "datetime"
      
      $`Date of contact`$description$source_data$checks$constraints
      [1] "{\"datetime\": {\"min\": \"2012-01-01\",\"max\": \"2015-12-31\", \"format\": \"%d.%m.%Y\"}}"
      
      
      
      $`Date of contact`$description$target_data
      $`Date of contact`$description$target_data$var_name
      [1] "CONTACT-DATE"
      
      $`Date of contact`$description$target_data$table_name
      [1] "dqa_example_data_02.csv"
      
      $`Date of contact`$description$target_data$checks
      $`Date of contact`$description$target_data$checks$var_type
      [1] "datetime"
      
      $`Date of contact`$description$target_data$checks$constraints
      [1] "{\"datetime\": {\"min\": \"2012-01-01\",\"max\": \"2015-12-31\", \"format\": \"%d.%m.%Y\"}}"
      
      
      
      
      $`Date of contact`$counts
      $`Date of contact`$counts$source_data
      $`Date of contact`$counts$source_data$cnt
                 variable  n valids missings distinct      sourcesystem
      1: dqa_contact_date 23     23        0       23 exampleCSV_source
      
      $`Date of contact`$counts$source_data$type
      [1] "datetime"
      
      
      $`Date of contact`$counts$target_data
      $`Date of contact`$counts$target_data$cnt
                 variable  n valids missings distinct      sourcesystem
      1: dqa_contact_date 23     23        0       23 exampleCSV_target
      
      $`Date of contact`$counts$target_data$type
      [1] "datetime"
      
      
      
      $`Date of contact`$statistics
      $`Date of contact`$statistics$source_data
                          
      1    Min. 2011-10-12
      2 1st Qu. 2012-08-11
      3  Median 2013-10-02
      4    Mean 2013-10-28
      5 3rd Qu. 2014-12-21
      6    Max. 2015-12-20
      
      $`Date of contact`$statistics$target_data
                          
      1    Min. 2011-10-12
      2 1st Qu. 2012-08-11
      3  Median 2013-10-02
      4    Mean 2013-10-28
      5 3rd Qu. 2014-12-21
      6    Max. 2015-12-20
      
      
      
      $Forename
      $Forename$description
      $Forename$description$source_data
      $Forename$description$source_data$name
      [1] "Forename"
      
      $Forename$description$source_data$internal_variable_name
      [1] "dqa_forename"
      
      $Forename$description$source_data$description
      [1] "The Forename of the person."
      
      $Forename$description$source_data$var_name
      [1] "FORENAME"
      
      $Forename$description$source_data$table_name
      [1] "dqa_example_data_01.csv"
      
      $Forename$description$source_data$checks
      $Forename$description$source_data$checks$var_type
      [1] "string"
      
      $Forename$description$source_data$checks$constraints
      [1] NA
      
      
      
      $Forename$description$target_data
      $Forename$description$target_data$var_name
      [1] "FORENAME"
      
      $Forename$description$target_data$table_name
      [1] "dqa_example_data_02.csv"
      
      $Forename$description$target_data$checks
      $Forename$description$target_data$checks$var_type
      [1] "string"
      
      $Forename$description$target_data$checks$constraints
      [1] NA
      
      
      
      
      $Forename$counts
      $Forename$counts$source_data
      $Forename$counts$source_data$cnt
             variable  n valids missings distinct      sourcesystem
      1: dqa_forename 23     23        0       17 exampleCSV_source
      
      $Forename$counts$source_data$type
      [1] "string"
      
      
      $Forename$counts$target_data
      $Forename$counts$target_data$cnt
             variable  n valids missings distinct      sourcesystem
      1: dqa_forename 23     23        0       16 exampleCSV_target
      
      $Forename$counts$target_data$type
      [1] "string"
      
      
      
      $Forename$statistics
      $Forename$statistics$source_data
          dqa_forename Freq   % Valid
       1:      Zenaida    3 13.043478
       2:    Geraldine    2  8.695652
       3:     Williams    2  8.695652
       4:        Wayne    2  8.695652
       5:      Dorothy    2  8.695652
       6:     Lawrence    1  4.347826
       7:        Janet    1  4.347826
       8:       Martin    1  4.347826
       9:     Georgina    1  4.347826
      10:      Elliott    1  4.347826
      11:     Gilberto    1  4.347826
      12:        Annie    1  4.347826
      13:        Karen    1  4.347826
      14:         John    1  4.347826
      15:        Susan    1  4.347826
      16:       Elijah    1  4.347826
      17:       Miriam    1  4.347826
      
      $Forename$statistics$target_data
          dqa_forename Freq   % Valid
       1:    Geraldine    3 13.043478
       2:      Zenaida    3 13.043478
       3:     Williams    2  8.695652
       4:        Wayne    2  8.695652
       5:      Dorothy    2  8.695652
       6:     Lawrence    1  4.347826
       7:        Janet    1  4.347826
       8:       Martin    1  4.347826
       9:     Georgina    1  4.347826
      10:      Elliott    1  4.347826
      11:     Gilberto    1  4.347826
      12:        Annie    1  4.347826
      13:        Karen    1  4.347826
      14:         John    1  4.347826
      15:        Susan    1  4.347826
      16:       Elijah    1  4.347826
      
      
      
      $Income
      $Income$description
      $Income$description$source_data
      $Income$description$source_data$name
      [1] "Income"
      
      $Income$description$source_data$internal_variable_name
      [1] "dqa_income"
      
      $Income$description$source_data$description
      [1] "The income of the person at the time of contact"
      
      $Income$description$source_data$var_name
      [1] "INCOME"
      
      $Income$description$source_data$table_name
      [1] "dqa_example_data_01.csv"
      
      $Income$description$source_data$checks
      $Income$description$source_data$checks$var_type
      [1] "integer"
      
      $Income$description$source_data$checks$constraints
      [1] "{\"range\":{\"min\":0,\"max\":\"Inf\",\"unit\":\"money\"}} "
      
      
      
      $Income$description$target_data
      $Income$description$target_data$var_name
      [1] "INCOME"
      
      $Income$description$target_data$table_name
      [1] "dqa_example_data_02.csv"
      
      $Income$description$target_data$checks
      $Income$description$target_data$checks$var_type
      [1] "integer"
      
      $Income$description$target_data$checks$constraints
      [1] "{\"range\":{\"min\":0,\"max\":\"Inf\",\"unit\":\"money\"}} "
      
      
      
      
      $Income$counts
      $Income$counts$source_data
      $Income$counts$source_data$cnt
           variable  n valids missings distinct      sourcesystem
      1: dqa_income 23     23        0       23 exampleCSV_source
      
      $Income$counts$source_data$type
      [1] "integer"
      
      
      $Income$counts$target_data
      $Income$counts$target_data$cnt
           variable  n valids missings distinct      sourcesystem
      1: dqa_income 23     23        0       23 exampleCSV_target
      
      $Income$counts$target_data$type
      [1] "integer"
      
      
      
      $Income$statistics
      $Income$statistics$source_data
                                
       1:     Mean      68826.09
       2:  Minimum          3000
       3:   Median         59000
       4:  Maximum        145000
       5:       SD      46841.76
       6:  Negativ             0
       7:     Zero             0
       8: Positive            23
       9:    OutLo             0
      10:    OutHi             0
      11: Variance 2194150197.63
      12:    Range        142000
      
      $Income$statistics$target_data
                                
       1:     Mean       68391.3
       2:  Minimum         -5000
       3:   Median         59000
       4:  Maximum        145000
       5:       SD      47502.86
       6:  Negativ             1
       7:     Zero             0
       8: Positive            22
       9:    OutLo             0
      10:    OutHi             0
      11: Variance 2256521739.13
      12:    Range        150000
      
      
      
      $Job
      $Job$description
      $Job$description$source_data
      $Job$description$source_data$name
      [1] "Job"
      
      $Job$description$source_data$internal_variable_name
      [1] "dqa_job"
      
      $Job$description$source_data$description
      [1] "The job of the person at the time of contact"
      
      $Job$description$source_data$var_name
      [1] "JOB"
      
      $Job$description$source_data$table_name
      [1] "dqa_example_data_01.csv"
      
      $Job$description$source_data$checks
      $Job$description$source_data$checks$var_type
      [1] "string"
      
      $Job$description$source_data$checks$constraints
      [1] NA
      
      
      
      $Job$description$target_data
      $Job$description$target_data$var_name
      [1] "JOB"
      
      $Job$description$target_data$table_name
      [1] "dqa_example_data_02.csv"
      
      $Job$description$target_data$checks
      $Job$description$target_data$checks$var_type
      [1] "string"
      
      $Job$description$target_data$checks$constraints
      [1] NA
      
      
      
      
      $Job$counts
      $Job$counts$source_data
      $Job$counts$source_data$cnt
         variable  n valids missings distinct      sourcesystem
      1:  dqa_job 23     23        0       15 exampleCSV_source
      
      $Job$counts$source_data$type
      [1] "string"
      
      
      $Job$counts$target_data
      $Job$counts$target_data$cnt
         variable  n valids missings distinct      sourcesystem
      1:  dqa_job 23     23        0       15 exampleCSV_target
      
      $Job$counts$target_data$type
      [1] "string"
      
      
      
      $Job$statistics
      $Job$statistics$source_data
               dqa_job Freq   % Valid
       1: Bank manager    3 13.043478
       2:     Magician    3 13.043478
       3:      Student    2  8.695652
       4:        Pilot    2  8.695652
       5:       Lawyer    2  8.695652
       6:       Singer    2  8.695652
       7: Photographer    1  4.347826
       8:       Farmer    1  4.347826
       9:    Professor    1  4.347826
      10:     Engineer    1  4.347826
      11:   Researcher    1  4.347826
      12:      Chemist    1  4.347826
      13:     Gardener    1  4.347826
      14: Psychologist    1  4.347826
      15:     Comedian    1  4.347826
      
      $Job$statistics$target_data
               dqa_job Freq   % Valid
       1: Bank manager    3 13.043478
       2:     Magician    3 13.043478
       3:      Student    2  8.695652
       4:        Pilot    2  8.695652
       5:       Lawyer    2  8.695652
       6:       Singer    2  8.695652
       7: Photographer    1  4.347826
       8:       Farmer    1  4.347826
       9:    Professor    1  4.347826
      10:     Engineer    1  4.347826
      11:   Researcher    1  4.347826
      12:      Chemist    1  4.347826
      13:     Gardener    1  4.347826
      14: Psychologist    1  4.347826
      15:     Comedian    1  4.347826
      
      
      
      $Name
      $Name$description
      $Name$description$source_data
      $Name$description$source_data$name
      [1] "Name"
      
      $Name$description$source_data$internal_variable_name
      [1] "dqa_name"
      
      $Name$description$source_data$description
      [1] "The Surname of the person."
      
      $Name$description$source_data$var_name
      [1] "NAME"
      
      $Name$description$source_data$table_name
      [1] "dqa_example_data_01.csv"
      
      $Name$description$source_data$checks
      $Name$description$source_data$checks$var_type
      [1] "string"
      
      $Name$description$source_data$checks$constraints
      [1] NA
      
      
      
      $Name$description$target_data
      $Name$description$target_data$var_name
      [1] "NAME"
      
      $Name$description$target_data$table_name
      [1] "dqa_example_data_02.csv"
      
      $Name$description$target_data$checks
      $Name$description$target_data$checks$var_type
      [1] "string"
      
      $Name$description$target_data$checks$constraints
      [1] NA
      
      
      
      
      $Name$counts
      $Name$counts$source_data
      $Name$counts$source_data$cnt
         variable  n valids missings distinct      sourcesystem
      1: dqa_name 23     23        0       16 exampleCSV_source
      
      $Name$counts$source_data$type
      [1] "string"
      
      
      $Name$counts$target_data
      $Name$counts$target_data$cnt
         variable  n valids missings distinct      sourcesystem
      1: dqa_name 23     23        0       16 exampleCSV_target
      
      $Name$counts$target_data$type
      [1] "string"
      
      
      
      $Name$statistics
      $Name$statistics$source_data
           dqa_name Freq   % Valid
       1:   Jackson    3 13.043478
       2:    Staggs    3 13.043478
       3: Rodriguez    2  8.695652
       4:   Burdett    2  8.695652
       5:   Simpson    2  8.695652
       6:   Daniels    1  4.347826
       7:    Dardar    1  4.347826
       8:     Jones    1  4.347826
       9:      Cook    1  4.347826
      10:    Eatmon    1  4.347826
      11:    Kenney    1  4.347826
      12:     Stock    1  4.347826
      13:     Shuck    1  4.347826
      14:    Malloy    1  4.347826
      15:  Kirkland    1  4.347826
      16:    Sutton    1  4.347826
      
      $Name$statistics$target_data
           dqa_name Freq   % Valid
       1:   Jackson    3 13.043478
       2:    Staggs    3 13.043478
       3: Rodriguez    2  8.695652
       4:   Burdett    2  8.695652
       5:   Simpson    2  8.695652
       6:   Daniels    1  4.347826
       7:    Dardar    1  4.347826
       8:     Jones    1  4.347826
       9:      Cook    1  4.347826
      10:    Eatmon    1  4.347826
      11:    Kenney    1  4.347826
      12:     Stock    1  4.347826
      13:     Shuck    1  4.347826
      14:    Malloy    1  4.347826
      15:  Kirkland    1  4.347826
      16:    Sutton    1  4.347826
      
      
      
      $`Person ID`
      $`Person ID`$description
      $`Person ID`$description$source_data
      $`Person ID`$description$source_data$name
      [1] "Person ID"
      
      $`Person ID`$description$source_data$internal_variable_name
      [1] "dqa_person_id"
      
      $`Person ID`$description$source_data$description
      [1] "Each person has its own person-id. It stays the same over the whole live of the person and does not change."
      
      $`Person ID`$description$source_data$var_name
      [1] "PERSON_ID"
      
      $`Person ID`$description$source_data$table_name
      [1] "dqa_example_data_01.csv"
      
      $`Person ID`$description$source_data$checks
      $`Person ID`$description$source_data$checks$var_type
      [1] "string"
      
      $`Person ID`$description$source_data$checks$constraints
      [1] NA
      
      
      
      $`Person ID`$description$target_data
      $`Person ID`$description$target_data$var_name
      [1] "PERSON_ID"
      
      $`Person ID`$description$target_data$table_name
      [1] "dqa_example_data_02.csv"
      
      $`Person ID`$description$target_data$checks
      $`Person ID`$description$target_data$checks$var_type
      [1] "string"
      
      $`Person ID`$description$target_data$checks$constraints
      [1] NA
      
      
      
      
      $`Person ID`$counts
      $`Person ID`$counts$source_data
      $`Person ID`$counts$source_data$cnt
              variable  n valids missings distinct      sourcesystem
      1: dqa_person_id 23     23        0       16 exampleCSV_source
      
      $`Person ID`$counts$source_data$type
      [1] "string"
      
      
      $`Person ID`$counts$target_data
      $`Person ID`$counts$target_data$cnt
              variable  n valids missings distinct      sourcesystem
      1: dqa_person_id 23     23        0       16 exampleCSV_target
      
      $`Person ID`$counts$target_data$type
      [1] "string"
      
      
      
      $`Person ID`$statistics
      $`Person ID`$statistics$source_data
          dqa_person_id Freq   % Valid
       1:             1    3 13.043478
       2:             7    3 13.043478
       3:             5    2  8.695652
       4:            11    2  8.695652
       5:            15    2  8.695652
       6:             2    1  4.347826
       7:             3    1  4.347826
       8:             4    1  4.347826
       9:             6    1  4.347826
      10:             8    1  4.347826
      11:             9    1  4.347826
      12:            10    1  4.347826
      13:            12    1  4.347826
      14:            13    1  4.347826
      15:            14    1  4.347826
      16:            16    1  4.347826
      
      $`Person ID`$statistics$target_data
          dqa_person_id Freq   % Valid
       1:             1    3 13.043478
       2:             7    3 13.043478
       3:             5    2  8.695652
       4:            11    2  8.695652
       5:            15    2  8.695652
       6:             2    1  4.347826
       7:             3    1  4.347826
       8:             4    1  4.347826
       9:             6    1  4.347826
      10:             8    1  4.347826
      11:             9    1  4.347826
      12:            10    1  4.347826
      13:            12    1  4.347826
      14:            13    1  4.347826
      15:            14    1  4.347826
      16:            16    1  4.347826
      
      
      
      $Sex
      $Sex$description
      $Sex$description$source_data
      $Sex$description$source_data$name
      [1] "Sex"
      
      $Sex$description$source_data$internal_variable_name
      [1] "dqa_sex"
      
      $Sex$description$source_data$description
      [1] "The sex of the person in one letter: m, f or x for unknown."
      
      $Sex$description$source_data$var_name
      [1] "SEX"
      
      $Sex$description$source_data$table_name
      [1] "dqa_example_data_01.csv"
      
      $Sex$description$source_data$checks
      $Sex$description$source_data$checks$var_type
      [1] "enumerated"
      
      $Sex$description$source_data$checks$constraints
      [1] "{\"value_set\":[\"m\", \"f\", \"x\"]} "
      
      
      
      $Sex$description$target_data
      $Sex$description$target_data$var_name
      [1] "SEX"
      
      $Sex$description$target_data$table_name
      [1] "dqa_example_data_02.csv"
      
      $Sex$description$target_data$checks
      $Sex$description$target_data$checks$var_type
      [1] "enumerated"
      
      $Sex$description$target_data$checks$constraints
      [1] "{\"value_set\":[\"male\", \"female\", \"unknown\"]} "
      
      
      
      
      $Sex$counts
      $Sex$counts$source_data
      $Sex$counts$source_data$cnt
         variable  n valids missings distinct      sourcesystem
      1:  dqa_sex 23     23        0        2 exampleCSV_source
      
      $Sex$counts$source_data$type
      [1] "enumerated"
      
      
      $Sex$counts$target_data
      $Sex$counts$target_data$cnt
         variable  n valids missings distinct      sourcesystem
      1:  dqa_sex 23     23        0        3 exampleCSV_target
      
      $Sex$counts$target_data$type
      [1] "enumerated"
      
      
      
      $Sex$statistics
      $Sex$statistics$source_data
         dqa_sex Freq  % Valid
      1:       f   13 56.52174
      2:       m   10 43.47826
      
      $Sex$statistics$target_data
         dqa_sex Freq   % Valid
      1:  female   12 52.173913
      2:    male   10 43.478261
      3:     abc    1  4.347826
      
      
      

---

    Code
      rv$conformance$value_conformance
    Output
      $`Age in years`
      $`Age in years`$source_data
      $`Age in years`$source_data$conformance_error
      [1] FALSE
      
      $`Age in years`$source_data$conformance_results
      [1] "No 'value conformance' issues found."
      
      
      $`Age in years`$target_data
      $`Age in years`$target_data$conformance_error
      [1] TRUE
      
      $`Age in years`$target_data$conformance_results
      [1] "Extrem values are not conform with constraints."
      
      
      
      $`Amount of credit`
      $`Amount of credit`$source_data
      $`Amount of credit`$source_data$conformance_error
      [1] FALSE
      
      $`Amount of credit`$source_data$conformance_results
      [1] "No 'value conformance' issues found."
      
      
      $`Amount of credit`$target_data
      $`Amount of credit`$target_data$conformance_error
      [1] FALSE
      
      $`Amount of credit`$target_data$conformance_results
      [1] "No 'value conformance' issues found."
      
      
      
      $Birthdate
      $Birthdate$source_data
      $Birthdate$source_data$conformance_error
      [1] TRUE
      
      $Birthdate$source_data$conformance_results
      [1] "Extrem values are not conform with constraints."
      
      $Birthdate$source_data$rule
      $Birthdate$source_data$rule$min
      [1] "1950-01-01"
      
      $Birthdate$source_data$rule$max
      [1] "1989-12-31"
      
      $Birthdate$source_data$rule$format
      [1] "%d.%m.%Y"
      
      
      
      $Birthdate$target_data
      $Birthdate$target_data$conformance_error
      [1] TRUE
      
      $Birthdate$target_data$conformance_results
      [1] "Extrem values are not conform with constraints."
      
      $Birthdate$target_data$rule
      $Birthdate$target_data$rule$min
      [1] "1950-01-01"
      
      $Birthdate$target_data$rule$max
      [1] "1989-12-31"
      
      $Birthdate$target_data$rule$format
      [1] "%d.%m.%Y"
      
      
      
      
      $`Credit worthy?`
      $`Credit worthy?`$source_data
      $`Credit worthy?`$source_data$conformance_error
      [1] FALSE
      
      $`Credit worthy?`$source_data$conformance_results
      [1] "No 'value conformance' issues found."
      
      
      $`Credit worthy?`$target_data
      $`Credit worthy?`$target_data$conformance_error
      [1] FALSE
      
      $`Credit worthy?`$target_data$conformance_results
      [1] "No 'value conformance' issues found."
      
      
      
      $`Current bank balance`
      $`Current bank balance`$source_data
      $`Current bank balance`$source_data$conformance_error
      [1] TRUE
      
      $`Current bank balance`$source_data$conformance_results
      [1] "Extrem values are not conform with constraints."
      
      
      $`Current bank balance`$target_data
      $`Current bank balance`$target_data$conformance_error
      [1] TRUE
      
      $`Current bank balance`$target_data$conformance_results
      [1] "Extrem values are not conform with constraints."
      
      
      
      $`Date of contact`
      $`Date of contact`$source_data
      $`Date of contact`$source_data$conformance_error
      [1] TRUE
      
      $`Date of contact`$source_data$conformance_results
      [1] "Extrem values are not conform with constraints."
      
      $`Date of contact`$source_data$rule
      $`Date of contact`$source_data$rule$min
      [1] "2012-01-01"
      
      $`Date of contact`$source_data$rule$max
      [1] "2015-12-31"
      
      $`Date of contact`$source_data$rule$format
      [1] "%d.%m.%Y"
      
      
      
      $`Date of contact`$target_data
      $`Date of contact`$target_data$conformance_error
      [1] TRUE
      
      $`Date of contact`$target_data$conformance_results
      [1] "Extrem values are not conform with constraints."
      
      $`Date of contact`$target_data$rule
      $`Date of contact`$target_data$rule$min
      [1] "2012-01-01"
      
      $`Date of contact`$target_data$rule$max
      [1] "2015-12-31"
      
      $`Date of contact`$target_data$rule$format
      [1] "%d.%m.%Y"
      
      
      
      
      $Income
      $Income$source_data
      $Income$source_data$conformance_error
      [1] FALSE
      
      $Income$source_data$conformance_results
      [1] "No 'value conformance' issues found."
      
      
      $Income$target_data
      $Income$target_data$conformance_error
      [1] TRUE
      
      $Income$target_data$conformance_results
      [1] "Extrem values are not conform with constraints."
      
      
      
      $Sex
      $Sex$source_data
      $Sex$source_data$conformance_error
      [1] FALSE
      
      $Sex$source_data$conformance_results
      [1] "No 'value conformance' issues found."
      
      
      $Sex$target_data
      $Sex$target_data$conformance_error
      [1] TRUE
      
      $Sex$target_data$conformance_results
      [1] "Levels that are not conform with the value set:  \nabc"
      
      
      
      $pl.atemporal.item01
      $pl.atemporal.item01$source_data
      $pl.atemporal.item01$source_data$conformance_error
      [1] FALSE
      
      $pl.atemporal.item01$source_data$conformance_results
      [1] "No 'value conformance' issues found."
      
      
      $pl.atemporal.item01$target_data
      $pl.atemporal.item01$target_data$conformance_error
      [1] TRUE
      
      $pl.atemporal.item01$target_data$conformance_results
      [1] "Levels that are not conform with the value set:  \nyes"
      
      $pl.atemporal.item01$target_data$affected_ids
         dqa_bank_balance
      1:           -36500
      2:           -64200
      
      
      

---

    Code
      rv$completeness
    Output
                      Variable Missings (source) Missings [%] (source) Missings (target) Missings [%] (target)
       1:         Age in years                 0                     0                 0                     0
       2:     Amount of credit                13                 56.52                13                 56.52
       3:            Birthdate                 0                     0                 0                     0
       4:       Credit worthy?                 0                     0                 0                     0
       5: Current bank balance                 0                     0                 0                     0
       6:      Date of contact                 0                     0                 0                     0
       7:             Forename                 0                     0                 0                     0
       8:               Income                 0                     0                 0                     0
       9:                  Job                 0                     0                 0                     0
      10:                 Name                 0                     0                 0                     0
      11:            Person ID                 0                     0                 0                     0
      12:                  Sex                 0                     0                 0                     0

---

    Code
      rv$checks$value_conformance
    Output
                     Variable Check Source Data Check Target Data
      1:         Age in years            passed            failed
      2:     Amount of credit            passed            passed
      3:            Birthdate            failed            failed
      4:       Credit worthy?            passed            passed
      5: Current bank balance            failed            failed
      6:      Date of contact            failed            failed
      7:               Income            passed            failed
      8:                  Sex            passed            failed
      9:  pl.atemporal.item01            passed            failed

---

    Code
      rv$checks$etl
    Output
                      Variable Check Distincts Check Valids Check Missings
       1:         Age in years          passed       passed         passed
       2:     Amount of credit          passed       passed         passed
       3:            Birthdate          passed       passed         passed
       4:       Credit worthy?          passed       passed         passed
       5: Current bank balance          passed       passed         passed
       6:      Date of contact          passed       passed         passed
       7:             Forename          failed       passed         passed
       8:               Income          passed       passed         passed
       9:                  Job          passed       passed         passed
      10:                 Name          passed       passed         passed
      11:            Person ID          passed       passed         passed
      12:                  Sex          failed       passed         passed

---

    Code
      rv$datamap
    Output
      $source_data
               variable  n valids missings distinct
      1:      Person ID 23     23        0       16
      2: Credit worthy? 23     23        0        2
      
      $target_data
               variable  n valids missings distinct
      1:      Person ID 23     23        0       16
      2: Credit worthy? 23     23        0        2
      

