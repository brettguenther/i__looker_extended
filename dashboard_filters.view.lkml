view: dashboard_filter{
  sql_table_name: dashboard_filter ;;
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: dashboard_id {
    type: string
    sql: ${TABLE}.dashboard_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: default_value {
    type: string
    sql: ${TABLE}.default_value ;;
  }

  dimension: model_name {
    type: string
    sql: ${TABLE}.model_name ;;
  }

  dimension: explore {
    type: string
    sql: ${TABLE}.explore ;;
  }

  dimension: dimension {
    type: string
    sql: ${TABLE}.dimension ;;
  }

  dimension: listens_to_filters_json {
    type: string
    sql: ${TABLE}.listens_to_filters_json ;;
  }

  dimension: row {
    type: string
    sql: ${TABLE}.row ;;
  }

  dimension: deleted_at {
    type: string
    sql: ${TABLE}.deleted_at ;;
  }

  dimension: allow_multiple_values {
    type: string
    sql: ${TABLE}.allow_multiple_values ;;
  }

  dimension: required {
    type: string
    sql: ${TABLE}.required ;;
  }

  dimension: lookml_link_id {
    type: string
    sql: ${TABLE}.lookml_link_id ;;
  }

  set: detail {
    fields: [
      id,
      dashboard_id,
      name,
      title,
      type,
      default_value,
      model_name,
      explore,
      dimension,
      listens_to_filters_json,
      row,
      deleted_at,
      allow_multiple_values,
      required,
      lookml_link_id
    ]
  }

}
