import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/common/editable_text.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

class AddMedicalRecord extends StatefulWidget {
  @override
  _AddMedicalRecordState createState() => _AddMedicalRecordState();
}

class _AddMedicalRecordState extends State<AddMedicalRecord> {
  bool editable = true;
  Doctor currentDoctor;
  File _image;
  final picker = ImagePicker();

  initializeDoctor(String uid) async {
    DatabaseService database = DatabaseService(uid: uid);
    Doctor doctor = await database.getDoctor(uid);

    setState(() {
      currentDoctor = doctor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    initializeDoctor(user.uid);

    Future getImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected');
        }
      });
    }

    clearImage() {
      setState(() {
        _image = null;
      });
    }

    final FirebaseStorage storage =
        FirebaseStorage(storageBucket: 'gs://wellness24-95ff9.appspot.com');
    Future<String> uploadPic(_image) async {
      String fileName = basename(_image.path);
      // String filePath = 'images/${DateTime.now()}.jpg';
      // uploadTask = storage.ref().child(filePath).putFile(file)
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String _url = await taskSnapshot.ref.getDownloadURL();
      // String url = _url.toString();
      print(_url);
      return _url;
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Medical Records',
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              print('Notif button clicked');
            },
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: EditableTextField(
                      isEditing: editable,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    height: 30.0,
                  ),
                  Divider(thickness: 2, height: 20.0),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () => getImage(),
                          child: Text(
                            'Upload File',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              fontFamily: 'ShipporiMincho',
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          width: 400,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              _image == null
                                  ? Icon(
                                      Icons.image,
                                      size: 50,
                                    )
                                  : _image
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(thickness: 2, height: 30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Notes',
                          style: TextStyle(
                              fontFamily: 'ShipporiMincho',
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 1,
                          ),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Add notes',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () => uploadPic(_image),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              fontFamily: 'ShipporiMincho',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
