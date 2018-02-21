view: content_view {
  sql_table_name: content_view ;;
  dimension: id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: group_id {
    type: number
    sql: ${TABLE}.group_id ;;
  }

  dimension: content_type {
    type: string
    sql: ${TABLE}.content_type ;;
  }

  dimension: content_id {
    type: string
    sql: ${TABLE}.content_id ;;
  }

  dimension_group: last_viewed_at {
    type: time
    sql: ${TABLE}.last_viewed_at ;;
  }

  dimension: favorite_count {
    type: number
    sql: ${TABLE}.favorite_count ;;
  }

  dimension: view_count {
    type: number
    sql: ${TABLE}.view_count ;;
  }

  dimension_group: start_of_week_date {
    type: time
    sql: ${TABLE}.start_of_week_date ;;
  }

  dimension: content_metadata_id {
    type: number
    sql: ${TABLE}.content_metadata_id ;;
  }
  dimension: is_generic {
    type: string
    sql: ${TABLE}.is_generic ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }
  set: detail {
    fields: [
      id,
      user_id,
      group_id,
      content_type,
      content_id,
      last_viewed_at_time,
      favorite_count,
      view_count,
      start_of_week_date_time,
      content_metadata_id,
      is_generic
    ]
  }
}
