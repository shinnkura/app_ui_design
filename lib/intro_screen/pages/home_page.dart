import 'package:app_ui_design/intro_screen/components/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import 'cart_page.dart';
import 'shop_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ページのインデックスを追跡する
  int _selectedIndex = 0;

  // ページのインデックスを変更する
  void navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // ページのインデックスに応じて、ページを表示する
  final List<Widget> _pages = [
    const ShopPage(),
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Home Page'),
        // backgroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomNavBar(index),
      ),
    );
  }
}
