include: "/base_looker1/user.view"
include: "/base_looker1/credentials_*.view"
view: user_extended {
  extends: [user]
  sql_table_name: user ;;
  dimension_group: first_login {
    timeframes: [raw,date,week,month,quarter,year]
    type: time
    datatype: timestamp
    #this coalesce should me modified to only coalesce on authentication methods in use
    sql: COALESCE(${credentials_email.created_raw},${credentials_ldap.created_raw},${credentials_google.created_raw},${credentials_saml.created_raw}) ;;
  }
 }

view: user_facts {
  #need a full history to build this out to get first month of activity info which means I can get user type(admin,dev,explorer,consumer)
}
