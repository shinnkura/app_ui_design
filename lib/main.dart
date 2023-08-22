import 'package:app_ui_design/badges_and_cnb/main.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'animated_splash_screen/main.dart';
import 'animation_onboarding_screen/main.dart';
import 'components/button.dart';
import 'intro_screen/main.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Turn off for release mode
      builder: (context) => const MyHome(), // Wrap your app
    ),
  );
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Note',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(),
        'badges': (context) => BadgesAndCNBApp(),
        'intro': (context) => IntroApp(),
        'animatedSplashScreen': (context) => SplashScreen(),
        'animationOnboarding': (context) => AnimationOnboading(),
      },
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Note',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF4C53A5),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   'レスポンシブデザイン',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Button(
                    width: double.infinity,
                    title: 'Badges and CNB',
                    onPressed: () {
                      Navigator.of(context).pushNamed('badges');
                    },
                    disable: false,
                  ),
                  SizedBox(height: 20),
                  Button(
                    width: double.infinity,
                    title: 'Intro Screen',
                    onPressed: () {
                      Navigator.of(context).pushNamed('intro');
                    },
                    disable: false,
                  ),
                  SizedBox(height: 20),
                  Button(
                    width: double.infinity,
                    title: 'Animated Splash Screen',
                    onPressed: () {
                      Navigator.of(context).pushNamed('animatedSplashScreen');
                    },
                    disable: false,
                  ),
                  SizedBox(height: 20),
                  Button(
                    width: double.infinity,
                    title: 'Animation Onboarding Screen',
                    onPressed: () {
                      Navigator.of(context).pushNamed('animationOnboarding');
                    },
                    disable: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
