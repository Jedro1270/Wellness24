import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wellness24/models/message.dart';

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final Message message;

  ChatBubble({this.isMe, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isMe
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: <Widget>[
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.80,
                                ),
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.blue[300],
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  message.content,
                                ),
                              ),
                              Text(
                                DateFormat.yMd()
                                    .add_jm()
                                    .format(message.dateCreated),
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(width: 5.0),
                // CircleAvatar(
                //   radius: 25.0,
                //   backgroundColor: Colors.grey,
                //   child: ClipOval(
                //     child: SizedBox(
                //         width: 100.0,
                //         height: 100.0,
                //         child: Image(
                //             image: AssetImage('assets/doctor_sample.png'))),
                //   ),
                // ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(width: 5.0),
                // CircleAvatar(
                //   radius: 25.0,
                //   backgroundColor: Colors.grey,
                //   child: ClipOval(
                //     child: SizedBox(
                //         width: 100.0,
                //         height: 100.0,
                //         child: Image(
                //             image: AssetImage('assets/sample-patient.jpg'))),
                //   ),
                // ),
                SizedBox(width: 3.0),
                Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.80,
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Text(message.content),
                      ),
                      Text(
                        DateFormat.yMd().add_jm().format(message.dateCreated),
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
