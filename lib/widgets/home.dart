import 'package:flutter/material.dart';
import 'package:zenn_app/widgets/article_search.dart';
import 'package:zenn_app/widgets/setting.dart';

import 'article_latest.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const _screens = [
    /* 最新記事一覧 */
    ArticleLatest(),
    /* 記事検索 */
    ArticleSearch(),
    /* 設定画面 */
    Setting(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(icon: Icon(Icons.bolt), label: '最新記事'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: '検索'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
