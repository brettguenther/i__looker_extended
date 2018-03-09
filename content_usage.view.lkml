view: content_usage {
  sql_table_name: PUBLIC.CONTENT_USAGE ;;
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    primary_key: yes
    sql: ${TABLE}.ID ;;
  }

  dimension: content_type {
    type: string
    sql: ${TABLE}.CONTENT_TYPE ;;
  }

  dimension: content_id {
    type: string
    sql: ${TABLE}.CONTENT_ID ;;
  }

  dimension_group: last_accessed_at {
    type: time
    sql: ${TABLE}.LAST_ACCESSED_AT ;;
  }

  dimension: days_since_last_accessed {
    sql: DATEDIFF('dd',${last_accessed_at_raw},NOW()) ;;
  }

  dimension: days_since_last_accessed_tiers {
    type: tier
    tiers: [0, 30, 60, 90, 120, 150, 180, 210]
    sql:  ${days_since_last_accessed} ;;
  }

  dimension: prefetch_count {
    type: number
    sql: ${TABLE}.PREFETCH_COUNT ;;
  }

  dimension: embed_count {
    type: number
    sql: ${TABLE}.EMBED_COUNT ;;
  }

  dimension: schedule_count {
    type: number
    sql: ${TABLE}.SCHEDULE_COUNT ;;
  }

  dimension: public_count {
    type: number
    sql: ${TABLE}.PUBLIC_COUNT ;;
  }

  dimension: api_count {
    type: number
    sql: ${TABLE}.API_COUNT ;;
  }

  dimension: other_count {
    type: number
    sql: ${TABLE}.OTHER_COUNT ;;
  }

  dimension: total_count {
    type: number
    sql: ${TABLE}.TOTAL_COUNT ;;
  }

  dimension: favorite_count {
    type: number
    sql: ${TABLE}.FAVORITE_COUNT ;;
  }

  set: detail {
    fields: [
      id,
      content_type,
      content_id,
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
