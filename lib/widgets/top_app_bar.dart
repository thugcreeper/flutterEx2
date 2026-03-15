import 'package:flutter/material.dart';

//App的上方，可以放置標題、搜尋、通知等功能按紐的圖片
class TopList extends StatelessWidget implements PreferredSizeWidget {
  const TopList({
    super.key,
    this.title = '首頁',
    this.onAvatarTap,
    this.onChatTap,
    this.onSearchTap,
    this.onNotificationTap,
  });

  final String title;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onChatTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          children: const [
            Expanded(child: _TopTitleSection()),
            SizedBox(height: 90),
            Expanded(child: _TopActionsSection()),
          ],
        ),
      ),
    );
  }
}

class _TopTitleSection extends StatelessWidget {
  const _TopTitleSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        SizedBox(width: 10),
        Text('首頁', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _TopActionsSection extends StatelessWidget {
  const _TopActionsSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/head.jpg',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        Image.asset('assets/icons/chatIcon.jpg', width: 35, height: 35),
        Image.asset('assets/icons/searchIcon.jpg', width: 35, height: 35),
        Image.asset('assets/icons/notification.jpg', width: 35, height: 35),
      ],
    );
  }
}
