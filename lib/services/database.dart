import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  void uploadUserInfo(Map userMap) {
    // ignore: deprecated_member_use
    Firestore.instance.collection("users").add(userMap);
  }

  searchUserInfo(String name) async {
    // ignore: deprecated_member_use
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: name)
        .getDocuments();
  }

  searchUserEmail(String email) async {
    // ignore: deprecated_member_use
    return await Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments();
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }
}
