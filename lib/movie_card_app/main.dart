import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ApiCall());

class ApiCall extends StatelessWidget {
  const ApiCall({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(),
      home: MovieScreen(),
    );
  }
}

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  String get movie =>
      '[ { "title": "Mission: Impossible – Fallout", "year": 2018, "image": "https://www.gstatic'
      '.com/tv/thumb/v22vodart/13492451/p13492451_v_v8_ad.jpg", "release": "July 27, 2018" }, { "title": "Incredibles'
      ' 2", "year": 2018, "image": "https://www.gstatic.com/tv/thumb/v22vodart/13446354/p13446354_v_v8_ay.jpg", "rele'
      'ase": "June 15, 2018" }, { "title": "Once Upon a Time in Hollywood", "year": 2019, "image": "https://www'
      '.gstatic.com/tv/thumb/v22vodart/15226224/p15226224_v_v8_ad.jpg", "release": "July 26, 2019" }, { "title": "Joh'
      'n Henry", "year": 2020, "image": "https://www.gstatic.com/tv/thumb/v22vodart/17733489/p17733489_v_v8_aa.jpg", '
      '"release": "January 24, 2020" }, { "title": "Timmy Failure: Mistakes Were Made", "year": 2020, "image": "https'
      '://miro.medium.com/max/500/0*7ZUeYQc4vUx_i1qQ.jpg", "release": "January 25, 2020" }, { "title": "Avengers: '
      'Endgame", "year": 2019, "image": "https://www.gstatic.com/tv/thumb/v22vodart/15366809/p15366809_v_v8_af.jpg", '
      '"release": "April 26, 2019" }, { "title": "Joker", "year": 2019, "image": "https://pbs.twimg'
      '.com/media/EDEsh0gU4AUTO3P?format=jpg&name=900x900", "release": "October 4, 2019" }, { "title": "Spider-Man: '
      'Into the Spider-Verse", "year": 2018, "image": "https://www.gstatic'
      '.com/tv/thumb/v22vodart/14939602/p14939602_v_v8_ae.jpg", "release": "December 14, 2018" }, { "title": "First '
      'Man", "year": 2018, "image": "https://www.gstatic.com/tv/thumb/v22vodart/15398283/p15398283_v_v8_ae.jpg", "rel'
      'ease": "October 10, 2018" }, { "title": "Avatar", "year": 2009, "image": "https://images-na.ssl-images-amazon.com/images/I/61jFTTf9RBL._AC_SL1230_.jpg",'
      ' "release": "December 18, 2009" } ]';

  List<Movie> _movies = [];

  void _getMovies() {
    final response = jsonDecode(movie) as List;
    setState(
        () => _movies = response.map((json) => Movie.toObject(json)).toList());
  }

  @override
  void initState() {
    super.initState();
    _getMovies();
  }

  @override
  Widget build(context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 50, bottom: 5),
            child: Text('Movies',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                GridView.builder(
                  padding: const EdgeInsets.only(top: 30),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: size.width > 600
                          ? size.width > 900
                              ? 4
                              : 3
                          : 2,
                      childAspectRatio: 0.7),
                  itemBuilder: (context, index) {
                    final movie = _movies[index];
                    final color = ColorGenerator.color;
                    return InkResponse(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => DetailsScreen(
                                movie: movie,
                                color: color,
                              ))),
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: color,
                                blurRadius: 70,
                                spreadRadius: -25,
                                offset: const Offset(0, 20),
                              ),
                              BoxShadow(
                                color: Colors.black.withAlpha(0x80),
                                blurRadius: 30,
                                spreadRadius: -20,
                                offset: const Offset(0, 50),
                              )
                            ]),
                        child: Hero(
                          tag: 'image_${movie.title}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            clipBehavior: Clip.antiAlias,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Opacity(
                                    opacity: 0.99,
                                    child: Image.network(movie.image,
                                        fit: BoxFit.cover)),
                                Opacity(
                                    opacity: 0.6,
                                    child: Container(color: Colors.black)),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(movie.title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _movies.length,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          colors: [Colors.white, Colors.white.withAlpha(0x00)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsScreen extends StatefulWidget {
  final Movie movie;
  final Color color;

  const DetailsScreen({super.key, required this.movie, required this.color});

  @override
  // ignore: library_private_types_in_public_api
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final aspect = size.height * 0.75;
    return Material(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                child: Container(
                  width: size.width,
                  height: size.height,
                  color: widget.color.withAlpha(0x30),
                ),
              ),
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.8,
              child: ClipPath(
                clipper: HeaderClipper(),
                child: Container(
                  color: widget.color,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 40),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: aspect * 0.66,
                    height: aspect,
                    margin: const EdgeInsets.only(left: 30, top: 70),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: widget.color,
                          blurRadius: 300,
                          spreadRadius: 20,
                          offset: const Offset(0, 100),
                        ),
                      ],
                    ),
                    child: HoverCard(
                      builder: (context, hover) {
                        return Hero(
                          tag: 'image_${widget.movie.title}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(widget.movie.image,
                                fit: BoxFit.cover),
                          ),
                        );
                      },
                      depth: 0,
                      depthColor: Colors.transparent,
                      shadow: BoxShadow(
                        color: Colors.black.withAlpha(0x80),
                        blurRadius: 30,
                        spreadRadius: -20,
                        offset: const Offset(0, 50),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 30, top: 70),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.movie.title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child:
                    const Icon(Icons.arrow_back, size: 28, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.9, size.width, size.height * 0.4);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class Movie {
  final String title;
  final String image;

  Movie(this.title, this.image);

  factory Movie.toObject(Map<String, dynamic> json) =>
      Movie(json['title'], json['image']);

  Map<String, dynamic> toMap() => {'title': title, 'image': image};
}

