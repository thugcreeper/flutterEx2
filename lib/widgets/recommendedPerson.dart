import 'package:flutter/material.dart';

const stravaOrange = Color.fromARGB(255, 251, 82, 1); //後面橘色都是用這個
const generalGrey = Color.fromARGB(255, 242, 242, 240); //基本上灰色都用這個
const smallTextGrey = Color.fromARGB(255, 67, 66, 62); //人物卡片裡面介紹文字的灰色

/// 單一推薦人物的資料結構
class RecommendedPersonInfo {
  final String name;
  final String introduce;
  final String imageName;

  const RecommendedPersonInfo({
    required this.name,
    required this.introduce,
    required this.imageName,
  });
}

// 這是推薦他人的整個區塊（上方標題 + 可左右滑動的人卡片）
class RecommendedPerson extends StatefulWidget {
  /// 卡片列表資料
  final List<RecommendedPersonInfo> people;

  /// 卡片寬度與高度，讓你可以自訂
  final double cardWidth;
  final double cardHeight;
  final double viewportFraction;

  const RecommendedPerson({
    super.key,
    required this.people,
    this.cardWidth = 260,
    this.cardHeight = 280,
    this.viewportFraction = 0.72,
  });

  @override
  State<RecommendedPerson> createState() => _RecommendedPersonState();
}

class _RecommendedPersonState extends State<RecommendedPerson> {
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
      height: widget.cardHeight + 100,
      color: generalGrey,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 上方標題列（不改你的文案，只修正 layout 寫法）
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '推薦追蹤的運動愛好者',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '查看全部',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: stravaOrange,
                  ),
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
              itemCount: widget.people.length,
              itemBuilder: (context, index) {
                final person = widget.people[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _PersonCard(
                    info: person,
                    width: widget.cardWidth,
                    height: widget.cardHeight,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 真正顯示「頭像 + 名字 + 介紹 + 追蹤/移除按鈕」的卡片
class _PersonCard extends StatelessWidget {
  final RecommendedPersonInfo info;
  final double width;
  final double height;

  const _PersonCard({
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          //讓column裡的元素置中對齊
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              const SizedBox(height: 8),
              Text(
                info.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                info.introduce,
                style: const TextStyle(fontSize: 16, color: smallTextGrey),
                maxLines: 2,

                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ), //水平對稱的padding，讓按鈕不會貼到卡片邊緣
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: stravaOrange,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      //padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text(
                      '追蹤',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      //padding: const EdgeInsets.symmetric(vertical: 10),
                      side: const BorderSide(color: stravaOrange, width: 1),
                      foregroundColor: stravaOrange,
                    ),
                    child: const Text(
                      '移除',
                      style: TextStyle(fontSize: 16, color: stravaOrange),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
