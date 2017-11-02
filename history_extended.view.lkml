include: "/base_looker/history.view"
view: history_full {
  sql_table_name: history ;;
  extends: [history]
  measure: average_runtime_database_queries  {
    type: average
    sql: ${runtime}  ;;
    filters: {
      field: history.result_source
      value: "query"
    }
  }
  measure: count_queries_hitting_database {
    type: count
    filters: {
      field: history.result_source
      value: "query"
    }
  }
  measure: percent_cache_hits {
    type: number
    sql: 1-(${count_queries_hitting_database}/${query_run_count}) ;;
  }
  measure: count_queries_erroring {
    type: count
    filters: {
      field: history.status
      value: "killed"
    }
  }
  measure: percent_queries_erroring {
    type: number
    sql: ${count_queries_erroring}/${query_run_count} ;;
  }
}