class ColorGenerator {
  static Random random = Random();

  static Color get color => Color.fromARGB(
      255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
}

class HoverCard extends StatefulWidget {
  final Widget Function(BuildContext context, bool isHovered) builder;
  final double depth;
  final Color depthColor;
  final BoxShadow shadow;
  final GestureTapCallback onTap;

  const HoverCard({
    super.key,
    required this.builder,
    required this.onTap,
    this.depth = 0,
    this.depthColor = const Color(0xFF424242),
    this.shadow = const BoxShadow(
      offset: Offset(0, 60),
      color: Color.fromARGB(120, 0, 0, 0),
      blurRadius: 22,
      spreadRadius: -20,
    ),
  });

  @override
  HoverCardState createState() => HoverCardState();
}

class HoverCardState extends State<HoverCard>
    with SingleTickerProviderStateMixin {
  double localX = 0;
  double localY = 0;
  bool defaultPosition = true;
  bool isHover = false;
  late AnimationController animationController;
  late Animation<FractionalOffset> animation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _setupAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  void _resetAnimation(Size size, Offset offset) {
    animationController.addListener(_updatePosition);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => defaultPosition = true);
        animationController.removeListener(_updatePosition);
        animationController.reverse();
      }
    });
  }

  void _updatePosition() {
    setState(() {
      localX = animation.value.dx;
      localY = animation.value.dy;
    });
  }

  void reset(Size size) {
    _resetAnimation(size, const Offset(0, 0));
    _updatePosition();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, dimens) {
        final size = Size(dimens.maxWidth, dimens.maxHeight);
        double percentageX = (localX / size.width) * 100;
        double percentageY = (localY / size.height) * 100;
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(defaultPosition ? 0 : (0.3 * (percentageY / 50) + -0.3))
            ..rotateY(defaultPosition ? 0 : (-0.3 * (percentageX / 50) + 0.3)),
          alignment: FractionalOffset.center,
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: widget.depthColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [widget.shadow],
            ),
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  defaultPosition = false;
                  if (details.localPosition.dx > 0 &&
                      details.localPosition.dy > 0) {
                    if (details.localPosition.dx < size.width &&
                        details.localPosition.dy < size.height) {
                      localX = details.localPosition.dx;
                      localY = details.localPosition.dy;
                    }
                  }
                });
              },
              onPanEnd: (_) {
                setState(() {
                  isHover = true;
                  defaultPosition = false;
                });
                _resetAnimation(size, Offset(localX, localY));
                animationController.forward();
              },
              onPanCancel: () {
                setState(() {
                  isHover = false;
                });
                _resetAnimation(size, Offset(localX, localY));
                animationController.forward();
              },
              onTap: widget.onTap,
              child: MouseRegion(
                onEnter: (_) {
                  if (mounted) {
                    setState(() {
                      isHover = true;
                      defaultPosition = false;
                    });
                  }
                },
                onExit: (_) {
                  if (mounted) {
                    setState(() {
                      isHover = false;
                    });
                  }
                  _resetAnimation(size, Offset(localX, localY));
                  animationController.forward();
                },
                onHover: (details) {
                  RenderObject? renderObject = context.findRenderObject();
                  RenderBox? box = renderObject as RenderBox?;
                  final offset = box?.globalToLocal(details.localPosition);
                  if (mounted) {
                    setState(() {
                      defaultPosition = false;
                      if (offset != null && offset.dx > 0 && offset.dy > 0) {
                        if (offset.dx < size.width * 1.5 && offset.dy > 0) {
                          localX = offset.dx;
                          localY = offset.dy;
                        }
                      }
                    });
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: widget.depthColor,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Transform(
                            transform: Matrix4.identity()
                              ..translate(
                                  defaultPosition
                                      ? 0.0
                                      : (widget.depth * (percentageX / 50) +
                                          -widget.depth),
                                  defaultPosition
                                      ? 0.0
                                      : (widget.depth * (percentageY / 50) +
                                          -widget.depth),
                                  0.0),
                            alignment: FractionalOffset.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: widget.builder(context, isHover),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Transform(
                              transform: Matrix4.translationValues(
                                (size.width - 50) - localX,
                                (size.height - 50) - localY,
                                0.0,
                              ),
                              child: AnimatedOpacity(
                                opacity: defaultPosition ? 0 : 0.99,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.22),
                                      blurRadius: 100,
                                      spreadRadius: 40,
                                    )
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
