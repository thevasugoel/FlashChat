import 'package:flutter/material.dart';
import 'package:we_chat/models/helperFunction.dart';
import 'package:we_chat/screens/chat_room.dart';
import 'package:we_chat/screens/search_user.dart';
import 'package:we_chat/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  bool isLoggedIn = false;
  getLoggedInState() async {
    await HelperFunctions.getUserLoggedIn().then((value) {
      setState(() {
        isLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: isLoggedIn ? ChatRoom() : SplashScreen(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}
