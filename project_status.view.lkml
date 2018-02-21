view: project_status {
  derived_table: {
    sql: SELECT project.value as project, max(CAST(joins.value AS SIGNED)) as number_of_joins,max(CAST(explores.value AS SIGNED)) as number_of_explores FROM sandboxcl.event
          LEFT JOIN sandboxcl.event_attribute as joins on event.id = joins.event_id and joins.name = 'joins'
          LEFT JOIN sandboxcl.event_attribute as project on event.id = project.event_id and project.name = 'project'
          LEFT JOIN sandboxcl.event_attribute as explores on event.id = explores.event_id and explores.name = 'explores'
          where event.name = 'git_pull_production'
      ;;
  }
  dimension: project {
    type: string
    sql: ${TABLE}.project ;;
  }

  dimension: number_of_joins {
    type: number
    sql: ${TABLE}.number_of_joins ;;
  }

  dimension: number_of_explores {
    type: number
    sql: ${TABLE}.number_of_explores ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }
  set: detail {
    fields: [project, number_of_joins, number_of_explores]
  }
}
