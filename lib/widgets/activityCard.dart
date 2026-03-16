import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const smallTextGrey = Color.fromARGB(255, 67, 66, 62); //活動卡片裡面紀錄時間地點等欄位的灰色

class ActivityCard extends StatelessWidget {
  final String yourName;
  final String yourProfileImage; //使用者頭像圖片名稱（放在 assets/images/ 底下）
  final String activityName;
  final String activityType;
  final String activityStartTime; //上午7.10分、下午4.30分這種格式
  final String district; //開始紀錄活動的行政區，要加上"區"
  final String city; //要寫"縣"或"市"結尾
  final String distance;
  final String climbHeight;
  final String duringtime;
  final String imageName; // 要顯示在卡片下方的圖片名稱（放在 assets/images/ 底下）
  final bool showAchievements; // 是否改成「距離+爬升+成就」版型
  final List<int> achievementCounts; // [金牌數量, 銀牌數量, 銅牌數量]，長度預期為 3

  const ActivityCard({
    super.key,
    required this.yourName,
    this.yourProfileImage = 'head.jpg', //預設頭像圖片名稱
    required this.activityName,
    required this.activityType,
    required this.distance,
    required this.climbHeight,
    required this.duringtime,
    required this.activityStartTime,
    required this.district,
    required this.city,
    required this.imageName,
    this.showAchievements = false,
    this.achievementCounts = const [0, 0, 0],
  });

  @override
  Widget build(BuildContext context) {
    // 成就用：index0 = 金牌數量，index1 = 銀牌數量，index2 = 銅牌數量
    final int goldCount = achievementCounts.isNotEmpty
        ? achievementCounts[0]
        : 0;
    final int silverCount = achievementCounts.length > 1
        ? achievementCounts[1]
        : 0;
    final int bronzeCount = achievementCounts.length > 2
        ? achievementCounts[2]
        : 0;
    final int totalAchievements = goldCount + silverCount + bronzeCount;

    return Container(
      color: Colors.white, // 卡片背景為全白，沒有圓角與陰影
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 上半部：頭像、名稱、時間、地點與數據
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, //讓column內的元素靠左對齊(X axis)
              children: [
                Row(
                  children: [
                    //圓形使用者頭像
                    ClipOval(
                      child: Image.asset(
                        'assets/images/$yourProfileImage',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          yourName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '今天的 $activityStartTime · Strava App',
                          style: GoogleFonts.rubik(fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            if (activityType.toLowerCase() == 'run')
                              Image.asset(
                                'assets/icons/stravaShoe.jpg',
                                width: 16,
                                height: 16,
                              ),
                            if (activityType.toLowerCase() == 'ride')
                              Image.asset(
                                'assets/icons/stravaBicycle.jpg',
                                width: 16,
                                height: 16,
                              ),
                            if (activityType.toLowerCase() == 'run' ||
                                activityType.toLowerCase() == 'ride')
                              const SizedBox(width: 4),
                            Text(
                              '$district, $city',

                              style: const TextStyle(
                                color: smallTextGrey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                //活動名稱文字區
                Text(
                  activityName,
                  style: const TextStyle(
                    fontSize: 28, //約和"首頁"標題字一樣大
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                // 數據區塊：預設是「距離 / 爬升 / 時間」，
                // 若 showAchievements 為 true，則改成「距離 / 爬升 + 成就獎牌列」。
                if (!showAchievements)
                  Row(
                    //距離、爬升海拔、時間三個數據區塊，平均分配在一行，左右對齊
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '距離',
                              style: TextStyle(
                                color: smallTextGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              distance,
                              style: GoogleFonts.rubik(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '爬升海拔',
                              style: TextStyle(
                                color: smallTextGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              climbHeight,
                              style: GoogleFonts.rubik(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '時間',
                              style: TextStyle(
                                color: smallTextGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              duringtime,
                              style: GoogleFonts.rubik(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '距離',
                                  style: TextStyle(
                                    color: smallTextGrey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  distance,
                                  style: GoogleFonts.rubik(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '爬升海拔',
                                  style: TextStyle(
                                    color: smallTextGrey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  climbHeight,
                                  style: GoogleFonts.rubik(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '成就',
                                  style: TextStyle(
                                    color: smallTextGrey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                if (totalAchievements > 0)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // 金牌
                                      ...List.generate(goldCount, (index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 4.0,
                                          ),
                                          child: Image.asset(
                                            'assets/icons/goldenMedal.jpg',
                                            width: 22,
                                            height: 22,
                                          ),
                                        );
                                      }),
                                      // 銀牌
                                      ...List.generate(silverCount, (index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 4.0,
                                          ),
                                          child: Image.asset(
                                            'assets/icons/silverMedal.jpg',
                                            width: 22,
                                            height: 22,
                                          ),
                                        );
                                      }),
                                      // 銅牌
                                      ...List.generate(bronzeCount, (index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 4.0,
                                          ),
                                          child: Image.asset(
                                            'assets/icons/bronzeMedal.jpg',
                                            width: 22,
                                            height: 22,
                                          ),
                                        );
                                      }),
                                      Text(
                                        totalAchievements.toString(),
                                        style: GoogleFonts.rubik(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  const Text(
                                    '本次活動沒有成就',
                                    style: TextStyle(
                                      color: smallTextGrey,
                                      fontSize: 14,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
              ],
            ),
          ),
          // 活動圖片，左右貼齊螢幕，完整顯示圖片不被裁切
          Image.asset(
            'assets/images/$imageName',
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          //按讚、分享、留言icon，用expanded平均分配
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Image.asset(
                  'assets/icons/like.jpg',
                  width: 30,
                  height: 30,
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/icons/chatIcon2.jpg',
                  width: 30,
                  height: 30,
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/icons/share.jpg',
                  width: 30,
                  height: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
