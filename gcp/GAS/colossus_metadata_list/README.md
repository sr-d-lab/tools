# Google Apps Script (GAS) - データ一覧の更新

## 概要

このGoogle Apps Script（GAS）は、指定されたGoogleドライブフォルダ内のGoogle Sheets（スプレッドシート）を検索し、各シートから必要なメタデータを取得して、指定された「データ一覧」シートにその情報をまとめて書き出します。各シートのメタデータにはテーブルやカラムに関する情報が含まれており、それを「データ一覧」シートに整理して記録します。
データ活用利用者もPR作成せずとも、「自由記述」欄に自由に知見をメモできるところがポイントです。

[スプレッドシートサンプル](https://docs.google.com/spreadsheets/d/1ucQHT2p9xPRmkJwsJLUdz_srwwxgi_Ax/)

メタデータの元データ生成については下記参照。

## 主な機能

- Googleドライブの指定フォルダからGoogle Sheetsを検索
- 各シートの「テーブル一覧」と「カラム一覧」シートから情報を取得
- 取得した情報をまとめて「データ一覧」シートに書き込む
- ヘッダー行に色付け（背景色を変更）
- 必要なメタデータ（テーブル名、論理名、更新タイミングなど）を整形して「データ一覧」シートに出力

## 使用方法

### 1. スクリプトの設定

1. Google Apps Script（GAS）エディタにアクセスし、プロジェクトを作成します。
2. 以下のスクリプトをコピーして、GASエディタに貼り付けます。
3. スクリプト内の `folderID` を自分のGoogleドライブのメタデータフォルダのIDに変更します。
   - メタデータフォルダのIDは、Googleドライブでそのフォルダを開き、URLの最後の部分（`/folders/`の後ろ）から取得できます。
4. `dataListSheet` の `SpreadsheetApp.openById` に設定されているIDも、出力先のスプレッドシートのIDに変更します。

### 2. スクリプトの実行

- `updateDataList()` 関数を実行することで、指定されたGoogleドライブフォルダ内のシート情報を「データ一覧」シートに書き込みます。
- スクリプトは、指定フォルダ内のすべてのGoogle Sheetsを処理し、それぞれのテーブルやカラム情報を順番に取得して書き込みます。

### 3. 出力結果

- 出力先の「データ一覧」シートには、次のような情報が書き込まれます：
  - `データセット名` (スプレッドシートの名前)
  - `テーブル物理名`
  - `テーブル論理名`
  - `更新タイミング`
  - `パーティション有無`
  - `最古データ日付(日本時間)`
  - `最新データ日付(日本時間)`
  - `データオーナー`
  - `個人情報の有無`
  - `自由記述(テーブル)`
  - `カラム物理名`
  - `カラム論理名`
  - `データ型`
  - `自由記述(カラム)`
  - `入力用シートURL`

### 4. 背景色設定

- ヘッダー行の背景色が設定されます：
  - A1 & O1は薄い黄色
  - B1〜J1は薄い青
  - K1〜N1は薄い緑

## 設定方法

1. Google Apps Scriptを使用するには、まずGoogleドライブ内の任意のスプレッドシートにアクセスします。
2. `ツール` > `スクリプト エディタ` を選択して、新しいスクリプトを作成します。
3. 作成したスクリプトに、上記のコードを貼り付けます。
4. 必要なID（フォルダIDやスプレッドシートID）を設定します。
5. スクリプトを保存して実行します。

## 注意点

- スクリプトが正しく動作するためには、Googleドライブ内のシートが指定通りに構成されている必要があります。
- スクリプトは、シート名やセルの位置が変更されると動作しなくなる可能性があるため、シート構成を変更する際にはスクリプトの調整が必要です。

## サポート

- スクリプトが正常に動作しない場合、エラーメッセージを確認し、Google Apps Scriptエディタのログをチェックしてください。
- 追加機能やカスタマイズが必要な場合は、スクリプトを編集して調整することができます。
