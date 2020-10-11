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
}
