
view: user_weekly_activity {
  derived_table: {
    sql: SELECT
      -- week
      daily_usage.week,
      -- user
      daily_usage.user_id,
      -- activity_this_period
      daily_usage.dashboard_query_count as dashboard_query_count,
      -- activity_metric_last_period
      daily_usage_offset.dashboard_query_count as dashboard_query_count_last_week,
      daily_usage.look_query_count as look_query_count,
      daily_usage_offset.look_query_count as look_query_count_last_week,
      daily_usage.explore_query_count as explore_query_count,
      daily_usage_offset.explore_query_count as explore_query_count_last_week
      FROM ${user_weekly_usage.SQL_TABLE_NAME} AS daily_usage
      -- need to persist to avoid separate temp table as you can't self join on temp tables
      JOIN ${user_weekly_usage.SQL_TABLE_NAME} AS daily_usage_offset ON daily_usage.user_id  = daily_usage_offset.user_id AND daily_usage.week - 1  = daily_usage_offset.week
      GROUP BY 1,2,3,4,5,6,7,8
      ;;
    sql_trigger_value: SELECT CURDATE() ;;
    indexes: ["week","user_id"]
  }
  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }
  dimension: week {
    type: string
    sql: ${TABLE}.week ;;
  }
  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${user_id},${week}) ;;
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
}


#get a date table if I need to zero fill

view: user_first_activity_date {
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

view: user_weekly_usage {
  derived_table: {
    sql: SELECT
        user.ID  AS user_id,
        -- DATE(history.CREATED_AT ) AS created_date,
        YEARWEEK(history.CREATED_AT) AS week,
        COUNT(*) AS query_run_count,
        -- get distinct pieces of content in here
        SUM(CASE WHEN history.source = 'dashboard' THEN 1 ELSE 0 END) AS dashboard_query_count,
        SUM(CASE WHEN history.source = 'explore' THEN 1 ELSE 0 END) AS explore_query_count,
        SUM(CASE WHEN history.source = 'sqlrunner' THEN 1 ELSE 0 END) AS sql_runner_query_count,
        SUM(CASE WHEN history.source = 'look' THEN 1 ELSE 0 END) AS look_query_count,
        SUM(CASE WHEN history.source = 'drill_modal' THEN 1 ELSE 0 END) AS drill_query_count,
        SUM(CASE WHEN history.source = 'api3' THEN 1 ELSE 0 END) AS api_query_count,
        SUM(CASE WHEN history.source LIKE 'render_manager_cache%' THEN 1 ELSE 0 END) as pdf_render_query_count,
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
    indexes: ["user_id","week"]
    sql_trigger_value: SELECT CURDATE() ;;
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

view: user_daily_app_activity {
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
