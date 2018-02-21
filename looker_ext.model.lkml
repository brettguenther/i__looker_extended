include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "/base_looker1/*.view"
include: "/base_looker1/*.model"

explore: project_status {
  hidden: yes
}

explore: content_view  {
  hidden: yes
}

explore: user_weekly_usage {
  hidden: yes
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

explore: history_full {
  extends: [history]
  view_name: history
  from: history_full
  join: user {
    from: user_extended
  }
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
  join: scheduled_job {
    from: scheduled_job_extended
  }
}

explore: event_full {
  extends: [event]
  from: event_extended
  view_name: event
}

explore: look_full {
  extends: [look]
  from: look
  view_name: look
}

explore: dashboard_full {
  extends: [dashboard]
  from: dashboard
  view_name: dashboard
}

explore: dashboard_performance_full {
  extends: [dashboard_performance]
  from: dashboard_run_event_stats
  view_name: dashboard_performance
}

explore: content_usage {
  join: dashboard {
    relationship: one_to_one
    sql_on: ${content_usage.content_id} = ${dashboard.id} and ${content_usage.content_type} = "dashboard";;
  }
  join: look {
    relationship: one_to_one
    sql_on: ${content_usage.content_id} = ${look.id} and ${content_usage.content_type} = "look";;
  }
}

explore: user_weekly_activity {
  join: user {
    sql_on: ${user_weekly_activity.user_id} = ${user.id} ;;
    relationship: many_to_one
  }
  join: role_user {
    sql_on: role_user.user_id = user.id ;;
    relationship: one_to_many
    fields: []
  }

  join: embed_user {
    from: credentials_embed
    sql_on: user.id = embed_user.user_id ;;
    relationship: one_to_one
  }

  join: user_direct_role {
    relationship: one_to_many
    sql_on: ${user.id} = ${user_direct_role.user_id} ;;
    fields: []
  }

  join: group_user {
    relationship: one_to_many
    sql_on: ${user.id} = ${group_user.user_id} ;;
    fields: []
  }

  join: group {
    relationship: one_to_many
    sql_on: ${group.id} = ${group_user.group_id} ;;
  }

  join: role_group {
    relationship: one_to_many
    sql_on: ${role_group.group_id} = ${group_user.group_id} ;;
    fields: []
  }

  join: role {
    relationship: one_to_many
    sql_on: ${role.id} = ${user_direct_role.role_id} or ${role_group.role_id} = ${role.id} ;;
  }

  join: permission_set {
    foreign_key: role.permission_set_id
  }
}
