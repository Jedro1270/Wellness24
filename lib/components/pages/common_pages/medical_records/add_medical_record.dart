import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/common/editable_title.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AddMedicalRecord extends StatefulWidget {
  final String title;
  final String imageurl;

  AddMedicalRecord({this.title = 'Title', this.imageurl});

  @override
  _AddMedicalRecordState createState() => _AddMedicalRecordState();
}

class _AddMedicalRecordState extends State<AddMedicalRecord> {
  TextEditingController noteController = TextEditingController();
  DatabaseService database;

  bool editable = true;
  Doctor currentDoctor;
  PickedFile _imageFile;
  final ImagePicker _imagePicker = ImagePicker();

  String newTitle;
  String imagePath;
  dynamic imageUrl;

  initializeDoctor(String uid) async {
    database = DatabaseService(uid: uid);
    Doctor doctor = await database.getDoctor(uid);

    if (mounted) {
      // setState if it is not yet disposed
      setState(() {
        currentDoctor = doctor;
      });
    }
  }

  @override
  void initState() {
    newTitle = widget.title;
    imageUrl = widget.imageurl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    initializeDoctor(user.uid);

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
                    padding: EdgeInsets.all(10),
                    child: EditableTitle(
                      initialText: newTitle,
                      onSubmitted: (newValue) {
                        setState(() {
                          newTitle = newValue;
                        });
                      },
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
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: ((builder) => optionView()));
                          },
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
                              Image(
                                image: _imageFile == null
                                    ? AssetImage('assets/image.png')
                                    : FileImage(
                                        File(_imageFile.path),
                                      ),
                              ),
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
                            key: Key('Notes'),
                            controller: noteController,
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
                          // onPressed: () => uploadPhoto(this.context),
                          onPressed: () {
                            database.uploadMedicalRecord(
                                newTitle, noteController.text, imageUrl);
                            print('image url: $imageUrl');
                            print("File Uploaded");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('File Uploaded'),
                            ));
                          },
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

  Widget optionView() {
    return Container(
      margin: EdgeInsets.all(15.0),
      height: 200,
      child: Column(children: [
        Text(
          'Select Picture',
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
            uploadPhoto(this.context);
            print('Done');
            Navigator.pop(this.context);
          },
          child: Text('Done', style: TextStyle()),
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
    String fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);

    //converts pickedFile to file
    File convertedFile = File(_imageFile.path);

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(convertedFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String _url = await taskSnapshot.ref.getDownloadURL();
    
    setState(() {
      imageUrl = _url;
      print(imageUrl);
    });
  }
}
