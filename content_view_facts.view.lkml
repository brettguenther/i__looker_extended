view: content_view_facts {
  derived_table: {
    sql:
      SELECT
      COALESCE(history.dashboard_id,CAST(dashboard.id AS CHAR(256)),CAST(look.id AS CHAR(256)))  AS `content_id`,
      CASE WHEN look.id IS NOT NULL THEN 'look' ELSE 'dashboard' END AS `content_type`,
      COUNT(DISTINCT user.ID ) AS `users_viewed`
      FROM history  AS history
      LEFT JOIN look ON history.LOOK_ID  = look.ID
      LEFT JOIN user ON history.USER_ID  = user.ID
      LEFT JOIN dashboard ON history.dashboard_id = (CAST(dashboard.id AS CHAR(256)))
      where COALESCE(history.dashboard_id,CAST(dashboard.id AS CHAR(256)),CAST(look.id AS CHAR(256)))  IS NOT NULL
      GROUP BY 1,2
        ;;
  }


}
