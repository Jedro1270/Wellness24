import 'dart:async';

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
  final String partnerName;
  final String currentUid;

  ChatRoom({this.title, this.partnerUid, this.currentUid, this.partnerName});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  DatabaseService database;

  Widget loadMore = Container();

  int messagesLimit = 20;
  bool screenInitialized = false;

  List items = [];

  @override
  void initState() {
    database = DatabaseService(uid: widget.currentUid);

    _scrollController.addListener(() {
      double currentScroll = _scrollController.position.pixels;

      if (currentScroll == 0) {
        setState(() {
          loadMore = InkWell(
            onTap: () {
              setState(() {
                messagesLimit += 20;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Load More'),
            ),
          );
        });
      } else {
        setState(() {
          loadMore = Container();
        });
      }
    });

    super.initState();
  }

  bool isReciever(DocumentSnapshot message) {
    return message.data['receiverUid'] == widget.currentUid &&
        message.data['senderUid'] == widget.partnerUid;
  }

  bool isSender(DocumentSnapshot message) {
    return message.data['receiverUid'] == widget.partnerUid &&
        message.data['senderUid'] == widget.currentUid;
  }

  @override
  Widget build(BuildContext context) {
    if (screenInitialized == false && _scrollController.positions.length > 0) {
      Timer(Duration(milliseconds: 500), () {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            curve: Curves.easeOut, duration: const Duration(milliseconds: 250));
      });

      setState(() {
        screenInitialized = true;
      });
    }

    return Scaffold(
        appBar: CustomAppBar(title: widget.title),
        body: StreamBuilder(
            stream: database.messages
                .orderBy('dateCreated', descending: true)
                .limit(messagesLimit)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData == false) {
                return Loading();
              }

              items = snapshot.data.documents
                  .where((message) => isSender(message) || isReciever(message))
                  .map((message) {
                    Message currentMessage = Message(
                        content: message.data['content'],
                        dateCreated: message.data['dateCreated'].toDate(),
                        receiverUid: message.data['receiverUid'],
                        senderUid: message.data['senderUid']);

                    return ChatBubble(
                        isMe: currentMessage.senderUid == widget.currentUid,
                        message: currentMessage);
                  })
                  .toList()
                  .reversed
                  .toList();

              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    loadMore,
                    Expanded(
                      child: items.isEmpty
                          ? Center(
                              child: Text(
                                'Start a conversation with ${widget.partnerName}!',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          : ListView(
                              key: Key('Message'),
                              controller: _scrollController,
                              children: items),
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
                              key: Key('textFieldKey'),
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
                              key: Key('SendBtn'),
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
