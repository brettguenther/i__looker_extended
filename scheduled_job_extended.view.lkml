include: "/base_looker1/scheduled_job.view"
view: scheduled_job_extended {
  sql_table_name: scheduled_job ;;
  extends: [scheduled_job]
   measure: count_scheduled_jobs_failed {
     type: count
     filters: {
       field: status
        value: "failure"
     }
   }
  measure: count_scheduled_jobs_completed {
    type: count
    filters: {
      field: status
      value: "success"
    }
  }
  measure: percent_of_scheduled_jobs_completed {
    value_format_name: "percent_0"
    description: "Percent of scheduled jobs that successfully ran"
    sql: ${count_scheduled_jobs_completed}/${count} ;;
  }

}
