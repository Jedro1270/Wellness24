import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/common_pages/chat/chat_bubble.dart';

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
            Expanded(
              child: ListView(
                children: [
                  ChatBubble(
                    isMe: true,
                  ),
                  ChatBubble(
                    isMe: false,
                  )
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
