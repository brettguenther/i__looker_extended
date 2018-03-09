include: "/i__looker_base/credentials_email.view"
view: credentails {
  sql_table_name: credentials_email ;;
  extends: [credentials_email]
  dimension_group: first_login {
    type: time
    datatype: datetime
    sql: COALESCE(${credentials_ldap.created_raw},${credentials_email.created_raw}) ;;
  }
}
