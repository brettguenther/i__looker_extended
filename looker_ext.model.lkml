connection: "looker"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "/i__looker_base/*.view"
include: "/i__looker_base/*.model"

explore: history_full {
  extends: [history]
  view_name: history
  from: history_full
  join: credentials_email {
    from: credentails
    sql_on: ${user.id} = ${credentials_email.user_id} ;;
  }
  join: credentials_ldap {
    fields: []
    sql_on: ${user.id} = ${credentials_ldap.user_id} ;;
  }
}


explore: pdt_log_full  {
  extends: [pdt_log]
  from: pdt_log
 view_name: pdt_log
}

explore: dashboard_full {
  extends: [dashboard]
  join: dashboard_filter {
    sql_on: ${dashboard_filter.dashboard_id} = ${dashboard.id} ;;
    relationship: one_to_many
  }
}

explore: scheduled_plan_full  {
  extends: [scheduled_plan]
  from: scheduled_plan
  view_name: scheduled_plan
}

explore: content_usage {}

explore: event_full {
  extends: [event]
  from: event
  view_name: event
}

explore: look_full {
  extends: [look]
  from: look
  view_name: look
}

explore: dashboard_performance_full {
  extends: [dashboard_performance]
  from: dashboard_run_event_stats
  view_name: dashboard_performance
}
