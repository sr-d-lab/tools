connection: "dwh_connector"

include: "/product_kpi/views/product__mart__kpi_monitoring/*.view.lkml"
include: "/product_kpi/dashboards/*.dashboard.lookml"

explore: fact_contract_user_summary {
  join: dimension_contract_user_info {
    type: left_outer
    relationship: many_to_one
    sql_on: ${fact_contract_user_summary.user_uuid}=${dimension_contract_user_info.user_uuid} ;;
  }
}
