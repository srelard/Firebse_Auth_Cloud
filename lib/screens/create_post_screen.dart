import 'dart:io';

import 'package:firebase_backend/config/config.dart';
import 'package:firebase_backend/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  _showSelectImageDialog() {
    return Platform.isIOS ? _iosBottomSheet() : _androidDialog();
  }

  _iosBottomSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text("Add Photo"),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text("Take photo"),
              onPressed: () => print("Camera"),
            ),
            CupertinoActionSheetAction(
              child: Text("Choose From Gallery"),
              onPressed: () => print("Camera"),
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
        );
      },
    );
  }

  _androidDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Add Photo'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Take Photo'),
              onPressed: () => print("_handleImage(ImageSource.camera)"),
            ),
            SimpleDialogOption(
              child: Text('Choose From Gallery'),
              onPressed: () => print("_handleImage(ImageSource.gallery)"),
            ),
            SimpleDialogOption(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Palette.appBar,
        title: Text(
          "Create Post",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () => print("Add"))
        ],
      ),
      body: Column(
        children: <Widget>[
          GestureDetector(
            onTap: _showSelectImageDialog,
            child: Container(
                height: width,
                width: width,
                color: Colors.grey[300],
                child:
                    Icon(Icons.add_a_photo, color: Colors.white70, size: 150)),
          )
        ],
      ),
    );
  }
}
