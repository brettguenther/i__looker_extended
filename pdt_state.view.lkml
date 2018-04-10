view: pdt_state {
  derived_table: {
  sql:SELECT
      event_log.at,
      event_log.connection,
      event_log.view_name,
      event_log.table_name,
      TIME_TO_SEC(TIMEDIFF(FROM_UNIXTIME(event_log.at),FROM_UNIXTIME(event_log_2.at))) as `seconds_to_build`
      FROM pdt_event_log event_log
      LEFT JOIN pdt_event_log event_log_2 ON event_log_2.tid = event_log.tid
      where event_log.action = 'create complete'
      AND event_log_2.action = 'create begin'
      AND event_log_2.tid is not null
      and event_log.tid is not null
      group by 1,2,3,4,5;;
  }
  dimension_group: start {
    type: time
    timeframes: [time,date,week,month]
    sql: ${TABLE}.at ;;
    datatype: epoch
  }

  dimension: connection {
    type: string
    sql: ${TABLE}.connection ;;
  }

  dimension: view_name {
    type: string
    sql: ${TABLE}.view_name ;;
  }

  dimension: table_name {
    type: string
    sql: ${TABLE}.table_name ;;
  }
  dimension: seconds_to_build  {
    type: number
    sql: ${TABLE}.seconds_to_build ;;
  }
  dimension: minutes_to_build  {
    type: number
    sql: ${seconds_to_build}/60 ;;
    value_format_name: decimal_2
  }
  measure: average_minutes_to_build  {
    type: average
    sql: ${minutes_to_build} ;;
    value_format_name: decimal_2
  }
  measure: max_minutes_to_build  {
    type: max
    sql: ${minutes_to_build} ;;
    value_format_name: decimal_2
  }
  measure: median_minutes_to_build  {
    type: median
    sql: ${minutes_to_build} ;;
    value_format_name: decimal_2
  }
  measure: min_minutes_to_build  {
    type: min
    sql: ${minutes_to_build} ;;
    value_format_name: decimal_2
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }
  set: detail {
    fields: [connection, view_name, table_name, seconds_to_build]
  }
}
