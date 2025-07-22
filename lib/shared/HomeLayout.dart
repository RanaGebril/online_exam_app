import 'package:flutter/material.dart';

import '../features/profile/presentation/pages/explore_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/profile/presentation/pages/result_page.dart';

class MainLayout extends StatefulWidget {
  final int initialIndex;
  const MainLayout({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    super.initState();
  }

  final List<Widget> _screens = [
    ExplorePage(),
    ResultPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}


