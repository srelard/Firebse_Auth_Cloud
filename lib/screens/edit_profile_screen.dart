import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_backend/config/config.dart';
import 'package:firebase_backend/models/user_model.dart';
import 'package:firebase_backend/services/database_service.dart';
import 'package:firebase_backend/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  final Function updateUser;

  EditProfileScreen({this.user, this.updateUser});
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  File _profileImage; //before File
  String _name = "";
  String _bio = "";
  final _picker = ImagePicker(); //added

  @override
  initState() {
    super.initState();
    _name = widget.user.name;
    _bio = widget.user.bio;
  }

  _handleImageFromGallery() async {
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  _displayProfileImage() {
    //No new profile image
    if (_profileImage == null) {
      //No existing profile image
      if (widget.user.profileImageUrl.isEmpty) {
        //Display placeholder
        return AssetImage("assets/images/empty_avatar_female.png");
      } else {
        //user profile image exists
        return CachedNetworkImageProvider(widget.user.profileImageUrl);
      }
    } else {
      //New profile image
      return FileImage(_profileImage);
    }
  }

  _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // Update User in DB
      String _profileImageUrl = "";
      if (_profileImageUrl = null) {
        _profileImageUrl = widget.user.profileImageUrl;
      } else {
        _profileImageUrl = await StorageService.uploadUserProfileImage(
            widget.user.profileImageUrl, _profileImage);
      }

      User user = User(
        id: widget.user.id,
        name: _name,
        profileImageUrl: _profileImageUrl,
        bio: _bio,
      );
      //DB update
      DatabaseService.updateUser(user);
      widget.updateUser(user);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.appBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Palette.appBar,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    backgroundImage: _displayProfileImage(),
                  ),
                  FlatButton(
                    onPressed: () => _handleImageFromGallery,
                    child: Text(
                      "Change Image",
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    initialValue: _name,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: 30),
                      labelText: "Name",
                    ),
                    validator: (input) => input.trim().length < 1
                        ? "Please enter a valid name"
                        : null,
                    onSaved: (input) => _name = input,
                  ),
                  TextFormField(
                    initialValue: _bio,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      icon: Icon(Icons.book, size: 30),
                      labelText: "Bio",
                    ),
                    validator: (input) => input.trim().length > 150
                        ? "Please enter a bio less than 150 characters"
                        : null,
                    onSaved: (input) => _bio = input,
                  ),
                  Container(
                    margin: EdgeInsets.all(40),
                    height: 40,
                    width: 250,
                    child: FlatButton(
                      onPressed: _submit,
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text(
                        "Save Profile",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
