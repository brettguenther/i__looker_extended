view: credentials_saml {
  sql_table_name: credentials_saml ;;
  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: saml_user_id {
    type: string
    sql: ${TABLE}.saml_user_id ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: secret {
    type: string
    sql: ${TABLE}.secret ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: logged_in_at {
    type: time
    sql: ${TABLE}.logged_in_at ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      id,
      user_id,
      saml_user_id,
      email,
      secret,
      created_time,
      logged_in_at_time
    ]
  }
}

view: credentials_openid {
  sql_table_name: credentials_looker_openid ;;
  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: secret {
    type: string
    sql: ${TABLE}.secret ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: last_login_at {
    type: time
    sql: ${TABLE}.last_login_at ;;
  }

  dimension: last_login_ip {
    type: string
    sql: ${TABLE}.last_login_ip ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      id,
      user_id,
      email,
      secret,
      created_time,
      last_login_at_time,
      last_login_ip
    ]
  }
}
