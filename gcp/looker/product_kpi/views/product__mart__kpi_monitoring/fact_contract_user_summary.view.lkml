view: kpi_fact_contract_user_summary {
  sql_table_name: `product_id.product__mart__kpi_monitoring.fact_contract_user_summary` ;;
  drill_fields: [id]
  # Dashboard Link
  dimension: dashboard_link_tab {
    label: "KPI ダッシュボードリンク"
    type: string
    sql: 1 ;;
    html:
    {% assign button_style = '
      button {
        display: inline;
        width: 160px;
        height: 32px;
        padding: 8px 0px;
        border: none;
        border-bottom: 2px solid #0d60e0;
        background-color: transparent;
        color: #333;
        font-weight: 600;
        font-size: 12px;
      }'
      %}
    {% if kpi_fact_contract_user_summary.summary_date._is_filtered %}
    {% assign date_filter = _filters["kpi_fact_contract_user_summary.summary_date"] | url_encode %}
    {% else %}
      {% assign date_filter = 'yeasterday' | url_encode %}
    {% endif %}
    {% if kpi_fact_contract_user_summary.filter_Key._is_filtered %}
      {% assign filter_key = _filters["kpi_fact_contract_user_summary.filter_Key"] | url_encode %}
    {% else %}
      {% assign filter_key = 'dummy-company' | url_encode %}
    {% endif %}
    {% assign 01_url = "/dashboards/project_namespace::dummy_dashboard_01?" | append: '集計日=' | append: date_filter %}
    {% assign 02_url = "/dashboards/project_namespace::dummy_dashboard_02?" | append: '集計日=' | append: date_filter | append: '&企業ID+-+顧客名=' | append: filter_key %}
    {% assign 03_url = "/dashboards/project_namespace::dummy_dashboard_03?" | append: '集計日=' | append: date_filter | append: '&企業ID+-+顧客名=' | append: filter_key %}
    {% assign 04_url = "/dashboards/project_namespace::dummy_dashboard_04?" | append: '集計日=' | append: date_filter | append: '&企業ID+-+顧客名=' | append: filter_key %}
    {% assign 06_url = "/dashboards/project_namespace::dummy_dashboard_06?" | append: 'Summary+Date=' | append: date_filter | append: '&企業ID+-+顧客名=' | append: filter_key %}
    <style>{{ button_style }}</style>
    <a target="_blank" href={{ 01_url }}><button style={{button_style}}>01_プロダクトサマリ</button></a>
    <a target="_blank" href={{ 02_url }}><button style={{button_style}}>02_契約別サマリ</button></a>
    <a target="_blank" href={{ 03_url }}><button style={{button_style}}>03_ユーザーサマリ</button></a>
    <a target="_blank" href={{ 04_url }}><button style={{button_style}}>04_契約一覧</button></a>
    <a target="_blank" href={{ 06_url }}><button style={{button_style}}>06_スキャナ状況一覧</button></a>
    ;;
  }
  dimension: id {
    primary_key: yes
    type: number
    description: "PK"
    sql: ${TABLE}.id ;;
  }
  dimension: admin_role {
    type: yesno
    sql: ${TABLE}.admin_role ;;
  }
  dimension: billing_id {
    type: number
    sql: ${TABLE}.billing_id ;;
  }
  dimension: business_card_count {
    type: number
    sql: ${TABLE}.business_card_count ;;
  }
  dimension: contract_id {
    type: number
    sql: ${TABLE}.contract_id ;;
  }
  dimension: culture {
    type: string
    sql: ${TABLE}.culture ;;
  }
  dimension: customer_name {
    type: string
    label: "顧客名(契約名)"
    sql: ${TABLE}.customer_name ;;
    link: {
      label: "02_契約別サマリへ移動"
      icon_url: "https://dummy.looker.app/favicon.ico"
      url: "
      {% unless _explore._dashboard_url == '/dashboards/sansan_kpi::dummy_02_contract_summary' %}
      /dashboards/sansan_kpi::dummy_02_contract_summary?{{ '集計日' | url_encode }}={{ summary_date._value | url_encode }}&{{ '企業ID - 顧客名' | url_encode }}={{ filter_Key._value | url_encode }}
      {% endunless %}
      "
    }
    link: {
      label: "03_ユーザーサマリへ移動"
      icon_url: "https://dummy.looker.app/favicon.ico"
      url: "
      {% unless _explore._dashboard_url == '/dashboards/sansan_kpi::dummy_03_user_summary' %}
      /dashboards/sansan_kpi::dummy_03_user_summary?{{ '集計日' | url_encode }}={{ summary_date._value | url_encode }}&{{ '企業ID - 顧客名' | url_encode }}={{ filter_Key._value | url_encode }}
      {% endunless %}
      "
    }
    link: {
      label: "04_契約一覧へ移動"
      icon_url: "https://dummy.looker.app/favicon.ico"
      url: "
      {% unless _explore._dashboard_url == '/dashboards/sansan_kpi::dummy_04_contract_list' %}
      /dashboards/sansan_kpi::dummy_04_contract_list?{{ '集計日' | url_encode }}={{ summary_date._value | url_encode }}&{{ '企業ID - 顧客名' | url_encode }}={{ filter_Key._value | url_encode }}
      {% endunless %}
      "
    }
    link: {
      label: "06_Sansanスキャナ状況一覧へ移動"
      icon_url: "https://dummy.looker.app/favicon.ico"
      url: "
      {% unless _explore._dashboard_url == '/dashboards/sansan_kpi::dummy_06_sansan_scannerdownload' %}
      /dashboards/sansan_kpi::dummy_06_sansan_scannerdownload?{{ 'Summary Date' | url_encode }}={{ summary_date._value | url_encode }}&{{ '企業ID - 顧客名' | url_encode }}={{ filter_Key._value | url_encode }}
      {% endunless %}
      "
    }
  }

  dimension: daily_api_usage_count {
    type: number
    sql: ${TABLE}.daily_api_usage_count ;;
  }
  dimension: daily_business_card_capture_count {
    type: number
    sql: ${TABLE}.daily_business_card_capture_count ;;
  }
  dimension: daily_company_db_usage_count {
    type: number
    sql: ${TABLE}.daily_company_db_usage_count ;;
  }
  dimension: daily_company_usage_count {
    type: number
    sql: ${TABLE}.daily_company_usage_count ;;
  }
  dimension: daily_contact_usage_count {
    type: number
    sql: ${TABLE}.daily_contact_usage_count ;;
  }
  dimension: daily_denominator {
    type: number
    sql: ${TABLE}.daily_denominator ;;
  }
  dimension: daily_ecard_usage_count {
    type: number
    sql: ${TABLE}.daily_ecard_usage_count ;;
  }
  dimension: daily_email_usage_count {
    type: number
    sql: ${TABLE}.daily_email_usage_count ;;
  }
  dimension: daily_feed_usage_count {
    type: number
    sql: ${TABLE}.daily_feed_usage_count ;;
  }
  dimension: daily_inbox_usage_count {
    type: number
    sql: ${TABLE}.daily_inbox_usage_count ;;
  }
  dimension: daily_message_usage_count {
    type: number
    sql: ${TABLE}.daily_message_usage_count ;;
  }
  dimension: daily_mobile_app_usage_count {
    type: number
    sql: ${TABLE}.daily_mobile_app_usage_count ;;
  }
  dimension: daily_mobile_web_usage_count {
    type: number
    sql: ${TABLE}.daily_mobile_web_usage_count ;;
  }
  dimension: daily_opportunity_usage_count {
    type: number
    sql: ${TABLE}.daily_opportunity_usage_count ;;
  }
  dimension: daily_overall_usage_count {
    type: number
    sql: ${TABLE}.daily_overall_usage_count ;;
  }
  dimension: daily_pc_and_mobile_web_usage_count {
    type: number
    sql: ${TABLE}.daily_pc_and_mobile_web_usage_count ;;
  }
  dimension: daily_search_usage_count {
    type: number
    sql: ${TABLE}.daily_search_usage_count ;;
  }
  dimension: daily_sign_in_count {
    type: number
    sql: ${TABLE}.daily_sign_in_count ;;
  }
  dimension: daily_spm_usage_count {
    type: number
    sql: ${TABLE}.daily_spm_usage_count ;;
  }
  dimension: department_id {
    type: string
    sql: ${TABLE}.department_id ;;
  }
  dimension: depertment {
    type: string
    sql: ${TABLE}.depertment ;;
  }
  dimension: display_order {
    type: number
    sql: ${TABLE}.display_order ;;
  }
  dimension_group: dt {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.dt ;;
  }
  dimension: ecard_display_count {
    label: "デジタル名刺表示回数(過去30日分)"
    type: number
    sql: ${TABLE}.ecard_display_count ;;
  }
  dimension: ecard_setting {
    type: yesno
    sql: ${TABLE}.ecard_setting ;;
  }
  dimension: ecard_url_status {
    type: number
    sql: ${TABLE}.ecard_url_status ;;
  }
  dimension: email_signature_imported_bizcard_count {
    type: number
    sql: ${TABLE}.email_signature_imported_bizcard_count ;;
  }
  dimension: first_udepartment_name {
    type: string
    sql: ${TABLE}.first_udepartment_name ;;
  }
  dimension: imported_and_digitization_required_business_card_count {
    type: number
    sql: ${TABLE}.imported_and_digitization_required_business_card_count ;;
  }
  dimension: inbox_displayable_suggested_bizcard_count {
    type: number
    sql: ${TABLE}.inbox_displayable_suggested_bizcard_count ;;
  }
  dimension: inbox_imported_bizcard_count {
    type: number
    sql: ${TABLE}.inbox_imported_bizcard_count ;;
  }
  dimension: inbox_setting {
    type: yesno
    sql: ${TABLE}.inbox_setting ;;
  }
  dimension: inbox_suggested_bizcard_count {
    type: number
    sql: ${TABLE}.inbox_suggested_bizcard_count ;;
  }
  dimension_group: last_business_card_scanned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: date
    convert_tz: no
    sql: ${TABLE}.last_business_card_scanned_date_jst ;;
  }
  dimension_group: last_login {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: date
    convert_tz: no
    sql: ${TABLE}.last_login_date_jst ;;
  }
  dimension_group: last_virtual_background_download {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_virtual_background_download_date_jst ;;
  }
  dimension: monthly_api_usage_count {
    type: number
    sql: ${TABLE}.monthly_api_usage_count ;;
  }
  dimension: monthly_business_card_capture_count {
    type: number
    sql: ${TABLE}.monthly_business_card_capture_count ;;
  }
  dimension: monthly_company_db_usage_count {
    type: number
    sql: ${TABLE}.monthly_company_db_usage_count ;;
  }
  dimension: monthly_company_usage_count {
    type: number
    sql: ${TABLE}.monthly_company_usage_count ;;
  }
  dimension: monthly_contact_usage_count {
    type: number
    sql: ${TABLE}.monthly_contact_usage_count ;;
  }
  dimension: monthly_denominator {
    type: number
    sql: ${TABLE}.monthly_denominator ;;
  }
  dimension: monthly_ecard_usage_count {
    type: number
    sql: ${TABLE}.monthly_ecard_usage_count ;;
  }
  dimension: monthly_email_usage_count {
    type: number
    sql: ${TABLE}.monthly_email_usage_count ;;
  }
  dimension: monthly_feed_usage_count {
    type: number
    sql: ${TABLE}.monthly_feed_usage_count ;;
  }
  dimension: monthly_inbox_usage_count {
    type: number
    sql: ${TABLE}.monthly_inbox_usage_count ;;
  }
  dimension: monthly_message_usage_count {
    type: number
    sql: ${TABLE}.monthly_message_usage_count ;;
  }
  dimension: monthly_mobile_app_usage_count {
    type: number
    sql: ${TABLE}.monthly_mobile_app_usage_count ;;
  }
  dimension: monthly_mobile_web_usage_count {
    type: number
    sql: ${TABLE}.monthly_mobile_web_usage_count ;;
  }
  dimension: monthly_online_imported_business_card_count {
    label: "デジタル名刺取込枚数(過去30日分) "
    type: number
    sql: ${TABLE}.monthly_online_imported_business_card_count ;;
  }
  dimension: monthly_opportunity_usage_count {
    type: number
    sql: ${TABLE}.monthly_opportunity_usage_count ;;
  }
  dimension: monthly_overall_usage_count {
    type: number
    sql: ${TABLE}.monthly_overall_usage_count ;;
  }
  dimension: monthly_pc_and_mobile_web_usage_count {
    type: number
    sql: ${TABLE}.monthly_pc_and_mobile_web_usage_count ;;
  }
  dimension: monthly_search_usage_count {
    type: number
    sql: ${TABLE}.monthly_search_usage_count ;;
  }
  dimension: monthly_sign_in_count {
    type: number
    sql: ${TABLE}.monthly_sign_in_count ;;
  }
  dimension: monthly_spm_usage_count {
    type: number
    sql: ${TABLE}.monthly_spm_usage_count ;;
  }
  dimension: online_imported_business_card_count {
    label: "デジタル名刺取込枚数"
    type: number
    sql: ${TABLE}.online_imported_business_card_count ;;
  }
  dimension: opted_out_guidance_mail {
    type: yesno
    label: "案内メール拒否"
    sql: ${TABLE}.opted_out_guidance_mail ;;
  }
  dimension: opted_out_service_assistance_mail {
    type: yesno
    label: "利用アシストメール拒否"
    sql: ${TABLE}.opted_out_service_assistance_mail ;;
  }
  dimension: second_udepartment_name {
    type: string
    sql: ${TABLE}.second_udepartment_name ;;
  }
  dimension: spm_setting {
    type: yesno
    sql: ${TABLE}.spm_setting ;;
  }
  dimension_group: summary {
    type: time
    datatype: date
    timeframes: [raw, time, date, week, month, quarter, year]
    convert_tz: no
    sql: ${TABLE}.summary_date_jst ;;
  }
  dimension: teams_linkage {
    type: yesno
    sql: ${TABLE}.teams_linkage ;;
  }
  dimension: third_udepartment_name {
    type: string
    sql: ${TABLE}.third_udepartment_name ;;
  }
  dimension: ucompany_id {
    type: string
    sql: ${TABLE}.ucompany_id ;;
  }
  dimension: uid {
    label: "UID"
    type: string
    sql: ${TABLE}.uid ;;
    }
  dimension_group: usage_start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: date
    convert_tz: no
    sql: ${TABLE}.usage_start_date_jst ;;
  }
  dimension: user_uuid {
    type: string
    sql: ${TABLE}.user_uuid ;;
  }
  dimension: weekly_api_usage_count {
    type: number
    sql: ${TABLE}.weekly_api_usage_count ;;
  }
  dimension: weekly_business_card_capture_count {
    type: number
    sql: ${TABLE}.weekly_business_card_capture_count ;;
  }
  dimension: weekly_company_db_usage_count {
    type: number
    sql: ${TABLE}.weekly_company_db_usage_count ;;
  }
  dimension: weekly_company_usage_count {
    type: number
    sql: ${TABLE}.weekly_company_usage_count ;;
  }
  dimension: weekly_contact_usage_count {
    type: number
    sql: ${TABLE}.weekly_contact_usage_count ;;
  }
  dimension: weekly_denominator {
    type: number
    sql: ${TABLE}.weekly_denominator ;;
  }
  dimension: weekly_ecard_usage_count {
    type: number
    sql: ${TABLE}.weekly_ecard_usage_count ;;
  }
  dimension: weekly_email_usage_count {
    type: number
    sql: ${TABLE}.weekly_email_usage_count ;;
  }
  dimension: weekly_feed_usage_count {
    type: number
    sql: ${TABLE}.weekly_feed_usage_count ;;
  }
  dimension: weekly_inbox_usage_count {
    type: number
    sql: ${TABLE}.weekly_inbox_usage_count ;;
  }
  dimension: weekly_message_usage_count {
    type: number
    sql: ${TABLE}.weekly_message_usage_count ;;
  }
  dimension: weekly_mobile_app_usage_count {
    type: number
    sql: ${TABLE}.weekly_mobile_app_usage_count ;;
  }
  dimension: weekly_mobile_web_usage_count {
    type: number
    sql: ${TABLE}.weekly_mobile_web_usage_count ;;
  }
  dimension: weekly_opportunity_usage_count {
    type: number
    sql: ${TABLE}.weekly_opportunity_usage_count ;;
  }
  dimension: weekly_overall_usage_count {
    type: number
    sql: ${TABLE}.weekly_overall_usage_count ;;
  }
  dimension: weekly_pc_and_mobile_web_usage_count {
    type: number
    sql: ${TABLE}.weekly_pc_and_mobile_web_usage_count ;;
  }
  dimension: weekly_search_usage_count {
    type: number
    sql: ${TABLE}.weekly_search_usage_count ;;
  }
  dimension: weekly_sign_in_count {
    type: number
    sql: ${TABLE}.weekly_sign_in_count ;;
  }
  dimension: weekly_spm_usage_count {
    type: number
    sql: ${TABLE}.weekly_spm_usage_count ;;
  }
  # フィルター用Key
  dimension: filter_Key {
    type: string
    sql: concat(${ucompany_id},${billing_id},"-",${customer_name}) ;;
  }

  measure: count {
    type: count
    drill_fields: [id, second_udepartment_name, first_udepartment_name, third_udepartment_name, customer_name]
  }
  # デジタル名刺
  measure: measure_ecard_display_count {
    label: "デジタル名刺表示回数(過去30日分)"
    type: sum
    sql: ${ecard_display_count} ;;
  }
  measure: measure_monthly_online_imported_business_card_count {
    label: "デジタル名刺取込枚数(過去30日分) "
    type: sum
    sql: ${monthly_online_imported_business_card_count} ;;
  }
  # 全体 (日次)
  measure: daily_overall_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${daily_overall_usage_count}/nullif(${daily_denominator}, 0)  ;;
  }
  # 全体 (週次)
  measure: weekly_overall_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${weekly_overall_usage_count}/nullif(${weekly_denominator}, 0)  ;;
  }
  # 全体 (月次)
  measure: monthly_overall_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${monthly_overall_usage_count}/nullif(${monthly_denominator}, 0)  ;;
  }
  # 名刺取込 (日次)
  measure: daily_business_card_capture_rate{
    type:number
    value_format_name: percent_2
    sql:${daily_business_card_capture_count}/nullif(${daily_denominator}, 0)  ;;
  }
  # 名刺取込 (週次)
  measure: weekly_business_card_capture_rate{
    type:number
    value_format_name: percent_2
    sql:${weekly_business_card_capture_count}/nullif(${weekly_denominator}, 0)  ;;
  }
  # 名刺取込 (月次)
  measure: monthly_business_card_capture_rate{
    type:number
    value_format_name: percent_2
    sql:${monthly_business_card_capture_count}/nullif(${monthly_denominator}, 0)  ;;
  }
  # デジタル名刺 (日次)
  measure: daily_ecard_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${daily_ecard_usage_count}/nullif(${daily_denominator}, 0)  ;;
  }
  # デジタル名刺 (週次)
  measure: weekly_ecard_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${weekly_ecard_usage_count}/nullif(${weekly_denominator}, 0)  ;;
  }
  # デジタル名刺 (月次)
  measure: monthly_ecard_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${monthly_ecard_usage_count}/nullif(${monthly_denominator}, 0)  ;;
  }
  # メール署名取込 (日次)
  measure: daily_inbox_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${daily_inbox_usage_count}/nullif(${daily_denominator}, 0)  ;;
  }
  # メール署名取込 (週次)
  measure: weekly_inbox_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${weekly_inbox_usage_count}/nullif(${weekly_denominator}, 0)  ;;
  }
  # メール署名取込 (月次)
  measure: monthly_inbox_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${monthly_inbox_usage_count}/nullif(${monthly_denominator}, 0)  ;;
  }
  # 名刺共有 (日次)
  measure: daily_search_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${daily_search_usage_count}/nullif(${daily_denominator}, 0)  ;;
  }
  # 名刺共有 (週次)
  measure: weekly_search_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${weekly_search_usage_count}/nullif(${weekly_denominator}, 0)  ;;
  }
  # 名刺共有 (月次)
  measure: monthly_search_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${monthly_search_usage_count}/nullif(${monthly_denominator}, 0)  ;;
  }
  # 同僚コラボ (日次)
  measure: daily_spm_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${daily_spm_usage_count}/nullif(${daily_denominator}, 0)  ;;
  }
  # 同僚コラボ (週次)
  measure: weekly_spm_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${weekly_spm_usage_count}/nullif(${weekly_denominator}, 0)  ;;
  }
  # 同僚コラボ (月次)
  measure: monthly_spm_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${monthly_spm_usage_count}/nullif(${monthly_denominator}, 0)  ;;
  }
  # 企業情報閲覧 (日次)
  measure: daily_company_db_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${daily_company_db_usage_count}/nullif(${daily_denominator}, 0)  ;;
  }
  # 企業情報閲覧 (週次)
  measure: weekly_company_db_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${weekly_company_db_usage_count}/nullif(${weekly_denominator}, 0)  ;;
  }
  # 企業情報閲覧 (月次)
  measure: monthly_company_db_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${monthly_company_db_usage_count}/nullif(${monthly_denominator}, 0)  ;;
  }
  # メッセージ (日次)
  measure: daily_message_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${daily_message_usage_count}/nullif(${daily_denominator}, 0)  ;;
  }
  # メッセージ (週次)
  measure: weekly_message_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${weekly_message_usage_count}/nullif(${weekly_denominator}, 0)  ;;
  }
  # メッセージ (月次)
  measure: monthly_message_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${monthly_message_usage_count}/nullif(${monthly_denominator}, 0)  ;;
  }
  # コンタクト (日次)
  measure: daily_contact_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${daily_contact_usage_count}/nullif(${daily_denominator}, 0)  ;;
  }
  # コンタクト (週次)
  measure: weekly_contact_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${weekly_contact_usage_count}/nullif(${weekly_denominator}, 0)  ;;
  }
  # コンタクト (月次)
  measure: monthly_contact_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${monthly_contact_usage_count}/nullif(${monthly_denominator}, 0)  ;;
  }
  # 案件 (日次)
  measure: daily_opportunity_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${daily_opportunity_usage_count}/nullif(${daily_denominator}, 0)  ;;
  }
  # 案件 (週次)
  measure: weekly_opportunity_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${weekly_opportunity_usage_count}/nullif(${weekly_denominator}, 0)  ;;
  }
  # 案件 (月次)
  measure: monthly_opportunity_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${monthly_opportunity_usage_count}/nullif(${monthly_denominator}, 0)  ;;
  }
  # メール一括配信 (日次)
  measure: daily_email_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${daily_email_usage_count}/nullif(${daily_denominator}, 0)  ;;
  }
  # メール一括配信 (週次)
  measure: weekly_email_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${weekly_email_usage_count}/nullif(${weekly_denominator}, 0)  ;;
  }
  # メール一括配 (月次)
  measure: monthly_email_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${monthly_email_usage_count}/nullif(${monthly_denominator}, 0)  ;;
  }
  # スマホアプリ (日次)
  measure: daily_mobile_app_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${daily_mobile_app_usage_count}/nullif(${daily_denominator}, 0)  ;;
  }
  # スマホアプリ (週次)
  measure: weekly_mobile_app_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${weekly_mobile_app_usage_count}/nullif(${weekly_denominator}, 0)  ;;
  }
  # スマホアプリ (月次)
  measure: monthly_mobile_app_usage_rate{
    type:number
    value_format_name: percent_2
    sql:${monthly_mobile_app_usage_count}/nullif(${monthly_denominator}, 0)  ;;
  }
  # API配信 (月次)
  measure: monthly_api_usage_rate{
    label: "API配信 (月次)"
    type:number
    value_format_name: percent_2
    sql:${monthly_api_usage_count}/nullif(${monthly_denominator}, 0)  ;;
  }
  # ホーム (日次)
  measure: daily_sign_in_rate{
    label: "ホーム (日次)"
    type:number
    value_format_name: percent_2
    sql:${daily_sign_in_count}/nullif(${daily_denominator}, 0)  ;;
  }
  # ホーム (週次)
  measure: weekly_sign_in_rate{
    label: "ホーム (週次)"
    type:number
    value_format_name: percent_2
    sql:${weekly_sign_in_count}/nullif(${weekly_denominator}, 0)  ;;
  }
  # ホーム (月次)
  measure: monthly_sign_in_rate{
    label: "ホーム (月次)"
    type:number
    value_format_name: percent_2
    sql:${monthly_sign_in_count}/nullif(${monthly_denominator}, 0)  ;;
  }
}