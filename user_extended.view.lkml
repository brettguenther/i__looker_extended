include: "/base_looker1/user.view"
include: "/base_looker1/credentials_*.view"
view: user_extended {
  extends: [user]
  sql_table_name: user ;;
  dimension: first_login {
    #this coalesce should me modified to only coalesce on authentication methods in use
    sql: COALESCE(${credentials_email.created_raw},${credentials_ldap.created_raw},${credentials_google.created_raw},${credentials_saml.created_raw}) ;;
  }
 }