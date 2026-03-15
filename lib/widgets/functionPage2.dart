import 'package:flutter/material.dart';

const stravaOrange = Color.fromARGB(255, 251, 82, 1); //後面橘色都是用這個
const generalGrey = Color.fromARGB(255, 242, 242, 240); //基本上灰色都用這個

//這是小功能分頁的第二頁，顯示你這週運動紀錄與連續幾週了
class StreakPage extends StatelessWidget {
  const StreakPage();

  @override
  Widget build(BuildContext context) {
    final labels = ['一', '二', '三', '四', '五', '六', '日'];
    final days = [9, 10, 11, 12, 13, 14, 15];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                '你的連續紀錄',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 14),
                child: const Text(
                  '查看行事曆',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: stravaOrange,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40), //查看行事曆、連續紀錄與日曆的間距
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16), //將連續幾周的元件向右推16
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/stravaFire.jpg',
                        height: 70,
                        width: 40,
                      ),
                      Transform.translate(
                        offset: const Offset(0, 10), // 將文字"1"往下移一點
                        child: const Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    '週',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: stravaOrange,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(labels.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ), // 控制左右距離
                    child: _WeekdayCircle(
                      label: labels[index],
                      day: days[index],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _WeekdayCircle extends StatelessWidget {
  const _WeekdayCircle({required this.label, required this.day});

  final String label;
  final int day;

  Color get _backgroundColor {
    if (day >= 9 && day <= 13) {
      return generalGrey; // 9-13 灰色
    } else if (day == 14) {
      return Colors.black; // 14 黑色
    } else if (day == 15) {
      return Colors.white; // 15 白色
    }
    return Colors.transparent;
  }

  Color get _textColor {
    if (day == 14) {
      return Colors.white; // 黑底白字
    }
    // 灰底與白底都用黑字
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          Text(label),
          const SizedBox(height: 20), //星期與日期的上下間隔
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _backgroundColor,
              border: day == 15
                  ? Border.all(color: Colors.grey.shade300, width: 2)
                  : null,
            ),
            child: Text(
              '$day',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: _textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
