view: content_usage {
sql_table_name: content_usage;;
  dimension: id {
    type: number
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: content_type {
    type: string
    sql: ${TABLE}.content_type ;;
  }

  dimension: content_id {
    type: string
    sql: ${TABLE}.content_id ;;
  }

  dimension_group: last_accessed_at {
    type: time
    sql: ${TABLE}.last_accessed_at ;;
  }

  dimension: days_since_last_accessed {
    type: number
    sql: DATEDIFF(now(),${last_accessed_at_raw} ;;
  }

  dimension: prefetch_count {
    type: number
    sql: ${TABLE}.prefetch_count ;;
  }

  dimension: embed_count {
    type: number
    sql: ${TABLE}.embed_count ;;
  }

  dimension: schedule_count {
    type: number
    sql: ${TABLE}.schedule_count ;;
  }

  dimension: public_count {
    type: number
    sql: ${TABLE}.public_count ;;
  }

  dimension: api_count {
    type: number
    sql: ${TABLE}.api_count ;;
  }

  dimension: other_count {
    type: number
    sql: ${TABLE}.other_count ;;
  }

  dimension: total_count {
    type: number
    sql: ${TABLE}.total_count ;;
  }

  dimension: favorite_count {
    type: number
    sql: ${TABLE}.favorite_count ;;
  }

  measure: embed_total {
    type: sum
    sql: ${embed_count} ;;
  }

  measure: schedule_total {
    type: sum
    sql: ${embed_count} ;;
  }

  measure: favorites_total {
    type: sum
    sql: ${schedule_count} ;;
  }

  measure: other_total {
    type: sum
    sql: ${other_count} ;;
  }

  measure: api_total {
    type: sum
    sql: ${api_count} ;;
  }

  measure: content_count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      id,
      content_type,
      content_id,
      last_accessed_at_time,
      prefetch_count,
      embed_count,
      schedule_count,
      public_count,
      api_count,
      other_count,
      total_count,
      favorite_count
    ]
  }
}
