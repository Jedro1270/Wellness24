import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/common/loading_animation.dart';
import 'package:wellness24/components/pages/common_pages/chat/chat_bubble.dart';
import 'package:wellness24/models/message.dart';
import 'package:wellness24/services/database.dart';

class ChatRoom extends StatefulWidget {
  final String title;
  final String partnerUid;
  final String currentUid;

  ChatRoom({this.title, this.partnerUid, this.currentUid});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  var messageController = TextEditingController();
  DatabaseService database;

  @override
  void initState() {
    database = DatabaseService(uid: widget.currentUid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: widget.title),
        body: StreamBuilder(
            stream: database.messages.orderBy('dateCreated').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData == false) {
                return Loading();
              }

              return Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                          children: snapshot.data.documents
                              .where((message) =>
                                  message.data['recieverUid'] ==
                                      widget.currentUid ||
                                  message.data['recieverUid'] ==
                                      widget.partnerUid ||
                                  message.data['senderUid'] == widget.currentUid ||
                                  message.data['senderUid'] == widget.partnerUid)
                              .map((message) {
                        Message currentMessage = Message(
                            content: message.data['content'],
                            dateCreated: message.data['dateCreated'].toDate(),
                            receiverUid: message.data['receiverUid'],
                            senderUid: message.data['senderUid']);

                        return ChatBubble(
                            isMe: currentMessage.senderUid == widget.currentUid,
                            message: currentMessage);
                      }).toList()),
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
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
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
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                      borderSide:
                                          BorderSide(color: Colors.grey[700]))),
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                setState(() {
                                  database.uploadMessage(
                                      widget.currentUid,
                                      widget.partnerUid,
                                      messageController.text);

                                  messageController.clear();
                                });
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
