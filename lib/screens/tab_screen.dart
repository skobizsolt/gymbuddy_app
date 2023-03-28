import 'package:flutter/material.dart';

import './statistics_screen.dart';
import './profile_screen.dart';

class Page {
  final Widget body;
  final PreferredSizeWidget appBar;

  Page({required this.body, required this.appBar});
}

class TabScreen extends StatefulWidget {
  static const routeName = 'tab_screen';
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Page> _pages = [];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      Page(
        body: StatisticsScreen(),
        appBar: AppBar(
          title: const Text('Statistics'),
        ),
      ),
      Page(
        body: ProfileScreen(),
        appBar: AppBar(
          title: const Text('Profile'),
        ),
      ),
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _pages[_selectedPageIndex].appBar,
      body: _pages[_selectedPageIndex].body,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
