import 'package:flutter/material.dart';

import 'onboarding_screen.dart';

void main() {
  runApp(
    const IntroApp(),
  );
}

class IntroApp extends StatelessWidget {
  const IntroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
    );
  }
}
