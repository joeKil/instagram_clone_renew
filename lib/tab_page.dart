import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:instagram_clone_renew/tab/account/account_page.dart';
import 'package:instagram_clone_renew/tab/home/home_page.dart';
import 'package:instagram_clone_renew/tab/search/search_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _currentIndex = 0;

  // 탭페이지에 페이지들을 연결.. 와우 이런 방법이..
  final _pages = const [
    HomePage(),
    SearchPage(),
    AccountPage(),
    // 프로필 꾸밈.
    ProfileScreen(
      providerConfigs: [
        // 이메일 인증
        EmailProviderConfiguration(),
      ],
      avatarSize: 24,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 화면 연동
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // 이렇게하면 아이콘이 4개 이상되어도 잘나옴
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        // 이렇게하면 각 인덱스값에 맞는 아이콘이 클릭되는 효과를 얻음.
        onTap: (index) {
          _pages;
          // 새로 바뀌는 인덱스값 여기서 알 수 있음.
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
