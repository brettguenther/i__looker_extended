include: "/base_looker1/event.view"
include: "/base_looker1/event_attribute.view"
view: event_extended {
  extends: [event]
 sql_table_name: event ;;
 filter: event_type {
   suggest_explore: event
   suggest_dimension: name
 }
measure: count_events_filtered {
  type: sum
  sql: CASE WHEN {% condition event_type %} ${name} {% endcondition %} THEN 1 ELSE 0 END;;
}
measure: min_time {
  type: min
  sql: ${created_raw} ;;
}

}
