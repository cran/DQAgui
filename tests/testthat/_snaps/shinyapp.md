# DQAgui shiny app / launch_app() works

    {
      "type": "character",
      "attributes": {},
      "value": ["sitename", "keys_source", "datamap", "finished_onstart", "affectedids_exported", "ncores", "aggregated_exported", "pl", "datamap_email", "headless", "keys_target", "dqa_assessment", "results_descriptive", "data_plausibility", "results_plausibility_unique", "utilspath", "current_date", "checks", "variable_list", "sitenames", "restricting_date", "data_target", "system_types", "settings", "mdr", "report_created", "mdr_filename", "getdata_source", "conformance", "displaynames", "source", "target", "target_is_source", "data_source", "results_plausibility_atemporal", "systems", "demo_usage", "start", "log", "completeness", "parallel", "create_report", "pl_uniq_vars_filter", "getdata_target", "pl_atemp_vars_filter"]
    }

---

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["pl.atemporal.item01"]
        }
      },
      "value": [
        {
          "type": "list",
          "attributes": {
            "names": {
              "type": "character",
              "attributes": {},
              "value": ["description", "counts", "statistics"]
            }
          },
          "value": [
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["source_data", "target_data"]
                }
              },
              "value": [
                {
                  "type": "list",
                  "attributes": {
                    "names": {
                      "type": "character",
                      "attributes": {},
                      "value": ["name", "description", "var_dependent", "var_independent", "filter", "join_crit", "checks"]
                    }
                  },
                  "value": [
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["Pl.atemporal.Item01"]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["Persons with a negative bank balance cannot be credit worthy"]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["dqa_credit_worthy"]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["dqa_bank_balance"]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["^(-)"]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["dqa_person_id"]
                    },
                    {
                      "type": "list",
                      "attributes": {
                        "names": {
                          "type": "character",
                          "attributes": {},
                          "value": ["constraints", "var_type"]
                        }
                      },
                      "value": [
                        {
                          "type": "character",
                          "attributes": {},
                          "value": ["{\"value_set\":\"no\"}"]
                        },
                        {
                          "type": "character",
                          "attributes": {},
                          "value": ["enumerated"]
                        }
                      ]
                    }
                  ]
                },
                {
                  "type": "list",
                  "attributes": {
                    "names": {
                      "type": "character",
                      "attributes": {},
                      "value": ["name", "var_dependent", "var_independent", "filter", "join_crit", "checks"]
                    }
                  },
                  "value": [
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["Pl.atemporal.Item01"]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["dqa_credit_worthy"]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["dqa_bank_balance"]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["^(-)"]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["dqa_person_id"]
                    },
                    {
                      "type": "list",
                      "attributes": {
                        "names": {
                          "type": "character",
                          "attributes": {},
                          "value": ["constraints", "var_type"]
                        }
                      },
                      "value": [
                        {
                          "type": "character",
                          "attributes": {},
                          "value": ["{\"value_set\":\"no\"}"]
                        },
                        {
                          "type": "character",
                          "attributes": {},
                          "value": ["enumerated"]
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["source_data", "target_data"]
                }
              },
              "value": [
                {
                  "type": "list",
                  "attributes": {
                    "names": {
                      "type": "character",
                      "attributes": {},
                      "value": ["cnt", "type"]
                    }
                  },
                  "value": [
                    {
                      "type": "list",
                      "attributes": {
                        "names": {
                          "type": "character",
                          "attributes": {},
                          "value": ["variable", "n", "valids", "missings", "distinct", "sourcesystem"]
                        },
                        "row.names": {
                          "type": "integer",
                          "attributes": {},
                          "value": [1]
                        },
                        "class": {
                          "type": "character",
                          "attributes": {},
                          "value": ["data.table", "data.frame"]
                        },
                        ".internal.selfref": {
                          "type": "externalptr",
                          "attributes": {},
                          "value": {}
                        }
                      },
                      "value": [
                        {
                          "type": "character",
                          "attributes": {},
                          "value": ["dqa_credit_worthy"]
                        },
                        {
                          "type": "integer",
                          "attributes": {},
                          "value": [2]
                        },
                        {
                          "type": "integer",
                          "attributes": {},
                          "value": [2]
                        },
                        {
                          "type": "integer",
                          "attributes": {},
                          "value": [0]
                        },
                        {
                          "type": "integer",
                          "attributes": {},
                          "value": [1]
                        },
                        {
                          "type": "character",
                          "attributes": {},
                          "value": ["exampleCSV_source"]
                        }
                      ]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["enumerated"]
                    }
                  ]
                },
                {
                  "type": "list",
                  "attributes": {
                    "names": {
                      "type": "character",
                      "attributes": {},
                      "value": ["cnt", "type"]
                    }
                  },
                  "value": [
                    {
                      "type": "list",
                      "attributes": {
                        "names": {
                          "type": "character",
                          "attributes": {},
                          "value": ["variable", "n", "valids", "missings", "distinct", "sourcesystem"]
                        },
                        "row.names": {
                          "type": "integer",
                          "attributes": {},
                          "value": [1]
                        },
                        "class": {
                          "type": "character",
                          "attributes": {},
                          "value": ["data.table", "data.frame"]
                        },
                        ".internal.selfref": {
                          "type": "externalptr",
                          "attributes": {},
                          "value": {}
                        }
                      },
                      "value": [
                        {
                          "type": "character",
                          "attributes": {},
                          "value": ["dqa_credit_worthy"]
                        },
                        {
                          "type": "integer",
                          "attributes": {},
                          "value": [4]
                        },
                        {
                          "type": "integer",
                          "attributes": {},
                          "value": [4]
                        },
                        {
                          "type": "integer",
                          "attributes": {},
                          "value": [0]
                        },
                        {
                          "type": "integer",
                          "attributes": {},
                          "value": [2]
                        },
                        {
                          "type": "character",
                          "attributes": {},
                          "value": ["exampleCSV_target"]
                        }
                      ]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["enumerated"]
                    }
                  ]
                }
              ]
            },
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["source_data", "target_data"]
                }
              },
              "value": [
                {
                  "type": "list",
                  "attributes": {
                    "row.names": {
                      "type": "integer",
                      "attributes": {},
                      "value": [1]
                    },
                    "class": {
                      "type": "character",
                      "attributes": {},
                      "value": ["data.table", "data.frame"]
                    },
                    ".internal.selfref": {
                      "type": "externalptr",
                      "attributes": {},
                      "value": {}
                    },
                    "names": {
                      "type": "character",
                      "attributes": {},
                      "value": ["dqa_credit_worthy", "Freq", "% Valid"]
                    }
                  },
                  "value": [
                    {
                      "type": "integer",
                      "attributes": {
                        "levels": {
                          "type": "character",
                          "attributes": {},
                          "value": ["no"]
                        },
                        "class": {
                          "type": "character",
                          "attributes": {},
                          "value": ["factor"]
                        }
                      },
                      "value": [1]
                    },
                    {
                      "type": "integer",
                      "attributes": {},
                      "value": [2]
                    },
                    {
                      "type": "double",
                      "attributes": {},
                      "value": [100]
                    }
                  ]
                },
                {
                  "type": "list",
                  "attributes": {
                    "row.names": {
                      "type": "integer",
                      "attributes": {},
                      "value": [1, 2]
                    },
                    "class": {
                      "type": "character",
                      "attributes": {},
                      "value": ["data.table", "data.frame"]
                    },
                    ".internal.selfref": {
                      "type": "externalptr",
                      "attributes": {},
                      "value": {}
                    },
                    "names": {
                      "type": "character",
                      "attributes": {},
                      "value": ["dqa_credit_worthy", "Freq", "% Valid"]
                    }
                  },
                  "value": [
                    {
                      "type": "integer",
                      "attributes": {
                        "levels": {
                          "type": "character",
                          "attributes": {},
                          "value": ["no", "yes"]
                        },
                        "class": {
                          "type": "character",
                          "attributes": {},
                          "value": ["factor"]
                        }
                      },
                      "value": [1, 2]
                    },
                    {
                      "type": "integer",
                      "attributes": {},
                      "value": [2, 2]
                    },
                    {
                      "type": "double",
                      "attributes": {},
                      "value": [50, 50]
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    }

---

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["Age in years", "Amount of credit", "Birthdate", "Credit worthy?", "Current bank balance", "Date of contact", "Income", "Sex", "pl.atemporal.item01"]
        }
      },
      "value": [
        {
          "type": "list",
          "attributes": {
            "names": {
              "type": "character",
              "attributes": {},
              "value": ["source_data", "target_data"]
            }
          },
          "value": [
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [false]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["No 'value conformance' issues found."]
                }
              ]
            },
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [true]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["Extrem values are not conform with constraints."]
                }
              ]
            }
          ]
        },
        {
          "type": "list",
          "attributes": {
            "names": {
              "type": "character",
              "attributes": {},
              "value": ["source_data", "target_data"]
            }
          },
          "value": [
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [false]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["No 'value conformance' issues found."]
                }
              ]
            },
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [false]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["No 'value conformance' issues found."]
                }
              ]
            }
          ]
        },
        {
          "type": "list",
          "attributes": {
            "names": {
              "type": "character",
              "attributes": {},
              "value": ["source_data", "target_data"]
            }
          },
          "value": [
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results", "rule"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [true]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["Extrem values are not conform with constraints."]
                },
                {
                  "type": "list",
                  "attributes": {
                    "names": {
                      "type": "character",
                      "attributes": {},
                      "value": ["min", "max", "format"]
                    }
                  },
                  "value": [
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["1950-01-01"]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["1989-12-31"]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["%d.%m.%Y"]
                    }
                  ]
                }
              ]
            },
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results", "rule"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [true]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["Extrem values are not conform with constraints."]
                },
                {
                  "type": "list",
                  "attributes": {
                    "names": {
                      "type": "character",
                      "attributes": {},
                      "value": ["min", "max", "format"]
                    }
                  },
                  "value": [
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["1950-01-01"]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["1989-12-31"]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["%d.%m.%Y"]
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "type": "list",
          "attributes": {
            "names": {
              "type": "character",
              "attributes": {},
              "value": ["source_data", "target_data"]
            }
          },
          "value": [
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [false]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["No 'value conformance' issues found."]
                }
              ]
            },
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [false]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["No 'value conformance' issues found."]
                }
              ]
            }
          ]
        },
        {
          "type": "list",
          "attributes": {
            "names": {
              "type": "character",
              "attributes": {},
              "value": ["source_data", "target_data"]
            }
          },
          "value": [
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [true]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["Extrem values are not conform with constraints."]
                }
              ]
            },
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [true]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["Extrem values are not conform with constraints."]
                }
              ]
            }
          ]
        },
        {
          "type": "list",
          "attributes": {
            "names": {
              "type": "character",
              "attributes": {},
              "value": ["source_data", "target_data"]
            }
          },
          "value": [
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results", "rule"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [true]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["Extrem values are not conform with constraints."]
                },
                {
                  "type": "list",
                  "attributes": {
                    "names": {
                      "type": "character",
                      "attributes": {},
                      "value": ["min", "max", "format"]
                    }
                  },
                  "value": [
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["2012-01-01"]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["2015-12-31"]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["%d.%m.%Y"]
                    }
                  ]
                }
              ]
            },
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results", "rule"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [true]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["Extrem values are not conform with constraints."]
                },
                {
                  "type": "list",
                  "attributes": {
                    "names": {
                      "type": "character",
                      "attributes": {},
                      "value": ["min", "max", "format"]
                    }
                  },
                  "value": [
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["2012-01-01"]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["2015-12-31"]
                    },
                    {
                      "type": "character",
                      "attributes": {},
                      "value": ["%d.%m.%Y"]
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "type": "list",
          "attributes": {
            "names": {
              "type": "character",
              "attributes": {},
              "value": ["source_data", "target_data"]
            }
          },
          "value": [
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [false]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["No 'value conformance' issues found."]
                }
              ]
            },
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [true]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["Extrem values are not conform with constraints."]
                }
              ]
            }
          ]
        },
        {
          "type": "list",
          "attributes": {
            "names": {
              "type": "character",
              "attributes": {},
              "value": ["source_data", "target_data"]
            }
          },
          "value": [
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [false]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["No 'value conformance' issues found."]
                }
              ]
            },
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [true]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["Levels that are not conform with the value set:  \nabc"]
                }
              ]
            }
          ]
        },
        {
          "type": "list",
          "attributes": {
            "names": {
              "type": "character",
              "attributes": {},
              "value": ["source_data", "target_data"]
            }
          },
          "value": [
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [false]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["No 'value conformance' issues found."]
                }
              ]
            },
            {
              "type": "list",
              "attributes": {
                "names": {
                  "type": "character",
                  "attributes": {},
                  "value": ["conformance_error", "conformance_results", "affected_ids"]
                }
              },
              "value": [
                {
                  "type": "logical",
                  "attributes": {},
                  "value": [true]
                },
                {
                  "type": "character",
                  "attributes": {},
                  "value": ["Levels that are not conform with the value set:  \nyes"]
                },
                {
                  "type": "list",
                  "attributes": {
                    "row.names": {
                      "type": "integer",
                      "attributes": {},
                      "value": [1, 2]
                    },
                    "class": {
                      "type": "character",
                      "attributes": {},
                      "value": ["data.table", "data.frame"]
                    },
                    ".internal.selfref": {
                      "type": "externalptr",
                      "attributes": {},
                      "value": {}
                    },
                    "names": {
                      "type": "character",
                      "attributes": {},
                      "value": ["dqa_bank_balance"]
                    }
                  },
                  "value": [
                    {
                      "type": "double",
                      "attributes": {},
                      "value": [-36500, -64200]
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    }

---

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["Variable", "Missings (source)", "Missings [%] (source)", "Missings (target)", "Missings [%] (target)"]
        },
        "row.names": {
          "type": "integer",
          "attributes": {},
          "value": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        },
        "class": {
          "type": "character",
          "attributes": {},
          "value": ["data.table", "data.frame"]
        },
        ".internal.selfref": {
          "type": "externalptr",
          "attributes": {},
          "value": {}
        }
      },
      "value": [
        {
          "type": "character",
          "attributes": {},
          "value": ["Age in years", "Amount of credit", "Birthdate", "Credit worthy?", "Current bank balance", "Date of contact", "Forename", "Income", "Job", "Name", "Person ID", "Sex"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["0", "13", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["0", "56.52", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["0", "13", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["0", "56.52", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"]
        }
      ]
    }

---

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["Variable", "Check Source Data", "Check Target Data"]
        },
        "row.names": {
          "type": "integer",
          "attributes": {},
          "value": [1, 2, 3, 4, 5, 6, 7, 8, 9]
        },
        "class": {
          "type": "character",
          "attributes": {},
          "value": ["data.table", "data.frame"]
        },
        ".internal.selfref": {
          "type": "externalptr",
          "attributes": {},
          "value": {}
        }
      },
      "value": [
        {
          "type": "character",
          "attributes": {},
          "value": ["Age in years", "Amount of credit", "Birthdate", "Credit worthy?", "Current bank balance", "Date of contact", "Income", "Sex", "pl.atemporal.item01"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["passed", "passed", "failed", "passed", "failed", "failed", "passed", "passed", "passed"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["failed", "passed", "failed", "passed", "failed", "failed", "failed", "failed", "failed"]
        }
      ]
    }

---

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["Variable", "Check Distincts", "Check Valids", "Check Missings"]
        },
        "row.names": {
          "type": "integer",
          "attributes": {},
          "value": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        },
        "class": {
          "type": "character",
          "attributes": {},
          "value": ["data.table", "data.frame"]
        },
        ".internal.selfref": {
          "type": "externalptr",
          "attributes": {},
          "value": {}
        }
      },
      "value": [
        {
          "type": "character",
          "attributes": {},
          "value": ["Age in years", "Amount of credit", "Birthdate", "Credit worthy?", "Current bank balance", "Date of contact", "Forename", "Income", "Job", "Name", "Person ID", "Sex"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["passed", "passed", "passed", "passed", "passed", "passed", "failed", "passed", "passed", "passed", "passed", "failed"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["passed", "passed", "passed", "passed", "passed", "passed", "passed", "passed", "passed", "passed", "passed", "passed"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["passed", "passed", "passed", "passed", "passed", "passed", "passed", "passed", "passed", "passed", "passed", "passed"]
        }
      ]
    }

---

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["source_data", "target_data"]
        }
      },
      "value": [
        {
          "type": "list",
          "attributes": {
            "names": {
              "type": "character",
              "attributes": {},
              "value": ["variable", "n", "valids", "missings", "distinct"]
            },
            "row.names": {
              "type": "integer",
              "attributes": {},
              "value": [1, 2]
            },
            "class": {
              "type": "character",
              "attributes": {},
              "value": ["data.table", "data.frame"]
            },
            ".internal.selfref": {
              "type": "externalptr",
              "attributes": {},
              "value": {}
            }
          },
          "value": [
            {
              "type": "character",
              "attributes": {},
              "value": ["Person ID", "Credit worthy?"]
            },
            {
              "type": "character",
              "attributes": {},
              "value": ["23", "23"]
            },
            {
              "type": "character",
              "attributes": {},
              "value": ["23", "23"]
            },
            {
              "type": "character",
              "attributes": {},
              "value": ["0", "0"]
            },
            {
              "type": "character",
              "attributes": {},
              "value": ["16", "2"]
            }
          ]
        },
        {
          "type": "list",
          "attributes": {
            "names": {
              "type": "character",
              "attributes": {},
              "value": ["variable", "n", "valids", "missings", "distinct"]
            },
            "row.names": {
              "type": "integer",
              "attributes": {},
              "value": [1, 2]
            },
            "class": {
              "type": "character",
              "attributes": {},
              "value": ["data.table", "data.frame"]
            },
            ".internal.selfref": {
              "type": "externalptr",
              "attributes": {},
              "value": {}
            }
          },
          "value": [
            {
              "type": "character",
              "attributes": {},
              "value": ["Person ID", "Credit worthy?"]
            },
            {
              "type": "character",
              "attributes": {},
              "value": ["23", "23"]
            },
            {
              "type": "character",
              "attributes": {},
              "value": ["23", "23"]
            },
            {
              "type": "character",
              "attributes": {},
              "value": ["0", "0"]
            },
            {
              "type": "character",
              "attributes": {},
              "value": ["16", "2"]
            }
          ]
        }
      ]
    }

