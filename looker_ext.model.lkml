connection: "looker"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "/base_looker/*.view"
include: "/base_looker/*.model"

explore: history_full {
  extends: [history]
  view_name: history
  from: history_full
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
  from: event
  view_name: event
}
