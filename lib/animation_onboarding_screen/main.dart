import 'package:flutter/material.dart';
import 'package:app_ui_design/animation_onboarding_screen/intro_screen.dart';


void main() {
  runApp(
    const AnimationOnboading(),
  );
}

class AnimationOnboading extends StatelessWidget {
  const AnimationOnboading({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'On Boarding Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const IntroScreenState(),
    );
  }
}
