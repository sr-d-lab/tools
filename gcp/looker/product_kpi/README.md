# Product KPI ダッシュボード LookML

## 概要

このディレクトリ (`looker/product_kpi`) では、Product KPI に関連するLookerダッシュボードのLookML定義を管理しています。

主に以下のダッシュボードを構成するLookMLが含まれます。

- **ユーザーサマリダッシュボード (`dummy_03_user_summary`)**
  - ユーザーの利用状況（⽉次・週次・⽇次）を可視化
  - 利用率、利用件数、名刺取込状況などの指標を表示

## 構成ファイル

- ダッシュボード定義（.dashboard.lookml.yaml形式）
- ダッシュボード用のフィルタ設定
- 各エレメント（Looker Gridなど）と表示設定

各ファイルはダッシュボード単位で構成されており、Looker上での表示項目・フィルタ・ソート順などを定義しています。

## 注意事項

- 本ダッシュボードは**ダミーデータ（dummy_kpiモデル）**を元に構成されており、実データではありません。
- 実運用向けのダッシュボードのベースサンプルやLookML記述方法の参考として利用する想定です。

## 参考リンク

- [Looker公式ドキュメント - ダッシュボードの管理](https://cloud.google.com/looker/docs/dashboards-intro)

