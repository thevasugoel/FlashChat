import 'package:flutter/material.dart';

class SplashButton extends StatelessWidget {
  final String title;
  final Function onpressed;
  final Color color;

  SplashButton({this.title, this.onpressed, this.color});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: onpressed,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
          width: MediaQuery.of(context).size.width * 0.7,
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ));
  }
}
