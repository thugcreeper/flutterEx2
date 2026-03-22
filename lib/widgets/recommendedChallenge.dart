import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const stravaOrange = Color.fromARGB(255, 251, 82, 1); //後面橘色都是用這個
const generalGrey = Color.fromARGB(255, 242, 242, 240); //基本上灰色都用這個
const smallTextGrey = Color.fromARGB(255, 67, 66, 62); //人物卡片裡面介紹文字的灰色
const rewardBackground = Color.fromARGB(255, 238, 175, 10); //獎勵背景顏色

class RecommendedChallengeInfo {
  final String howManyPeopleJoind; //紀錄"已有超過XXX位運動同號加入，XXX是會變動的"
  final String activityName;
  final String introduce;
  final String imageName;
  final String reward;

  const RecommendedChallengeInfo({
    required this.howManyPeopleJoind,
    required this.activityName,
    required this.introduce,
    required this.imageName,
    required this.reward,
  });
}

// 這是推薦挑戰整個區塊
class RecommendedChallenge extends StatefulWidget {
  /// 卡片列表資料
  final List<RecommendedChallengeInfo> activities;

  /// 卡片寬度與高度，讓你可以自訂
  final double cardWidth;
  final double cardHeight;
  final double viewportFraction;

  const RecommendedChallenge({
    super.key,
    required this.activities,
    this.cardWidth = 360,
    this.cardHeight = 360,
    this.viewportFraction = 0.9,
  });

  @override
  State<RecommendedChallenge> createState() => _RecommendedChallengeState();
}

class _RecommendedChallengeState extends State<RecommendedChallenge> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: widget.viewportFraction);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: cardHeight + 150,
      width: double.infinity,
      color: generalGrey,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: .start,
              children: const [
                Text(
                  '建議的挑戰',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  '讓責任更輕鬆、更有趣,還能獲得獎勵 !',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // 標題與推薦人卡片之間的間距
          // 可左右滑動的卡片列
          SizedBox(
            height: widget.cardHeight,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.activities.length,
              itemBuilder: (context, index) {
                final activity = widget.activities[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _ChallengeCard(
                    info: activity,
                    width: widget.cardWidth,
                    height: widget.cardHeight,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20), //卡片列與探索所有挑戰按鈕的間距
          Container(
            alignment: .bottomRight,
            padding: EdgeInsets.only(right: 20),
            child: Text(
              '探索所有挑戰',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: stravaOrange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 真正顯示「活動icon + 活動名字 + 介紹 + 參加挑戰按鈕」的卡片
class _ChallengeCard extends StatelessWidget {
  final RecommendedChallengeInfo info;
  final double width;
  final double height;

  const _ChallengeCard({
    required this.info,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    '已有超過${info.howManyPeopleJoind}位運動同好加入',
                    style: GoogleFonts.rubik(
                      fontSize: 14,
                      color: smallTextGrey,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: .start,
                  children: [
                    CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/${info.imageName}',
                          fit: BoxFit.cover,
                          // //errorBuilder 是 Image widget 的一個參數，當圖片載入失敗時會呼叫這個函式，讓你可以回傳一個替代的 widget
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/testUser.jpg',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            info.activityName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4), //活動名稱與簡介的間距
                          Text(
                            info.introduce,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis, //多出來的文字用...表示
                            style: GoogleFonts.rubik(
                              fontSize: 16,
                              color: smallTextGrey,
                            ),
                          ),
                          SizedBox(height: 10), //活動簡介與獎勵的間距
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: rewardBackground,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              info.reward,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 30,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: stravaOrange,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
              ),
              child: const Text(
                '參加挑戰',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
