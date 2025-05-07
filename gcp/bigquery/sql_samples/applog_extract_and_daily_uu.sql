-- ================================================================================
-- Application Log Extract and Daily UU Count
--
-- このクエリは、BigQueryに格納されたアプリケーション生ログ（applog）テーブルから、
-- 特定のリクエストパターン（httpMethod、controller、action など）を持つログを抽出し、
-- JSON形式のログデータ内からユーザー情報（ucompanyId, userId）を取得して
-- 日別のユニークユーザー数（UU）を集計するものです。
--
-- 主な用途:
-- - 生ログから特定イベント（例: 添付ファイルダウンロード）の利用状況を把握
-- - ログ内のJSONデータからucompanyId、userId等の属性を抽出して集計
-- - 日別でのアクティブユーザー数や利用傾向の可視化
--
-- 注意:
-- - 対象期間（WHERE句のdt条件）やログフィルタ（LIKE句）は必要に応じて適宜変更してください。
-- - JSONのキーはアプリケーションの仕様に依存するため、対象とするイベントに応じてカスタマイズ可能です。
--
-- 使用方法:
-- - 期間やイベント（httpMethod, controller, action など）条件を調整して特定アクションの利用状況を分析
-- - ユーザーIDベースでUUを集計することで日別の利用者傾向を把握可能
-- ================================================================================

with base as(
   select
     dt
    ,json_extract_scalar(log, '$.ucompanyId') as ucompany_id
    ,json_extract_scalar(log, '$.userId') as user_id
  from
    project_id.dataset_name.applog
  where
    dt between "2024-02-01" and "2024-04-30" -- 期間を絞る
  and log like '%httpMethod:GET %'
  and log like '%controller:Hoge %'
  and (
      log like '%action:downloadattahoge%'
    -- 添付ファイルダウンロード
  or  log like '%action:DownloadHoge%'
    -- 下書きの添付ファイルダウンロード
    )
)
select
   dt
  ,count(distinct user_id) as uu
from
  base
group by
  dt
order by
  dt