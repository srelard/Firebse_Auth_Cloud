import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_backend/models/user_model.dart';
import 'package:firebase_backend/utilities/constants.dart';

class DatabaseService {
  static void updateUser(User user) {
    usersRef.doc(user.id).update({
      "name": user.name,
      "profileImageUrl": user.profileImageUrl,
      "bio": user.bio
    });
  }

  static Future<QuerySnapshot> searchUsers(String name) {
    Future<QuerySnapshot> users =
        usersRef.where("name", isGreaterThanOrEqualTo: name).get();
    return users;
  }
}
