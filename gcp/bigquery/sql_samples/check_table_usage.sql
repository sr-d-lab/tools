-- 概要
-- テーブルの参照回数を取得するためのSQLサンプル
-- 参照状況の可視化などに利用する
-- query_historieshはBQテーブル化してある
with table_usage as (
select
  project_id
  , creation_time
  , user_email
  , array_to_string(array(
    select
      concat(t.dataset_id, '.', t.table_id)
    from
      unnest(referenced_tables) t ), ', ') as referenced_datasets_tables
from
  `project_id.hogehoge_infrastructure_log.bq_query_histories`
where
  statement_type = 'SELECT'
  and referenced_tables[safe_offset(0)].table_id is not null
  and project_id not in ('staging_datasets')
  and starts_with(referenced_tables[safe_offset(0)].table_id, 'information_schema') is false
  and user_email like "%@hogehoge.com" -- 一般ユーザのみ。サービスアカウントの場合は変えるなどする
  and date(creation_time) >= date_sub(current_date('Asia/Tokyo'), interval 2 week) -- スキャンサイズを抑えるため。不要ならコメントアウト
) 

select
  project_id
  , creation_time
  , user_email
  , referenced_datasets_tables
from
  table_usage
where
  referenced_datasets_tables='dataset_name.table_name' limit 30;