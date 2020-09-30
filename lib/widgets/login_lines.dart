import 'package:flutter/material.dart';

class LoginLines extends StatelessWidget {
  const LoginLines({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 1.0,
          width: MediaQuery.of(context).size.width * 0.25,
          color: Colors.black,
          child: Text(
            'data',
            style: TextStyle(color: Colors.black),
          ),
        ),
        Text(
          "  OR  ",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black54),
        ),
        Container(
          height: 1.0,
          width: MediaQuery.of(context).size.width * 0.25,
          color: Colors.black,
          child: Text(
            'data',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
