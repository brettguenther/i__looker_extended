include: "/base_looker1/look.view"

view: look_extended {
  sql_table_name: look ;;
  extends: [look]
  measure: count_deleted {
    type: count
    filters: {
      field: deleted_time
      value: "-NULL"
    }
}
}
