include: "/i__looker_base/history.view"
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
  measure: cache_ratio {
    type: number
    sql: (${query_run_count_cache}/${query_run_count}) ;;
    value_format_name: "percent_0"
  }
  measure: query_run_count_no_cache {
    type: count
    filters: {
      field: history.result_source
      value: "query"
    }
  }
  measure: query_run_count_cache {
    type: count
    filters: {
      field: history.result_source
      value: "cache"
    }
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
