- dashboard: customer_adoption_and_health_reporting
  title: Customer Adoption And Health Reporting
  layout: newspaper
  elements:
  - name: Adoption Tracking
    type: text
    title_text: Adoption Tracking
    row: 0
    col: 0
    width: 24
    height: 2
  - name: Developer Trends
    type: text
    title_text: Developer Trends
    row: 24
    col: 0
    width: 24
    height: 3
  - name: Performance
    type: text
    title_text: Performance
    row: 35
    col: 0
    width: 24
    height: 3
  - title: User Activity
    name: User Activity
    model: looker_ext
    explore: history_full
    type: looker_line
    fields:
    - history.created_date
    - user.count
    - history.query_run_count
    fill_fields:
    - history.created_date
    filters:
      history.source: "-Other,-Scheduled Task,-Scheduled Task,-Suggest Filter,-Renderer"
    sorts:
    - history.created_date desc
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: right
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    colors:
    - 'palette: Mixed Neutrals'
    series_colors: {}
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: user.count
        name: User Count
        axisId: user.count
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 480
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 468
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: history.query_run_count
        name: History Query Run Count
        axisId: history.query_run_count
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 499
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 487
    trend_lines: []
    reference_lines:
    - reference_type: line
      line_value: mean
      range_start: max
      range_end: min
      margin_top: deviation
      margin_value: mean
      margin_bottom: deviation
      label_position: right
      color: "#07480b"
      label: 'Average User Count: {{mean}}'
      value_format: "#"
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 508
    series_labels:
      user.count: User Count
    listen:
      History Lookback: history.created_date
    row: 2
    col: 0
    width: 12
    height: 7
  - title: Scheduled Plan Activity
    name: Scheduled Plan Activity
    model: looker_ext
    explore: scheduled_plan_full
    type: looker_column
    fields:
    - scheduled_plan_destination.format
    - scheduled_job.count
    - scheduled_job.created_week
    pivots:
    - scheduled_plan_destination.format
    fill_fields:
    - scheduled_job.created_week
    filters:
      scheduled_plan_destination.format: "-NULL"
      scheduled_plan.run_once: 'no'
    sorts:
    - scheduled_plan_destination.format
    - scheduled_job.created_week desc
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    colors:
    - 'palette: Mixed Neutrals'
    series_colors: {}
    column_group_spacing_ratio:
    y_axes:
    - label: Schedule Run Count
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: html
        name: html
        axisId: scheduled_job.count
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 833
      - id: inline_table
        name: inline_table
        axisId: scheduled_job.count
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 838
      - id: json
        name: json
        axisId: scheduled_job.count
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 843
      - id: txt
        name: txt
        axisId: scheduled_job.count
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 848
      - id: wysiwyg_pdf
        name: wysiwyg_pdf
        axisId: scheduled_job.count
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 853
      - id: xlsx
        name: xlsx
        axisId: scheduled_job.count
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 858
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 821
    row: 9
    col: 12
    width: 12
    height: 8
  - title: Performance Last 2 Hours
    name: Performance Last 2 Hours
    model: looker_ext
    explore: history_full
    type: looker_line
    fields:
    - history.source
    - history.created_minute
    - history.average_runtime
    pivots:
    - history.source
    fill_fields:
    - history.created_minute
    filters:
      history.created_minute: 120 minutes
      history.source: Dashboard,Explore,Scheduled Task,Saved Look,Renderer
      query.model: ''
      query.view: ''
    sorts:
    - history.created_minute desc
    - history.source
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    hidden_series:
    - Renderer
    focus_on_hover: true
    colors:
    - "#1D98D3"
    - "#3B4260"
    - "#39A736"
    - "#F3BF0E"
    - "#E57200"
    - "#5DCCCC"
    - "#7e64e0"
    - "#F663D6"
    - "#603535"
    - "#A5C740"
    - "#B54B4B"
    - "#B1B0B0"
    series_colors: {}
    y_axes:
    - label: Avg. Runtime
      maxValue: 200
      minValue: 0
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: Dashboard
        name: Dashboard
        __FILE: i_looker_import/1_current_performance_quick_view.dashboard.lookml
        __LINE_NUM: 83
      - id: Explore
        name: Explore
        __FILE: i_looker_import/1_current_performance_quick_view.dashboard.lookml
        __LINE_NUM: 87
      - id: Renderer
        name: Renderer
        __FILE: i_looker_import/1_current_performance_quick_view.dashboard.lookml
        __LINE_NUM: 91
      - id: Saved Look
        name: Saved Look
        __FILE: i_looker_import/1_current_performance_quick_view.dashboard.lookml
        __LINE_NUM: 95
      - id: Scheduled Task
        name: Scheduled Task
        __FILE: i_looker_import/1_current_performance_quick_view.dashboard.lookml
        __LINE_NUM: 99
      __FILE: i_looker_import/1_current_performance_quick_view.dashboard.lookml
      __LINE_NUM: 71
    reference_lines:
    - reference_type: range
      line_value: mean
      range_start: '0'
      range_end: '30'
      margin_top: deviation
      margin_value: mean
      margin_bottom: deviation
      label_position: left
      color: "#4ac90e"
      label: A
      __FILE: i_looker_import/1_current_performance_quick_view.dashboard.lookml
      __LINE_NUM: 106
    - reference_type: range
      line_value: mean
      range_start: '30'
      range_end: '60'
      margin_top: deviation
      margin_value: mean
      margin_bottom: deviation
      label_position: left
      color: "#faec05"
      label: B
      __FILE: i_looker_import/1_current_performance_quick_view.dashboard.lookml
      __LINE_NUM: 118
    - reference_type: range
      line_value: mean
      range_start: '60'
      range_end: '90'
      margin_top: deviation
      margin_value: mean
      margin_bottom: deviation
      label_position: left
      color: "#ec2323"
      label: C
      __FILE: i_looker_import/1_current_performance_quick_view.dashboard.lookml
      __LINE_NUM: 130
    - reference_type: line
      line_value: median
      range_start: max
      range_end: min
      margin_top: deviation
      margin_value: mean
      margin_bottom: deviation
      label_position: right
      color: "#000000"
      label: 'Median: {{median}}'
      __FILE: i_looker_import/1_current_performance_quick_view.dashboard.lookml
      __LINE_NUM: 142
    row: 38
    col: 0
    width: 12
    height: 8
  - title: Dialect and Connection Usage
    name: Dialect and Connection Usage
    model: looker_ext
    explore: history_full
    type: looker_column
    fields:
    - user.count
    - history.query_run_count
    - history.connection_name
    - history.dialect
    - history.average_runtime
    filters:
      history.connection_name: "-NULL"
      history.result_source: query
      history.source: "-Other"
    sorts:
    - history.query_run_count desc
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: right
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_null_points: true
    point_style: circle
    interpolation: linear
    series_types: {}
    colors:
    - 'palette: Mixed Neutrals'
    series_colors: {}
    y_axes:
    - label: User Count
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: user.count
        name: User Count
        axisId: user.count
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 342
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 330
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat: "#"
      series:
      - id: history.average_runtime
        name: Average Runtime
        axisId: history.average_runtime
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 361
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 349
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: history.query_run_count
        name: Query Run Count
        axisId: history.query_run_count
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 380
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 368
    trend_lines: []
    reference_lines: []
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    series_labels:
      user.count: User Count
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 401
      bold: false
      italic: false
      strikethrough: false
      fields:
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 396
    listen:
      History Lookback: history.created_date
    row: 38
    col: 12
    width: 12
    height: 8
  - title: Group Activity
    name: Group Activity
    model: looker_ext
    explore: history_full
    type: looker_column
    fields:
    - group.name
    - history.query_run_count
    - user.count
    filters:
    sorts:
    - history.query_run_count desc
    limit: 500
    column_limit: 50
    query_timezone: America/New_York
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    colors:
    - 'palette: Mixed Neutrals'
    series_colors: {}
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat: ''
      series:
      - id: history.query_run_count
        name: History Query Run Count
        axisId: history.query_run_count
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: user.count
        name: User Count
        axisId: user.count
    x_axis_label_rotation: -60
    listen:
      History Lookback: history.created_date
    row: 17
    col: 12
    width: 12
    height: 7
  - title: Source Activity
    name: Source Activity
    model: looker_ext
    explore: history_full
    type: looker_column
    fields:
    - user.count
    - history.query_run_count
    - history.source
    filters:
      history.source: "-Other"
    sorts:
    - history.query_run_count desc
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: right
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_null_points: true
    point_style: circle
    interpolation: linear
    series_types: {}
    colors:
    - 'palette: Mixed Neutrals'
    series_colors: {}
    y_axes:
    - label: User Count
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: user.count
        name: User Count
        axisId: user.count
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 71
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 59
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: history.query_run_count
        name: Query Run Count
        axisId: history.query_run_count
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 90
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 78
    trend_lines: []
    reference_lines: []
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    series_labels:
      user.count: User Count
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 111
      bold: false
      italic: false
      strikethrough: false
      fields:
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 106
    listen:
      History Lookback: history.created_date
    row: 2
    col: 12
    width: 12
    height: 7
  - title: Top Developers By Commits
    name: Top Developers By Commits
    model: looker_ext
    explore: event_full
    type: table
    fields:
    - event.count
    - user.email
    - user.id
    filters:
      event.name: git_commit
    sorts:
    - event.count desc
    limit: 20
    query_timezone: America/Los_Angeles
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 560
      bold: false
      italic: false
      strikethrough: false
      fields:
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 555
    row: 27
    col: 0
    width: 6
    height: 8
  - title: PDT Build Count Last 7 Days
    name: PDT Build Count Last 7 Days
    model: looker_ext
    explore: pdt_log_full
    type: table
    fields:
    - pdt_log.count
    - pdt_log.view_name
    filters:
      pdt_log.action: create complete
      pdt_log.occur_date: 7 days
    sorts:
    - pdt_log.count desc
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 745
      bold: false
      italic: false
      strikethrough: false
      fields:
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 740
    series_labels:
      pdt_log.count: Build Complete Count
    row: 27
    col: 6
    width: 6
    height: 8
  - title: Model Explore Adoption
    name: Model Explore Adoption
    model: looker_ext
    explore: history_full
    type: table
    fields:
    - query.model
    - history.dialect
    - query.view
    - user.count
    - history.query_run_count
    filters:
      history.result_source: query
      history.source: "-Other,-Scheduled Task,-Scheduled Task,-Suggest Filter,-Renderer"
      history.status: complete
      query.model: "-NULL"
    sorts:
    - user.count desc 0
    - history.query_run_count desc
    limit: 20
    column_limit: 50
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: right
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    colors:
    - 'palette: Mixed Neutrals'
    series_colors: {}
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: user.count
        name: User Count
        axisId: user.count
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 200
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 188
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: history.query_run_count
        name: History Query Run Count
        axisId: history.query_run_count
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 219
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 207
    trend_lines: []
    reference_lines:
    - reference_type: line
      line_value: mean
      range_start: max
      range_end: min
      margin_top: deviation
      margin_value: mean
      margin_bottom: deviation
      label_position: right
      color: "#148f1b"
      label: 'Average User Count: {{mean}}'
      value_format: "#"
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 228
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    series_labels:
      user.count: User Count
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 253
      bold: false
      italic: false
      strikethrough: false
      fields:
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 248
    conditional_formatting_ignored_fields: []
    listen:
      History Lookback: history.created_date
    row: 9
    col: 0
    width: 12
    height: 8
  - title: Top 20 Users
    name: Top 20 Users
    model: looker_ext
    explore: history_full
    type: looker_column
    fields:
    - user.id
    - user.email
    - history.query_run_count
    - look.count
    - dashboard.count
    filters:
    sorts:
    - history.query_run_count desc
    limit: 20
    column_limit: 50
    query_timezone: America/New_York
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_label_rotation: -60
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: history.query_run_count
        name: History Query Run Count
        axisId: history.query_run_count
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: dashboard.count
        name: Dashboard Count
        axisId: dashboard.count
      - id: look.count
        name: Look Count
        axisId: look.count
    colors:
    - 'palette: Mixed Neutrals'
    series_colors: {}
    listen:
      History Lookback: history.created_date
    row: 17
    col: 0
    width: 12
    height: 7
  - title: Development Activity
    name: Development Activity
    model: looker_ext
    explore: event_full
    type: looker_line
    fields:
    - event.count
    - user.count
    - event.created_week
    fill_fields:
    - event.created_week
    filters:
      event.name: git_commit
    sorts:
    - event.created_week desc
    limit: 20
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 633
      bold: false
      italic: false
      strikethrough: false
      fields:
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 628
    series_types: {}
    colors:
    - 'palette: Mixed Neutrals'
    series_colors: {}
    y_axes:
    - label: Commit Count
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: event.count
        name: Event Count
        axisId: event.count
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 663
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 651
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat: "#"
      series:
      - id: user.count
        name: User Count
        axisId: user.count
        __FILE: i_looker_import/usage_overview.dashboard.lookml
        __LINE_NUM: 682
      __FILE: i_looker_import/usage_overview.dashboard.lookml
      __LINE_NUM: 670
    row: 27
    col: 12
    width: 12
    height: 8
  filters:
  - name: History Lookback
    title: History Lookback
    type: date_filter
    default_value: 30 days
    model:
    explore:
    field:
    listens_to_filters: []
    allow_multiple_values: true
    required: false
