#backbone of user_date_combinations_since_user_created
view: user_dates {}

view: user_daily_query_activity {
  derived_table: {
    sql: SELECT
        user.ID  AS user_id,
        DATE(history.CREATED_AT ) AS created_date,
        COUNT(*) AS query_run_count,
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
#     indexes: ["user_id","created_date"]
#     sql_trigger_value: SELECT CURDATE() ;;
  }
  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }
  dimension: user_date {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${created_date},${user_id}) ;;
  }
  dimension_group: created {
    type: time
    timeframes: [date,week,month]
    datatype: date
    sql: ${TABLE}.created_date ;;
  }
  dimension: query_run_count {
    type: number
    hidden: yes
    sql: ${TABLE}.query_run_count ;;
  }
  dimension: dashboard_query_count {
    type: number
    hidden: yes
    sql: ${TABLE}.dashboard_query_count ;;
  }
  dimension: explore_query_count {
    type: number
    hidden: yes
    sql: ${TABLE}.explore_query_count ;;
  }
  dimension: sql_runner_query_count {
    type: number
    hidden: yes
    sql: ${TABLE}.sql_runner_query_count ;;
  }
  dimension: look_query_count {
    type: number
    hidden: yes
    sql: ${TABLE}.look_query_count ;;
  }
  dimension: drill_query_count {
    type: number
    hidden: yes
    sql: ${TABLE}.drill_query_count ;;
  }
  dimension: api_query_count {
    type: number
    hidden: yes
    sql: ${TABLE}.api_query_count ;;
  }
  dimension: pdf_render_query_count {
    type: number
    hidden: yes
    sql: ${TABLE}.pdf_render_query_count;;
  }
  dimension: approximate_usage_in_minutes {
    type: number
    hidden: yes
    sql: ${TABLE}.approximate_usage_in_minutes ;;
  }
  measure: sum_query_run {
    type: sum
    sql: ${query_run_count} ;;
  }
  measure: sum_approximate_usage_in_minutes {
    type: sum
    sql: ${approximate_usage_in_minutes} ;;
  }
  measure: sum_dashboard_queries_run {
    type: sum
    sql: ${dashboard_query_count} ;;
  }
  dimension: user_type {
    case: {
      when: {
        label: "Developer"
        sql: ${user_daily_app_activity.git_commit_count} > 5 ;;
      }
      when: {
        label: "Power User/Creator"
        sql: ${user_daily_app_activity.dashboard_modification_count} > 0 or ${user_daily_app_activity.look_creation_count} > 0  ;;
      }
      when: {
        label: "Explorer"
        sql:  ${explore_query_count} > 0 and ${sql_runner_query_count} = 0 ;;
      }
      when: {
        label: "Dashboard Consumer"
        sql: ${explore_query_count} = 0 and ${sql_runner_query_count} = 0  ;;
      }
      else: "Other"
    }
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
          SUM(CASE WHEN name IN ('update_scheduled_plan','new_scheduled_plan') THEN 1 ELSE 0 END) AS scheduled_plan_creation_count,
          SUM(CASE WHEN name IN ('perform_data_action') THEN 1 ELSE 0 END) as data_action_execution,
          SUM(CASE WHEN name IN ('create_dashboard','create_dashboard_element','delete_dashboard_element','update_dashboard_element','update_dashboard_layout_component','create_dashboard_filter','update_dashboard_filter','delete_dashboard_filter','update_dashboard') THEN 1 ELSE 0 END) AS dashboard_modification_count,
          SUM(CASE WHEN name IN ('create_favorite_content') THEN 1 ELSE 0 END) AS favorite_content_count,
          SUM(CASE WHEN name IN ('create_merge_query') THEN 1 ELSE 0 END) AS merge_query_count,
          SUM(CASE WHEN name IN ('export_query') THEN 1 ELSE 0 END) AS export_query_count,
          SUM(CASE WHEN name IN ('git_commit') THEN 1 ELSE 0 END) AS git_commit_count
          FROM event  AS event
          -- LEFT JOIN event_attribute on event.id = event_attribute.event_id
          GROUP BY 1,2 ;;
  }
  dimension: user_date {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${created_date},${user_id}) ;;
  }
  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }
  dimension: created_date {
    type: date
    sql: ${TABLE}.created_date ;;
  }
  dimension: git_commit_count {
    type: number
    hidden: yes
    sql: ${TABLE}.git_commit_count ;;
  }
  dimension: look_creation_count {
    type: number
    hidden: yes
    sql: ${TABLE}.look_creation_count ;;
  }
  dimension: scheduled_plan_creation_count {
    type: number
    hidden: yes
    sql: ${TABLE}.scheduled_plan_creation_count ;;
  }
  dimension: data_action_execution {
    type: number
    hidden: yes
    sql: ${TABLE}.data_action_execution ;;
  }
  dimension: dashboard_modification_count {
    type: number
    hidden: yes
    sql: ${TABLE}.dashboard_modification_count ;;
  }
  dimension: favorite_content_count {
    type: number
    hidden: yes
    sql: ${TABLE}.favorite_content_count ;;
  }
  dimension: merge_query_count {
    type: number
    hidden: yes
    sql: ${TABLE}.merge_query_count ;;
  }
  dimension: export_query_count {
    type: number
    hidden: yes
    sql: ${TABLE}.export_query_count ;;
  }
  measure: sum_merge_query {
    type: sum
    sql: ${merge_query_count} ;;
  }
  measure: sum_favorited_content {
    type: sum
    sql: ${favorite_content_count};;
  }
  measure: sum_export_query {
    type: sum
    sql: ${export_query_count};;
  }

  set: detail {
    fields: [
      user_id,
      created_date,
      look_creation_count,
      scheduled_plan_creation_count,
      data_action_execution,
      dashboard_modification_count,
      favorite_content_count,
      merge_query_count,
      export_query_count
    ]
  }
}
