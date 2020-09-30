import 'package:flutter/material.dart';
import 'package:we_chat/screens/chat_room.dart';
import 'package:we_chat/screens/login_screen.dart';
import 'package:we_chat/services/auth.dart';
import 'package:we_chat/services/database.dart';
import 'package:we_chat/widgets/login_lines.dart';
import 'dart:async';

import 'package:we_chat/widgets/splash_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String deviceToken;

  bool isLoading = false;
  void signUp() {
    setState(() {
      isLoading = true;
    });
    _firebaseMessaging.getToken().then((token) {
      setState(() {
        deviceToken = token;
        print(deviceToken);
      });
    });
    AuthMethods().signUpWithEmail(email.text, password.text).then((value) {
      Map<String, String> userInfoMap = {
        "name": name.text,
        "email": email.text,
        "device_token": deviceToken,
      };

      DatabaseMethods().uploadUserInfo(userInfoMap);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ChatRoom()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                          flex: 6,
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
                        onChanged: (value) {},
                        controller: name,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          icon: Icon(Icons.account_circle),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        onChanged: (value) {},
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
                        obscureText: _iconPressed ? true : false,
                        onChanged: (value) {},
                        controller: password,
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
                        title: "Register",
                        onpressed: () {
                          signUp();
                        },
                        color: Color(0xff393EB3),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      LoginLines(),
                      SizedBox(
                        height: 10,
                      ),
                      SplashButton(
                        title: 'Login In',
                        onpressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        color: Color(0xffFF4373),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
