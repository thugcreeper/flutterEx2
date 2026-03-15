import 'package:flutter/material.dart';

const stravaOrange = Color.fromARGB(255, 251, 82, 1); //後面橘色都是用這個
const textGray = Color.fromARGB(255, 100, 99, 94); //通用文字灰色

//這是小功能分頁的第三頁，設定個人目標
class SetPersonalGoals extends StatelessWidget {
  const SetPersonalGoals();

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
                  const Text(
                    '建議的目標',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 14),
                child: const Text(
                  '自訂',
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
        const SizedBox(height: 40), //放目標運動icon，與目標次數、設定按鈕的區域
        Row(
          children: [
            Image.asset('assets/icons/Goal1.jpg', height: 60, width: 60),
            const SizedBox(width: 12), //活動icon與文字的間距
            //文字區
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '每週2次騎車',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 4), //活動名稱與簡介的間距
                  Text(
                    '完成了0/2次騎乘',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis, //多出來的文字用...表示
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 120,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: stravaOrange,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                ),
                child: const Text(
                  '設定目標',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
