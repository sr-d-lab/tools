view: dimension_contract_user_info.view {
  sql_table_name: `product_id.product__mart__kpi_monitoring.dimension_contract_user_info` ;;

  dimension: ucompany_id {
    type: string
    label: "企業ID"
    sql: ${TABLE}.ucompany_id ;;
  }
  dimension: user_id {
    type: string
    label: "ユーザーID"
    sql: ${TABLE}.user_id ;;
  }
  dimension: user_name {
    type: string
    label: "ユーザー名"
    sql: ${TABLE}.user_name ;;
  }
  dimension: user_uuid {
    type: string
    description: "PK"
    sql: ${TABLE}.user_uuid ;;
  }
  dimension: email {
    type: string
    label: "email"
    sql: ${TABLE}.email ;;
  }
  measure: count {
    type: count
    drill_fields: [user_name]
  }
}