view: user_facts {
  derived_table: {
    sql: SELECT
        COALESCE(credentials_email.CREATED_AT,credentials_ldap.CREATED_AT,credentials_google.CREATED_AT,credentials_saml.created_at)  AS first_login,
        user.ID  AS user_id
        FROM user  AS user
        LEFT JOIN credentials_email ON user.ID = credentials_email.USER_ID
        LEFT JOIN credentials_google ON user.ID = credentials_google.USER_ID
        LEFT JOIN credentials_ldap ON user.ID = credentials_ldap.USER_ID
        LEFT JOIN credentials_saml  AS credentials_saml ON user.ID = credentials_saml.user_id
  }
  dimension_group: first_login {
    type: time
    sql: ${TABLE}.first_login ;;
  }
  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  set: detail {
    fields: [user_id]
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }
}

view: user_daily_usage {
  derived_table: {
    sql: SELECT
        user.ID  AS user_id,
        DATE(history.CREATED_AT ) AS created_date,
        COUNT(*) AS query_run_count,
        COUNT(DISTINCT
              CASE WHEN history.source <> 'scheduled_task' THEN
                CONCAT(
                 CAST(history.user_id as CHAR(30)),
                 FLOOR(UNIX_TIMESTAMP(history.created_at)/(60*5))
              )
              ELSE NULL
              END
            )*5
                AS approximate_usage_in_minutes
        FROM history  AS history
        LEFT JOIN user ON history.USER_ID  = user.ID
        GROUP BY 1,2 ;;
  }
  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: created_date {
    type: date
    sql: ${TABLE}.created_date ;;
  }

  dimension: query_run_count {
    type: number
    sql: ${TABLE}.query_run_count ;;
  }

  dimension: approximate_usage_in_minutes {
    type: number
    sql: ${TABLE}.approximate_usage_in_minutes ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }
  set: detail {
    fields: [user_id, created_date, query_run_count, approximate_usage_in_minutes]
  }
}

view: user_daily_activity {
  derived_table: {
    sql: select
          event.USER_ID  AS user_id,
          DATE(event.CREATED_AT ) AS created_date,
          SUM(CASE WHEN name IN ('create_look','save_look') THEN 1 ELSE 0 END) AS look_creation_count,
          SUM(CASE WHEN name IN ('update_scheduled_plan','new_scheduled_plan') THEN 1 ELSE 0 END) AS scheduled_plan_creation,
          SUM(CASE WHEN name IN ('perform_data_action') THEN 1 ELSE 0 END) as data_action_execution,
          SUM(CASE WHEN name IN ('create_dashboard','create_dashboard_element','delete_dashboard_element','update_dashboard_element','update_dashboard_layout_component','create_dashboard_filter','update_dashboard_filter','delete_dashboard_filter','update_dashboard') THEN 1 ELSE 0 END) AS dashboard_creation_count,
          SUM(CASE WHEN name IN ('create_favorite_content') THEN 1 ELSE 0 END) AS favorite_content_count,
          SUM(CASE WHEN name IN ('create_merge_query') THEN 1 ELSE 0 END) AS merge_query_count
          FROM event  AS event
          -- LEFT JOIN sandboxcl.event_attribute on event.id = event_attribute.event_id
          GROUP BY 1,2 ;;
  }
  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: created_date {
    type: date
    sql: ${TABLE}.created_date ;;
  }

  dimension: look_creation_count {
    type: number
    sql: ${TABLE}.look_creation_count ;;
  }

  dimension: scheduled_plan_creation {
    type: number
    sql: ${TABLE}.scheduled_plan_creation ;;
  }

  dimension: data_action_execution {
    type: number
    sql: ${TABLE}.data_action_execution ;;
  }

  dimension: dashboard_creation_count {
    type: number
    sql: ${TABLE}.dashboard_creation_count ;;
  }

  dimension: favorite_content_count {
    type: number
    sql: ${TABLE}.favorite_content_count ;;
  }

  dimension: merge_query_count {
    type: number
    sql: ${TABLE}.merge_query_count ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }
  set: detail {
    fields: [
      user_id,
      created_date,
      look_creation_count,
      scheduled_plan_creation,
      data_action_execution,
      dashboard_creation_count,
      favorite_content_count,
      merge_query_count
    ]
  }

}
