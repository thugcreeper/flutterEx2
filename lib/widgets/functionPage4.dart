import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const stravaOrange = Color.fromARGB(255, 251, 82, 1); //後面橘色都是用這個
const textGray = Color.fromARGB(255, 100, 99, 94); //通用文字灰色
const changeTextGrey = Color.fromARGB(255, 65, 65, 63); //顯示增減的文字用的

//這是小功能分頁的第四頁，個人每周快照
class PersonalWeeklySnapshot extends StatelessWidget {
  const PersonalWeeklySnapshot();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 上方標題列：你的每週快照 / 查看更多
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                '你的每週快照',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: const Text(
                  '查看更多',
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
        const SizedBox(height: 32),
        // 中間三個統計卡片：活動 / 時間 / 距離
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            _SnapshotItem(label: '活動', value: '1', changeText: '1'),
            _SnapshotItem(label: '時間', value: '2小...', changeText: '2小時12'),
            _SnapshotItem(label: '距離', value: '9.3...', changeText: '9.30'),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _SnapshotItem extends StatelessWidget {
  const _SnapshotItem({
    required this.label,
    required this.value,
    required this.changeText,
  });

  final String label;
  final String value;
  final String changeText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 活動、時間、距離的標籤
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 8),
        // 活動數、時間長度、距離數字（使用 Google Fonts Rubik）
        Text(
          value,
          style: GoogleFonts.rubik(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          // 左邊留得小一點，讓箭頭更靠近框線
          padding: const EdgeInsets.fromLTRB(0, 4, 8, 4),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F0),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              /*const Text(
                '▲',
                style: TextStyle(fontSize: 20, color: changeTextGrey),
              ),*/
              ClipRect(
                child: Align(
                  alignment: Alignment.center,
                  heightFactor: 0.7, // 裁掉一部分上下空白
                  child: Icon(
                    Icons.arrow_drop_up,
                    size: 30,
                    color: changeTextGrey,
                  ),
                ),
              ),
              Text(
                changeText,
                style: GoogleFonts.rubik(fontSize: 14, color: changeTextGrey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
