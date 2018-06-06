- dashboard: 3__dashboard_popularity
  title: 3 - Dashboard Popularity
  layout: newspaper
  elements:
  - title: Dashboard Runtime - Top 10 by Views
    name: Dashboard Runtime - Top 10 by Views
    model: looker_ext
    explore: history_full
    type: looker_pie
    fields:
    - history.query_run_count
    - history.average_runtime
    - history.real_dash_id
    filters:
      history.source: Dashboard,Renderer
    sorts:
    - history.query_run_count desc
    limit: 10
    column_limit: 50
    query_timezone: America/Los_Angeles
    value_labels: legend
    label_type: labPer
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    - history.query_run_count
    series_types: {}
    y_axes:
    - label:
      maxValue:
      minValue:
      orientation: top
      showLabels: true
      showValues: true
      tickDensity: custom
      tickDensityCustom: '4'
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: history.query_run_count
        name: Total Query Run Count
        __FILE: i_looker_import/3_dashboard_popularity.dashboard.lookml
        __LINE_NUM: 71
      __FILE: i_looker_import/3_dashboard_popularity.dashboard.lookml
      __LINE_NUM: 59
    - label: ''
      maxValue:
      minValue:
      orientation: bottom
      showLabels: true
      showValues: true
      tickDensity: custom
      tickDensityCustom: 3
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: history.average_runtime
        name: Average Runtime
        __FILE: i_looker_import/3_dashboard_popularity.dashboard.lookml
        __LINE_NUM: 89
      __FILE: i_looker_import/3_dashboard_popularity.dashboard.lookml
      __LINE_NUM: 77
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
    listen:
      History Date: history.created_date
    row: 0
    col: 0
    width: 12
    height: 8
  - title: Dashboard View Count - Top 10
    name: Dashboard View Count - Top 10
    model: looker_ext
    explore: history_full
    type: looker_bar
    fields:
    - history.cache_ratio
    - history.query_run_count
    - history.real_dash_id
    filters:
      history.real_dash_id: "-NULL"
    sorts:
    - history.query_run_count desc
    limit: 50
    column_limit: 50
    dynamic_fields:
    - table_calculation: row_number
      label: row number
      expression: row()
      value_format:
      value_format_name:
      _kind_hint: dimension
    - table_calculation: calculation_2
      label: Calculation 2
      expression: if(${row_number} > 0 AND ${row_number} <= 10,yes,no)
      value_format:
      value_format_name:
      _kind_hint: dimension
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: true
    label_density: 22
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    value_labels: legend
    label_type: labPer
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    - row_number
    series_types:
      history.cache_ratio: line
    y_axes:
    - label:
      maxValue:
      minValue:
      orientation: top
      showLabels: false
      showValues: false
      tickDensity: custom
      tickDensityCustom: 4
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: history.query_run_count
        name: Query Run Count
        __FILE: i_looker_import/3_dashboard_popularity.dashboard.lookml
        __LINE_NUM: 195
        axisId: history.query_run_count
      __FILE: i_looker_import/3_dashboard_popularity.dashboard.lookml
      __LINE_NUM: 183
    - label:
      maxValue:
      minValue:
      orientation: top
      showLabels: false
      showValues: false
      tickDensity: custom
      tickDensityCustom: 4
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: history.cache_ratio
        name: Cache Ratio
        axisId: history.cache_ratio
        __FILE: i_looker_import/3_dashboard_popularity.dashboard.lookml
        __LINE_NUM: 214
      __FILE: i_looker_import/3_dashboard_popularity.dashboard.lookml
      __LINE_NUM: 202
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '10'
    hidden_points_if_no:
    - calculation_2
    hide_legend: false
    y_axis_reversed: false
    column_spacing_ratio:
    colors:
    - "#3B4260"
    - "#1D98D3"
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
    listen:
      History Date: history.created_date
    row: 0
    col: 12
    width: 12
    height: 8
  filters:
  - name: History Date
    title: History Date
    type: field_filter
    default_value: 30 days
    model: looker_ext
    explore: history_full
    field: history.created_date
    listens_to_filters: []
    allow_multiple_values: true
    required: false
