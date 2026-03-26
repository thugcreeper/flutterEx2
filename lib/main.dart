import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/top_app_bar.dart';
import 'widgets/functionPage2.dart';
import 'widgets/functionPage1.dart';
import 'widgets/functionPage3.dart';
import 'widgets/functionPage4.dart';
import 'widgets/activityCard.dart';
import 'widgets/recommendedChallenge.dart';
import 'widgets/recommendedPerson.dart';

//顏色用小畫家的吸管去吸，之後開啟編輯顏色即可知道色碼，用變數存比較方便後續使用
const stravaOrange = Color.fromARGB(255, 251, 82, 1); //後面橘色都是用這個
const generalGrey = Color.fromARGB(255, 242, 242, 240); //基本上灰色都用這個
void main() {
  runApp(const MyStrava());
}

class MyStrava extends StatelessWidget {
  const MyStrava({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'myStrava',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        scrollbarTheme: const ScrollbarThemeData(
          thickness: MaterialStatePropertyAll(4),
          radius: Radius.circular(8),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0, // 滾動內容時也不要加陰影/變色
          surfaceTintColor: Colors.white, // 避免 Material3 的表面色覆蓋
          foregroundColor: Colors.black,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
      scrollBehavior: const ScrollBehavior().copyWith(scrollbars: true),
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: ''),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  ScrollController _scrollController = ScrollController();

  // 從上一次位置開始，滑動超過這個距離就切換按鈕顯示/隱藏
  static const double _fabScrollDelta = 10.0;
  double _lastScrollOffset = 0.0;
  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose(); // 別忘了釋放controller資源
    super.dispose();
  }

  bool _showAddActivityBtn = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final double offset = _scrollController.position.pixels;
      final double delta = offset - _lastScrollOffset; // 正數=往下滑，負數=往上滑

      // 往下滑一段距離就隱藏，往上滑一段距離就顯示
      if (delta > _fabScrollDelta && _showAddActivityBtn) {
        setState(() => _showAddActivityBtn = false);
        _lastScrollOffset = offset;
      } else if (delta < -_fabScrollDelta && !_showAddActivityBtn) {
        setState(() => _showAddActivityBtn = true);
        _lastScrollOffset = offset;
      } else {
        // 沒有超過門檻就只是更新位置，避免累積誤差
        _lastScrollOffset = offset;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TopList(),
      body: SafeArea(
        child: Stack(
          children: [
            // 最底層：可滾動的內容包含活動卡片與推薦好友
            Scrollbar(
              controller: _scrollController,
              //timeToFade: const Duration(milliseconds: 800),
              //fadeDuration: const Duration(milliseconds: 250),
              thumbVisibility: false,
              child: SingleChildScrollView(
                controller: _scrollController, // 讓整個頁面可以滾動，包含分頁區和活動卡片區
                padding: const EdgeInsets.only(
                  bottom: 120,
                ), // 預留底部高度，避免被 bottom bar 蓋住
                child: Column(
                  children: [
                    const Divider(height: 30, thickness: 3, color: generalGrey),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: SportInfo(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: StreakPage(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: SetPersonalGoals(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: PersonalWeeklySnapshot(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        final bool isActive = index == _currentPage;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isActive
                                ? Colors.grey.shade700
                                : generalGrey,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 30, thickness: 6, color: generalGrey),
                    const ActivityCard(
                      yourName: '洪賢 王',
                      activityName: '午後健行',
                      activityType: 'Run',
                      distance: '9.30 公里',
                      climbHeight: '386 公尺',
                      duringtime: '2小時12分',
                      activityStartTime: '今天的 下午1:32',
                      district: '中正區',
                      city: '基隆市',
                      imageName: 'myActivity.jpg',
                    ),
                    const Divider(height: 30, thickness: 6, color: generalGrey),
                    const ActivityCard(
                      yourName: '瘩瘩 魯',
                      yourProfileImage: 'userL.jpg',
                      activityName: '環尛台灣',
                      activityType: 'ride',
                      distance: '16.66 公里',
                      climbHeight: '118 公尺',
                      duringtime: '2小時12分',
                      activityStartTime: '2025年8月26日 下午3:25',
                      district: '香山區',
                      city: '新竹市',
                      imageName: 'myActivity3.jpg',
                      showAchievements: true,
                      achievementCounts: [1, 1, 0],
                    ),

                    SizedBox(height: 20),
                    RecommendedPerson(
                      people: const [
                        RecommendedPersonInfo(
                          name: 'Will',
                          introduce: '粉絲在 Strava 的最愛',
                          imageName: 'userX.png',
                        ),
                        RecommendedPersonInfo(
                          name: '魯瘩瘩',
                          introduce: '你附近的 Local Legend',
                          imageName: 'userL.jpg',
                        ),
                        RecommendedPersonInfo(
                          name: 'Kyle Crane(哈蘭超人)',
                          introduce: '粉絲在 Strava 的最愛',
                          imageName: 'userCrane.webp',
                        ),
                      ],
                    ),
                    const ActivityCard(
                      yourName: '洪賢 王',
                      activityName: '復健',
                      activityType: 'ride',
                      distance: '50.37 公里',
                      climbHeight: '346 公尺',
                      duringtime: '2小時12分',
                      activityStartTime: '2025年6月10日 上午10:13',
                      district: '貢寮區',
                      city: '新北市',
                      imageName: 'myActivity2.jpg',
                      showAchievements: true,
                      achievementCounts: [0, 1, 0],
                      likeCount: 2,
                      likedUserProfileImages: ['user4.jpg', 'user5.jpg'],
                    ),
                    const Divider(height: 30, thickness: 6, color: generalGrey),
                    const ActivityCard(
                      yourName: '洪賢 王',
                      //yourProfileImage: 'head.png',
                      activityName: '晨間騎車',
                      activityType: 'ride',
                      distance: '41.24 公里',
                      climbHeight: '250 公尺',
                      duringtime: '2小時22分',
                      activityStartTime: '2025年1月30日清晨6:46',
                      district: '香山區',
                      city: '新竹市',
                      imageName: 'myActivity6.jpg',
                      showAchievements: true,
                      achievementCounts: [6, 1, 1],
                      likeCount: 3,
                      //按讚者的頭像，最多傳3個
                      likedUserProfileImages: [
                        'user1.jpg',
                        'user5.jpg',
                        'user6.jpg',
                      ],
                    ),
                    const RecommendedChallenge(
                      activities: [
                        RecommendedChallengeInfo(
                          howManyPeopleJoind: '292,000',
                          activityName: '三月Gran Dondo 挑戰',
                          introduce: '100公里。一次騎行。出發吧!',
                          reward: '數位獎盃',
                          imageName: 'challenge1.jpg',
                        ),
                        RecommendedChallengeInfo(
                          howManyPeopleJoind: '968,000',
                          activityName: '三月400分鐘 x Runna挑戰',
                          introduce: '紀錄400分鐘的活動。解鎖2週免費體驗+贏取夏威夷賽事之旅!',
                          reward: '獎勵',
                          imageName: 'challenge2.jpg',
                        ),
                        RecommendedChallengeInfo(
                          howManyPeopleJoind: '1,123,000',
                          activityName: '三月十天活動挑戰',
                          introduce: '你能連續十天做到嗎?',
                          reward: '數位獎盃',
                          imageName: 'challenge3.jpg',
                        ),
                      ],
                    ),
                    const ActivityCard(
                      yourName: 'Will',
                      yourProfileImage: 'userX.png',
                      activityName: '下午騎車',
                      activityType: 'ride',
                      distance: '22.17 公里',
                      climbHeight: '63 公尺',
                      duringtime: '1小時16分',
                      activityStartTime: '2024年6月21日 下午16:19',
                      district: '淡水區',
                      city: '新北市',
                      imageName: 'myActivity5.jpg',
                      likeCount: 5,
                      //按讚者的頭像，最多傳3個
                      likedUserProfileImages: [
                        'user1.jpg',
                        'user2.jpg',
                        'user3.jpg',
                      ],
                    ),
                    const Divider(height: 30, thickness: 6, color: generalGrey),
                    const ActivityCard(
                      yourName: 'Kyle Crane(哈蘭超人)',
                      yourProfileImage: 'userCrane.webp',
                      activityName: '恆春->知本',
                      activityType: 'ride',
                      distance: '111.17 公里',
                      climbHeight: '1134 公尺',
                      duringtime: '5小時26分',
                      activityStartTime: '2022年7月12日 清晨7:34',
                      district: '恆春鎮',
                      city: '屏東縣',
                      imageName: 'myActivity4.jpg',
                    ),
                  ],
                ),
              ),
            ),

            // 第二層：新增活動按鈕（浮在卡片上方）
            Positioned(
              right: 16,
              bottom: 96, // 在 bottom app bar 上方一點
              child: AnimatedSlide(
                offset: _showAddActivityBtn
                    ? const Offset(0, 0)
                    : const Offset(0, 3),
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: Transform.translate(
                  offset: const Offset(-8, 0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      backgroundColor: stravaOrange,
                      foregroundColor: Colors.white,
                      elevation: 6,
                    ),
                    child: const Icon(Icons.add, size: 40),
                  ),
                ),
              ),
            ),

            // 最上層：bottom app bar，覆蓋在最底部
            Positioned(
              left: 0,
              right: 0,
              bottom: -10,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: generalGrey, width: 1)),
                  color: Colors.white,
                ),
                child: SafeArea(
                  top: false,
                  child: SizedBox(
                    height: 90,
                    child: Image.asset('assets/images/bottomBar.jpg'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
