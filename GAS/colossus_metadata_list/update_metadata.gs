function updateDataList() {
  var folderID = '1-dljwLCx0unqCfur_q4qvfNQqFHS3Znl'; // GoogleドライブのメタデータフォルダのID
  var folder = DriveApp.getFolderById(folderID);
  var spreadsheets = folder.getFilesByType(MimeType.GOOGLE_SHEETS);

  var dataListSheet = SpreadsheetApp.openById('18yTOhYNUjQ68_xoFI7IACuefdocmCPWSiOyk8kpDfkk');
  var sheetDataList = dataListSheet.getSheetByName('データ一覧');

  // データ一覧シートをクリア
  sheetDataList.clear();
  
  // ヘッダー行を書き込む
  sheetDataList.getRange(1, 1, 1, 15).setValues([['データセット名', 'テーブル物理名', 'テーブル論理名', '更新タイミング', 'パーティション有無', '最古データ日付(日本時間)', '最新データ日付(日本時間)', 'データオーナー', '個人情報の有無', '自由記述(テーブル)', 'カラム物理名', 'カラム論理名', 'データ型', '自由記述(カラム)', '入力用シートURL']]);
  // A1 & O1の背景色を薄い黄色に設定
  sheet.getRange('A1').setBackground('#FFFF99'); // 薄い黄色
  sheet.getRange('O1').setBackground('#FFFF99'); // 薄い黄色
  // B1〜J1の背景色を薄い青に設定
  sheet.getRange('B1:J1').setBackground('#99CCFF'); // 薄い青
  // K1〜N1の背景色を薄い緑に設定
  sheet.getRange('K1:N1').setBackground('#99FF99'); // 薄い緑
  
  var rowIndex = 2; // データ行の開始行

  while (spreadsheets.hasNext()) {
    var spreadsheet = spreadsheets.next();
    var spreadsheetID = spreadsheet.getId();
    var metadataSheet = SpreadsheetApp.openById(spreadsheetID);
    var metadataSheetName = metadataSheet.getName();
    
    if (metadataSheetName === "Colossusデータ一覧") {
      // "Colossusデータ一覧" の場合、以降の処理をスキップ
      Logger.log("Skipped: Colossusデータ一覧");
      continue;
    }
    Logger.log(`Started: ${metadataSheetName}`)

    var sheetTableList = metadataSheet.getSheetByName('テーブル一覧');
    var sheetColumnList = metadataSheet.getSheetByName('カラム一覧');
    var tableListData = sheetTableList.getDataRange().getValues();
    var columnListData = sheetColumnList.getDataRange().getValues();

    for (var j = 1; j < columnListData.length; j++) {
      var tableName = columnListData[j][0]; // カラム一覧のテーブル名（物理名）
      
      // テーブル一覧からテーブル論理名を取得
      var tableLogicalName = '';
      var updateTiming = '';
      var hasPartition　= '';
      var oldestDate = '';
      var latestData = '';
      var dataOwner = '';
      var containsPersonalInfo = '';
      var tableFreeDescription = '';
      for (var i = 1; i < tableListData.length; i++) {
        if (tableListData[i][0] === tableName) {
          tableLogicalName = tableListData[i][1];
          updateTiming = tableListData[i][2];
          hasPartition　 = tableListData[i][3];
          oldestDate　 = tableListData[i][4];
          latestData　 = tableListData[i][5];
          dataOwner　 = tableListData[i][6];
          containsPersonalInfo　 = tableListData[i][7];
          tableFreeDescription　 = tableListData[i][8];
          break;
        }
      }

      // TODO: メモリに持ってから書き出しに変更してもる
      var columnName = columnListData[j][1]; 
      var columnLogicalName = columnListData[j][2]; 
      var dataType = columnListData[j][3]; 
      var columnFreeDescription　 = columnListData[j][4]; // メモは3列目と仮定
      var inputSheetURL = metadataSheet.getUrl();
      sheetDataList.getRange(rowIndex, 1, 1, 15).setValues([[metadataSheetName, tableName, tableLogicalName, updateTiming, hasPartition　, oldestDate　, latestData　, dataOwner　, containsPersonalInfo　, tableFreeDescription　, columnName, columnLogicalName, dataType, columnFreeDescription, inputSheetURL　]]);
      rowIndex++;
    }
  }
}
