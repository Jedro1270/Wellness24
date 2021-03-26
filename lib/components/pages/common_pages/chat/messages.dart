import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/common_pages/chat/chat_room.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Messages',
      ),
      body: Container(
          child: ListView(children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatRoom()));
          },
          child: Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.grey,
                  child: ClipOval(
                    child: SizedBox(
                        width: 100.0,
                        height: 100.0,
                        child: Image(
                            image: AssetImage('assets/sample-patient.jpg'))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Elim C. Abagat",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 15.0,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(thickness: 2),
      ])),
    );
  }
}
