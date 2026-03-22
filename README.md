# Flutter homework2

以Flutter模仿Strava 風格介面，包含首頁資訊分頁、活動卡片、推薦人物與推薦挑戰等元件。

## 主要功能

- 首頁小功能分頁（`PageView`）
- 活動卡片（支援一般數據版型與成就版型）
- 活動卡片按讚資訊：
	- 可設定按讚人數
	- 可設定按讚頭像（最多顯示 3 個）
	- 頭像支援重疊顯示
- 推薦追蹤人物：一次滑動一張
- 推薦挑戰：一次滑動一張

## 作業要求

一定要使用的widget：

- [x] `Text`：`activityCard.dart`、`recommendedChallenge.dart 等`
- [x] `Image`：`activityCard.dart`、`top_app_bar.dart 等`
- [x] `Icon`：`main.dart`、`functionPage1.dart`
- [x] `Column`：`main.dart`、`recommendedPerson.dart 等`
- [x] `Row`：`widgets/activityCard.dart`、`top_app_bar.dart 等`
- [x] `Color`：`widgets/recommendedChallenge.dart`、`functionPage4.dart`
- [x] `Stack`：`main.dart`、`activityCard.dart`
- [x] `SingleChildScrollView`：`main.dart`

## 專案結構

- `lib/main.dart`：首頁主畫面與各區塊組裝
- `lib/widgets/top_app_bar.dart`：頂部 App Bar 元件
- `lib/widgets/activityCard.dart`：活動卡片元件（含成就與按讚顯示）
- `lib/widgets/recommendedPerson.dart`：推薦人物卡片區塊
- `lib/widgets/recommendedChallenge.dart`：推薦挑戰卡片區塊
- `lib/widgets/functionPage1.dart`：小功能分頁第 1 頁（運動補給站）
- `lib/widgets/functionPage2.dart`：小功能分頁第 2 頁（連續紀錄）
- `lib/widgets/functionPage3.dart`：小功能分頁第 3 頁（建議目標）
- `lib/widgets/functionPage4.dart`：小功能分頁第 4 頁（每週快照）
- `assets/images/`：活動圖片、人物頭像、底部圖等素材
- `assets/icons/`：功能 icon、按鈕 icon、獎牌圖示等素材


## 開發環境需求

- Flutter SDK（建議使用穩定版）
- Dart SDK（隨 Flutter 安裝）
- Android Studio / VS Code（含 Flutter、Dart 外掛）
- Android Emulator 或實機

## 如何執行

1. 安裝套件

```bash
flutter pub get
```

2. 啟動模擬器（或接上實機）

```bash
flutter devices
```

3. 執行專案

```bash
flutter run
```

## 常用指令

```bash
flutter clean
flutter pub get
flutter run
```

## 常見問題

### 卡在 App 圖示、無法安裝 APK

若出現 `INSTALL_FAILED_INSUFFICIENT_STORAGE`，通常是模擬器空間不足：

1. 先卸載舊版 App
2. 清理模擬器資料或建立新模擬器
3. 重新執行 `flutter run`

## 備註

- 專案素材圖片位於 `assets/images/` 與 `assets/icons/`
- 若新增圖片，請確認 `pubspec.yaml` 已正確宣告 assets
