import 'package:app_ui_design/badges_and_cnb/main.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'components/button.dart';

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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
