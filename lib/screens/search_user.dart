import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/models/constants.dart';
import 'package:we_chat/models/helperFunction.dart';
import 'package:we_chat/screens/chat_screen.dart';
import 'package:we_chat/screens/login_screen.dart';
import 'package:we_chat/screens/splash_screen.dart';
import 'package:we_chat/services/auth.dart';
import 'package:we_chat/services/database.dart';

class SearchUser extends StatefulWidget {
  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  TextEditingController search = TextEditingController();
  QuerySnapshot searchSnapshot;
  int length;
  initiateSearch() {
    DatabaseMethods().searchUserInfo(search.text).then((value) {
      setState(() {
        searchSnapshot = value;
      });
    });
  }

  createChatRoom(String username) {
    print(Constants.myName);
    List<String> users = [username, Constants.myName];

    String chatRoomId = getChatRoomId(username, Constants.myName);

    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatroomId": chatRoomId,
    };
    DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ChatScreen()));
  }

  Widget SearchTile({String name, String email}) {
    return Container(
      color: Colors.black12,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              createChatRoom(name);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xffFF4373),
              ),
              child: Text(
                'Message',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Welcome Back'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                    onTap: () {
                      AuthMethods().signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SplashScreen()));
                    },
                    child: Icon(Icons.exit_to_app))),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            color: Colors.blue,
            child: Column(
              children: [
                Container(
                  child: TextField(
                    controller: search,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 17, color: Colors.white54),
                      hintText: 'Search By Name',
                      suffixIcon: IconButton(
                        onPressed: () {
                          initiateSearch();
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchSnapshot != null
                  ? SearchTile(
                      name: searchSnapshot.docs[0].data()["name"],
                      email: searchSnapshot.docs[0].data()["email"],
                    )
                  : Container();
            },
            itemCount: 1,
          ),
        ],
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
