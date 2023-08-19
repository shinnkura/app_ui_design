import 'package:flutter/material.dart';

import 'pages/cart_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        '/': (context) => HomeScreen(),
        'cartPage': (context) => CartPage(),
      },
    );
  }
}
