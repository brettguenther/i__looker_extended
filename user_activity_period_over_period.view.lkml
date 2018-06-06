view: user_weekly_app_activity_period_over_period {
  derived_table: {
    sql: SELECT
      -- week
      YEARWEEK(daily_usage.created_date) as week,
      -- user
      daily_usage.user_id,
      -- activity_this_period
      sum(daily_usage.dashboard_query_count) as dashboard_query_count,
      -- activity_metric_last_period
      sum(daily_usage_offset.dashboard_query_count) as dashboard_query_count_last_week,
      sum(daily_usage.look_query_count) as look_query_count,
      sum(daily_usage_offset.look_query_count) as look_query_count_last_week,
      sum(daily_usage.explore_query_count) as explore_query_count,
      sum(daily_usage_offset.explore_query_count) as explore_query_count_last_week
      FROM ${user_daily_query_activity.SQL_TABLE_NAME} AS daily_usage
      -- need to persist to avoid separate temp table as you can't self join on temp tables
      JOIN ${user_daily_query_activity.SQL_TABLE_NAME} AS daily_usage_offset ON daily_usage.user_id  = daily_usage_offset.user_id AND daily_usage.created_date - 1  = daily_usage_offset.created_date
      GROUP BY 1,2
      ;;
    sql_trigger_value: SELECT CURDATE() ;;
    indexes: ["week","user_id"]
  }
  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }
  dimension_group: activity {
    datatype: date
    type: time
    timeframes: [week]
    sql: STR_TO_DATE(CONCAT(${TABLE}.week,' Monday'), '%X%V %W') ;;
  }
  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${user_id},${TABLE}.week}) ;;
  }
  dimension: dashboard_query_count {
    type: number
    hidden: yes
    sql: ${TABLE}.dashboard_query_count ;;
  }
  dimension: dashboard_query_count_last_week {
    type: number
    hidden: yes
    sql: ${TABLE}.dashboard_query_count_last_week ;;
  }
  dimension: explore_query_count {
    type: number
    hidden: yes
    sql: ${TABLE}.explore_query_count ;;
  }
  dimension: explore_query_count_last_week {
    type: number
    hidden: yes
    sql: ${TABLE}.explore_query_count_last_week ;;
  }
  dimension: look_query_count {
    type: number
    hidden: yes
    sql: ${TABLE}.look_query_count ;;
  }
  dimension: look_query_count_last_week {
    type: number
    hidden: yes
    sql: ${TABLE}.look_query_count_last_week ;;
  }
  dimension: user_type {
    case: {
      when: {
        label:"Explorer"
        sql: ${explore_query_count} > 0 ;;
      }
      when: {
        label: "Developer"
        sql: ${explore_query_count} > 0 ;; # need to get dev activity or just SQL runner here
      }
      else: "Consumer"
    }
  }
  measure:  count_dashboard_queries_run {
    type: sum
    sql: ${dashboard_query_count} ;;
  }
  measure:  count_dashboard_queries_run_last_week {
    type: sum
    sql: ${dashboard_query_count_last_week} ;;
  }
  measure: percent_change_dashboard_queries_run {
    type: number
    sql: SUM(${dashboard_query_count})/SUM(${dashboard_query_count_last_week}) ;;
    value_format_name: percent_0
  }
  measure:  count_explore_queries_run {
    type: sum
    sql: ${explore_query_count} ;;
  }
  measure:  count_explore_queries_run_last_week {
    type: sum
    sql: ${explore_query_count_last_week} ;;
  }
  measure: percent_change_explore_queries_run {
    type: number
    sql: SUM(${explore_query_count})/SUM(${explore_query_count_last_week}) ;;
    value_format_name: percent_0
  }
  measure:  count_look_queries_run {
    type: sum
    sql: ${look_query_count} ;;
  }
  measure:  count_look_queries_run_last_week {
    type: sum
    sql: ${look_query_count_last_week} ;;
  }
  measure: percent_change_look_queries_run {
    type: number
    sql: SUM(${explore_query_count})/SUM(${explore_query_count_last_week}) ;;
    value_format_name: percent_0
  }
  dimension: user_count_fall_off {
    type: number
    hidden: yes
    sql: CASE WHEN ${look_query_count} < ${look_query_count_last_week} THEN 1 ELSE 0 END  ;;
  }
  measure: sum_user_count_fall_off {
    type: sum
    sql: ${user_count_fall_off} ;;
  }
}
