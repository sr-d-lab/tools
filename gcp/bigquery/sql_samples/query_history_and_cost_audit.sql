-- ================================================================================
-- BigQuery Query History and Cost Audit
--
-- このクエリは、指定したプロジェクト内で過去30日間に実行されたクエリジョブの履歴を取得し、
-- 実行者（user_email）、クエリ内容、処理データ量（bytes → TB）、および概算コスト（ドル換算）を確認するためのものです。
--
-- 主な用途:
-- - ユーザー別・クエリ別のBigQuery利用状況の把握
-- - クエリ処理量と概算コストの調査
-- - 特定ユーザーやクエリパターン（例: 'hoge' を含むクエリ）のフィルタリングによる調査
--
-- 注意:
-- - コスト換算は $6.0/TB の単価を基に概算しています（必要に応じて単価は調整してください）。
-- - INFORMATION_SCHEMA.JOBS_BY_PROJECT では過去180日間までの履歴が保持されますが、クエリでは直近30日分を対象としています。
--
-- 使用方法:
-- - user_email とクエリフィルタ（LIKE句）を適宜変更して利用者別・クエリパターン別に調査可能です。
-- ================================================================================

SELECT
  creation_time,
  user_email,
  query,
  total_bytes_processed AS total_bytes_processed,
 -- Byte to TB
  total_bytes_processed / 1024 / 1024 / 1024 /1024 AS total_TB_processed,
 -- TB to Dollar
  total_bytes_processed / 1024 / 1024 / 1024 /1024 * 6.0 AS Charges_Dollar,
FROM
  region-asia-northeast1.INFORMATION_SCHEMA.JOBS_BY_PROJECT
WHERE
  DATE(creation_time) BETWEEN DATE_ADD(CURRENT_DATE('Asia/Tokyo'), INTERVAL -30 DAY ) AND CURRENT_DATE('Asia/Tokyo')
  and user_email = 'user@hoge.com' -- 利用者を絞るとき指定
  and query like '%hoge%'. -- hogeを含むクエリ実行を探索
ORDER BY 1 DESC;