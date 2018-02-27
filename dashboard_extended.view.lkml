include: "/base_looker1/dashboard.view"
view: dashboard_extended {
  sql_table_name: dashboard ;;
  extends: [dashboard]
  measure: count_deleted {
    type: count
    filters: {
      field: deleted_time
      value: "-NULL"
    }
  }
 }
