include: "/base_looker1/history.view"
include: "user_extended.view"
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
    description: "Percent of queries run that leveraged cache"
    sql: (${count_query_run_cache}/${query_run_count}) ;;
    value_format_name: percent_0
  }
  measure: count_query_run_no_cache {
    type: count
    filters: {
      field: history.result_source
      value: "query"
    }
  }
  dimension_group: completed {
    type: time
    datatype: datetime
    sql: ${TABLE}.completed_at ;;
  }
  dimension: months_since_user_created {
    type: number
    sql: TIMESTAMPDIFF(MONTH,${user.first_login_raw},${created_raw}) ;;
  }

  measure: count_query_run_cache {
    type: count
    filters: {
      field: history.result_source
      value: "cache"
    }
  }

  measure: count_queries_killed {
    type: count
    filters: {
      field: history.status
      value: "killed"
    }
  }

  measure: count_queries_errored {
    type: count
    filters: {
      field: history.status
      value: "error"
    }
  }
  measure: percent_queries_killed {
    type: number
    value_format_name: percent_0
    sql: ${count_queries_killed}/${query_run_count} ;;
  }
  measure: percent_queries_errored {
    type: number
    value_format_name: percent_0
    sql: ${count_queries_errored}/${query_run_count} ;;
  }
  dimension: dashboard_run_session_id {
    alias: [dashboard_session]
    sql: ${TABLE}.dashboard_session ;;
  }
}
