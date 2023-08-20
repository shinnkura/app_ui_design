import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'pages/home_page.dart';
import 'intro_screens/intro_screen_1.dart';
import 'intro_screens/intro_screen_2.dart';
import 'intro_screens/intro_screen_3.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // 現在のページを追跡するコントローラー
  PageController _controller = PageController();

  // 最後のページに到達したかどうかを追跡する
  bool onLastpage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastpage = (index == 2);
              });
            },
            children: [
              IntroScreen1(),
              IntroScreen2(),
              IntroScreen3(),
            ],
          ),

          // ドットインジケーター
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 最初のページに到達した場合は、Skipを表示しない
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                // ドットインジケーター
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                  ),
                ),

                // 最後のページに到達した場合は、NextをDoneに変更する
                onLastpage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ),
                          );
                        },
                        child: Text('done', style: TextStyle(fontSize: 20)),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text('next', style: TextStyle(fontSize: 20)),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
