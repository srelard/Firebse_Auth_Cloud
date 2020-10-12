import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_backend/config/config.dart';
import 'package:firebase_backend/models/user_model.dart';
import 'package:firebase_backend/screens/screens.dart';
import 'package:firebase_backend/utilities/constants.dart';
import 'package:firebase_backend/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String userID;

  ProfileScreen({this.userID});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User _profileUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Palette.appBackground,
      body: FutureBuilder(
        future: usersRef.doc(widget.userID).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // print(snapshot.data["name"]);
          User user = User.fromDoc(snapshot.data);
          //print(user.email);
          return ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: user.profileImageUrl.isEmpty
                          ? AssetImage("assets/images/empty_avatar_men.png")
                          : CachedNetworkImageProvider(user.profileImageUrl),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "600",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'posts',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "800",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'followers',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "777",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'following',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: 200,
                            child: FlatButton(
                                onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => EditProfileScreen(
                                          user: user,
                                          updateUser: (User updateUser) {
                                            // Trigger state rebuild after editing profile
                                            User updatedUser = User(
                                              id: updateUser.id,
                                              name: updateUser.name,
                                              email: user.email,
                                              profileImageUrl:
                                                  updateUser.profileImageUrl,
                                              bio: updateUser.bio,
                                            );
                                            setState(() =>
                                                _profileUser = updatedUser);
                                          },
                                        ),
                                      ),
                                    ),
                                textColor: Colors.white,
                                color: Colors.blue,
                                child: Text("Edit Profile",
                                    style: TextStyle(fontSize: 18))),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(user.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Container(
                      height: 80,
                      child: Text(user.bio, style: TextStyle(fontSize: 15)),
                    ),
                    Divider(),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
