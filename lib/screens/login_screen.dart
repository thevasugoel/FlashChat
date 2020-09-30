import 'package:flutter/material.dart';
import 'package:we_chat/screens/chat_room.dart';
import 'package:we_chat/screens/registration_screen.dart';
import 'package:we_chat/services/auth.dart';
import 'package:we_chat/widgets/login_lines.dart';
import 'dart:async';

import 'package:we_chat/widgets/splash_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int starter = 1;
  Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(
        Duration(milliseconds: 2000), (Timer t) => checkForNewSharedLists());
  }

  void checkForNewSharedLists() {
    if (starter == 3) {
      starter = 0;
    }
    setState(() {
      starter += 1;
    });
  }

  bool _iconPressed = true;

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;
  signIn() {
    setState(() {
      isLoading = true;
      print(email.text);
      print(password.text);
    });

    AuthMethods().signInWithEmail(email.text, password.text).then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Color(0xff393EB3),
      ),
      backgroundColor: Color(0xffE7E7E7),
      body: isLoading == true
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Column(
              children: [
                Flexible(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: Center(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    child: child, scale: animation);
                              },
                              child: Image.asset(
                                'images/${starter + 1}.png',
                                scale: 3,
                                key: ValueKey<int>(starter),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.all(30.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: email,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          icon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: password,
                        obscureText: _iconPressed ? true : false,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _iconPressed = !_iconPressed;
                              });
                            },
                            icon: _iconPressed
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),
                          hintText: 'Password',
                          icon: Icon(Icons.lock),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SplashButton(
                        title: 'Login In',
                        onpressed: () {
                          signIn();
                        },
                        color: Color(0xffFF4373),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      LoginLines(),
                      SizedBox(
                        height: 10,
                      ),
                      SplashButton(
                        title: "Register",
                        onpressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()));
                        },
                        color: Color(0xff393EB3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
