- dashboard: dummy_03_user_summary
  title: "[dummy] 03_ユーザーサマリ / User Summary / KPI ユーザー利用状況相当"
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: 月次_利用状況
    name: 月次_利用状況
    model: dummy_kpi
    explore: fact_contract_user_summary
    type: looker_grid
    fields:
      - fact_contract_user_summary.customer_name
      - dimension_contract_user_info.user_name
      - dimension_contract_user_info.user_id
      - fact_contract_user_summary.department_id
      - fact_contract_user_summary.depertment
      - fact_contract_user_summary.monthly_overall_usage_rate
      - fact_contract_user_summary.monthly_business_card_capture_rate
      - fact_contract_user_summary.monthly_ecard_usage_rate
      - fact_contract_user_summary.monthly_inbox_usage_rate
      - fact_contract_user_summary.monthly_sign_in_rate
      - fact_contract_user_summary.measure_ecard_display_count
    sorts:
      - fact_contract_user_summary.usage_start_date desc
    limit: 500
    show_row_numbers: true
    show_totals: true
    hidden_fields:
      - fact_contract_user_summary.monthly_overall_usage_count
      - fact_contract_user_summary.monthly_business_card_capture_count
    listen:
      企業ID - 顧客名: fact_contract_user_summary.filter_Key
      集計日: fact_contract_user_summary.summary_date

  filters:
  - name: 集計日
    title: 集計日
    type: field_filter
    default_value: yesterday
    allow_multiple_values: true
    required: false
    model: dummy_kpi
    explore: fact_contract_user_summary
    field: fact_contract_user_summary.summary_date

  - name: 企業ID - 顧客名
    title: 企業ID - 顧客名
    type: field_filter
    default_value: dummy1-dummy株式会社
    allow_multiple_values: true
    required: false
    model: dummy_kpi
    explore: fact_contract_user_summary
    field: fact_contract_user_summary.filter_Key
