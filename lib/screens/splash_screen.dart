import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/screens/login_screen.dart';
import 'package:we_chat/screens/registration_screen.dart';
import 'package:we_chat/widgets/login_lines.dart';
import 'package:we_chat/widgets/splash_button.dart';
import 'package:we_chat/widgets/splash_screen_gallery.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  AnimationController controller2;
  Animation<double> animation2;
  AnimationController controller3;
  Animation<double> animation3;
  AnimationController controller4;
  Animation<double> animation4;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller2 = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    animation2 = CurvedAnimation(parent: controller2, curve: Curves.easeIn);
    controller3 = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    animation3 = CurvedAnimation(parent: controller3, curve: Curves.easeIn);
    controller4 = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    animation4 = CurvedAnimation(parent: controller4, curve: Curves.easeIn);
    controller.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller2.forward();
        animation2.addStatusListener((status2) {
          if (status2 == AnimationStatus.completed) {
            controller3.forward();
            animation3.addStatusListener((status3) {
              if (status3 == AnimationStatus.completed) {
                controller4.forward();
              }
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = AssetImage('images/bg.png');
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: assetImage, fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 60.0,
                ),
                child: TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 500),
                  text: [
                    'Flash Chat',
                  ],
                  textStyle: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
              ),
              SplashScreenGallery(
                  animation: animation,
                  animation3: animation3,
                  animation2: animation2,
                  animation4: animation4),
              Column(
                children: [
                  SplashButton(
                    title: "Login",
                    onpressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    color: Color(0xffFF4373),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  LoginLines(),
                  SizedBox(
                    height: 8,
                  ),
                  SplashButton(
                    title: "Regsiter",
                    onpressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationScreen()));
                    },
                    color: Color(0xff393EB3),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
