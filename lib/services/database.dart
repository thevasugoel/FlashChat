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
}
