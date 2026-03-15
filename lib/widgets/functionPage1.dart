import 'package:flutter/material.dart';

const stravaOrange = Color.fromARGB(255, 251, 82, 1); //後面橘色都是用這個
const textGray = Color.fromARGB(255, 100, 99, 94); //通用文字灰色

//這是小功能分頁的第一頁，運動補給站
class SportInfo extends StatelessWidget {
  const SportInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/stravaIconMini.jpg',
                    height: 30,
                    width: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '運動補給站',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 14),
                child: const Text(
                  '查看全部',
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
        const SizedBox(height: 40), //放活動icon，活動名稱、簡介與一個Icon:右箭頭的區域
        Row(
          children: [
            Image.asset('assets/icons/sportIcon1.jpg', height: 100, width: 100),
            const SizedBox(width: 12), //活動icon與文字的間距
            //文字區
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Easy Hike',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 4), //活動名稱與簡介的間距
                  Text(
                    'Explore the outdoors and stay active with an easy hike. Conn...',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis, //多出來的文字用...表示
                    style: TextStyle(fontSize: 16, color: textGray),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 28, color: Colors.black),
          ],
        ),
      ],
    );
  }
}
