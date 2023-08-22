import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';

import 'page_model.dart';

class IntroScreenState extends StatefulWidget {
  const IntroScreenState({super.key});

  @override
  State<IntroScreenState> createState() => _IntroScreenStateState();
}

class _IntroScreenStateState extends State<IntroScreenState> {
  final pages = [
    const PageData(
      title: 'Welcome',
      image: 'https://img.icons8.com/?size=512&id=115350&format=png',
      bgColor: Colors.red,
      textColor: Colors.white,
    ),
    const PageData(
      title: 'Welcome',
      image: 'https://img.icons8.com/?size=512&id=115350&format=png',
      bgColor: Colors.blue,
      textColor: Colors.white,
    ),
    const PageData(
      title: 'Welcome',
      image: 'https://img.icons8.com/?size=512&id=115350&format=png',
      bgColor: Colors.green,
      textColor: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ConcentricPageView(
        colors: pages.map((p) => p.bgColor).toList(),
        radius: screenWidth * 0.1,
        nextButtonBuilder: (context) => Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Icon(
            Icons.navigate_next,
            size: screenWidth * 0.08,
            color: Colors.black,
          ),
        ),
        itemBuilder: (int index) {
          final page = pages[index % pages.length];
          return SafeArea(
            child: _Page(page: page),
          );
        },
      ),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({super.key, required this.page});

  final PageData page;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    space(double p) => SizedBox(height: screenHeight * p / 100);
    return Column(
      children: [
        space(10),
        Image.network(page.image.toString()),
        space(8),
        _Text(
          page: page,
          style: TextStyle(
            fontSize: screenHeight * 0.046,
          ),
        ),
      ],
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({super.key, required this.page, this.style});

  final PageData page;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          page.title.toString(),
          style: style,
        ),
      ],
    );
  }
}
