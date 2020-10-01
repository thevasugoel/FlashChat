import 'package:flutter/material.dart';
import 'package:we_chat/models/constants.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${Constants.myName}'),
      ),
    );
  }
}
