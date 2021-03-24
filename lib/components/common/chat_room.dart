import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Elim C. Abagat'),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 5.0),
                        Expanded(
                          child: Container(
                            height: 60,
                            child: Text(
                              'Good day Ms. Abagat. I\'m happy to inform you that your covid swab test result last March 9 2021 is negative.',
                            ),
                            padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                            decoration: BoxDecoration(
                                color: Colors.blue[300],
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Colors.grey,
                          child: ClipOval(
                            child: SizedBox(
                                width: 100.0,
                                height: 100.0,
                                child: Image(
                                    image: AssetImage(
                                        'assets/doctor_sample.png'))),
                          ),
                        ),
                        SizedBox(width: 5.0),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 5.0),
                        CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Colors.grey,
                          child: ClipOval(
                            child: SizedBox(
                                width: 100.0,
                                height: 100.0,
                                child: Image(
                                    image: AssetImage(
                                        'assets/sample-patient.jpg'))),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Expanded(
                          child: Container(
                            height: 40,
                            child: Text(
                              'Hi Doc! Thank you so much. ',
                            ),
                            padding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(width: 140.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              height: 48,
              margin: EdgeInsets.all(4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      controller: messageController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          hintText: "Type here...",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontFamily: "quicksand_light",
                              fontWeight: FontWeight.bold),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(color: Colors.grey[700]))),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.send), onPressed: () {})
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
