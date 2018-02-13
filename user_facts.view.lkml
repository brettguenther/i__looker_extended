view: user_facts {
  derived_table: {
    sql: SELECT
        COALESCE(credentials_email.CREATED_AT,credentials_ldap.CREATED_AT,credentials_google.CREATED_AT,credentials_saml.created_at)  AS first_login,
        user.ID  AS user_id
        FROM user  AS user
        LEFT JOIN credentials_email ON user.ID = credentials_email.USER_ID
        LEFT JOIN credentials_google ON user.ID = credentials_google.USER_ID
        LEFT JOIN credentials_ldap ON user.ID = credentials_ldap.USER_ID
        LEFT JOIN credentials_saml  AS credentials_saml ON user.ID = credentials_saml.user_id
  }
  dimension_group: first_login {
    type: time
    sql: ${TABLE}.first_login ;;
  }
  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  set: detail {
    fields: [user_id]
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }
}
