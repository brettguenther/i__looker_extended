connection: "looker"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "/base_looker1/*.view"
include: "/base_looker1/*.model"

explore: history_full {
  extends: [history]
  view_name: history
  from: history_full
#   join: user {
#     from: user_extended
#   }
}

explore: user_full {
  extends: [user]
  view_name: user
  from: user_extended
  join: credentials_email {
    sql_on: ${user.id} = ${credentials_email.user_id} ;;
    relationship: many_to_one
  }
  join: credentials_google {
    sql_on: ${user.id} = ${credentials_google.user_id} ;;
    relationship: many_to_one
  }
  join: credentials_ldap {
    sql_on: ${user.id} = ${credentials_ldap.user_id} ;;
    relationship: many_to_one
  }
  join: credentials_saml {
    sql_on: ${user.id} = ${credentials_saml.user_id} ;;
    relationship: many_to_one
  }
}


explore: pdt_log_full  {
  extends: [pdt_log]
  from: pdt_log
 view_name: pdt_log
}

explore: scheduled_plan_full  {
  extends: [scheduled_plan]
  from: scheduled_plan
  view_name: scheduled_plan
}

explore: event_full {
  extends: [event]
  from: event_extended
  view_name: event
#   join: user {
#     sql_on: ${event.user_id} = ${user.id};;
#   }
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

explore: content_usage {}

explore: content_view {}
