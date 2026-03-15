import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/top_app_bar.dart';
import 'widgets/functionPage2.dart';
import 'widgets/functionPage1.dart';
import 'widgets/functionPage3.dart';
import 'widgets/functionPage4.dart';

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
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TopList(),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(
              height: 30, // 整個組件佔用的高度（線本身厚度不變，是上下留白的總和）
              thickness: 3, // 線本身的厚度
              color: generalGrey, // 線條顏色
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200, // 分頁區高度，可以依照設計再調整
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: const [
                  // 第 1 頁：運動補給站
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SportInfo(),
                  ),
                  // 第 2 頁：你的連續紀錄
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
            // 四個小圓圈，顯示目前第幾頁
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
                        ? Colors
                              .grey
                              .shade700 // 目前這頁：深灰色
                        : generalGrey, // 其他頁：淺灰色
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            //分割小功能分頁的線，比較粗
            const Divider(
              height: 30, // 整個組件佔用的高度（線本身厚度不變，是上下留白的總和）
              thickness: 6, // 線本身的厚度
              color: generalGrey, // 線條顏色
            ),
            // TODO: 之後在這裡放「紀錄活動的卡片」(ListView 或 Column)
          ],
        ),
      ),
    );
  }
}
