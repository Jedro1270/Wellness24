import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wellness24/components/common/loading_animation.dart';
import 'package:wellness24/services/auth_service.dart';
import 'package:path/path.dart';
import 'package:wellness24/services/database.dart';

class NavBar extends StatefulWidget {
  final String uid;
  final String profilePictureUrl;
  final String name;
  final String email;

  NavBar({this.name, this.email, this.uid, this.profilePictureUrl});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final AuthService auth = AuthService();
  DatabaseService database;

  bool _loading = false;

  PickedFile _imageFile;
  final ImagePicker _imagePicker = ImagePicker();
  String imagePath;

  @override
  void initState() {
    print(widget.name);
    print(widget.profilePictureUrl);

    database = DatabaseService(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: _loading
            ? Loading()
            : ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(widget.name),
                    accountEmail: Text(widget.email),
                    currentAccountPicture: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: ((builder) => optionView(context)));
                      },
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Container(
                            height: 120,
                            width: 120,
                            child: widget.profilePictureUrl == null
                                ? Image(
                                    image: _imageFile == null
                                        ? AssetImage('assets/logo.jpg')
                                        : FileImage(
                                            File(_imageFile.path),
                                          ),
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.fill,
                                  )
                                : Image.network(
                                    widget.profilePictureUrl,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.settings_outlined, color: Colors.blueAccent),
                    title: Text('Settings'),
                    onTap: () => print("Settings"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.blueAccent),
                    title: Text('Log out'),
                    onTap: () async {
                      await auth.signOut();
                    },
                  ),
                ],
              ));
  }

  Widget optionView(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      height: 200,
      child: Column(children: [
        Text(
          'Choose your Profile',
          style: TextStyle(
            fontFamily: "ShipporiMincho",
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        ),
        Divider(height: 40, color: Colors.transparent),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
                onPressed: () {
                  print('open camera');
                  updatePhoto(ImageSource.camera);
                },
                child: Column(
                  children: [
                    Icon(Icons.camera_alt_sharp),
                    Text('Camera',
                        style: TextStyle(
                          fontFamily: "ShipporiMincho",
                          fontSize: 18,
                        )),
                  ],
                )),
            SizedBox(width: 50),
            MaterialButton(
                onPressed: () {
                  print('open gallery');
                  updatePhoto(ImageSource.gallery);
                },
                child: Column(
                  children: [
                    Icon(Icons.image),
                    Text('Gallery',
                        style: TextStyle(
                          fontFamily: "ShipporiMincho",
                          fontSize: 18,
                        )),
                  ],
                )),
          ],
        ),
        Divider(height: 25, color: Colors.transparent),
        MaterialButton(
          onPressed: () {
            print('Save Photo');
            Navigator.pop(context);
            uploadPhoto(this.context);
          },
          child: Text('Save Photo', style: TextStyle()),
          color: Colors.blueAccent[400],
          textColor: Colors.black,
        )
      ]),
    );
  }

  void updatePhoto(ImageSource source) async {
    final pickedFile = await _imagePicker.getImage(source: source);

    setState(() {
      _imageFile = pickedFile;
      print(_imageFile.path);
    });
  }

  void uploadPhoto(BuildContext context) async {
    setState(() {
      _loading = true;
    });

    String fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);

    //converts pickedFile to file
    File convertedFile = File(_imageFile.path);

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(convertedFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String _url = await taskSnapshot.ref.getDownloadURL();

    await database.updateProfilePicture(_url);

    setState(() {
      _loading = false;
    });
  }
}
