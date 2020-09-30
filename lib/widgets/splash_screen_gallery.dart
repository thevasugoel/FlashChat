import 'package:flutter/material.dart';

class SplashScreenGallery extends StatelessWidget {
  const SplashScreenGallery({
    Key key,
    @required this.animation,
    @required this.animation3,
    @required this.animation2,
    @required this.animation4,
  }) : super(key: key);

  final Animation<double> animation;
  final Animation<double> animation3;
  final Animation<double> animation2;
  final Animation<double> animation4;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    FadeTransition(
                      opacity: animation,
                      child: Image.asset(
                        'images/1.png',
                        scale: 6,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    FadeTransition(
                      opacity: animation3,
                      child: Image.asset(
                        'images/3.png',
                        scale: 7,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  FadeTransition(
                    opacity: animation2,
                    child: Image.asset(
                      'images/2.png',
                      scale: 6,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  FadeTransition(
                    opacity: animation4,
                    child: Image.asset(
                      'images/4.png',
                      scale: 6,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
