import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_backend/models/post_model.dart';
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

  static void createPost(Post post) {
    postsRef.doc(post.authorId).collection("usersPosts").add({
      "imageUrl": post.imageUrl,
      "caption": post.caption,
      "likes": post.likes,
      "authorId": post.authorId,
      "timestamp": post.timestamp,
    });
  }

  static void followUser({String currentUserId, String userId}) {
    //Add user to current users following collection
    followingRef
        .doc(currentUserId)
        .collection("userFollowing")
        .doc(userId)
        .set({"foo": 'bar'});
    // Add current user to users followers collection
    followersRef
        .doc(userId)
        .collection("userFollowers")
        .doc(currentUserId)
        .set({"foo": 'bar'});
  }

  static void unfollowUser({String currentUserId, String userId}) {
    //Remove user from current users following collection
    followingRef
        .doc(currentUserId)
        .collection("userFollowing")
        .doc(userId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    // Remove current user from users followers collection
    followersRef
        .doc(userId)
        .collection("userFollowers")
        .doc(currentUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  static Future<bool> isFollowingUser(
      {String currentUserId, String userId}) async {
    DocumentSnapshot followingDoc = await followersRef
        .doc(userId)
        .collection("userFollowers")
        .doc(currentUserId)
        .get();
    return followingDoc.exists;
  }

  static Future<int> numFollowing(String userId) async {
    QuerySnapshot followingSnapshot =
        await followingRef.doc(userId).collection("userFollowing").get();
    return followingSnapshot.docs.length;
  }

  static Future<int> numFollowers(String userId) async {
    QuerySnapshot followersSnapshot =
        await followersRef.doc(userId).collection("userFollowers").get();
    return followersSnapshot.docs.length;
  }
}
