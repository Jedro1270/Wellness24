import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  bool isMe;

  ChatBubble({this.isMe});
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
                                  'Good day Ms. Abagat. I\'m happy to inform you that your covid swab test result last March 9 2021 is negative. ',
                                ),
                              ),
                              Text(
                                DateTime.now().toString(),
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    // padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                    // decoration: BoxDecoration(
                    //     color: Colors.blue[300],
                    //     borderRadius: BorderRadius.circular(10)),
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
                            image: AssetImage('assets/doctor_sample.png'))),
                  ),
                ),
              ],
            )
          : Row(
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
                            image: AssetImage('assets/sample-patient.jpg'))),
                  ),
                ),
                SizedBox(width: 5.0),
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
                        child: Text(
                          'Hi Doc! Thank you so much. ',
                        ),
                      ),
                      Text(
                        DateTime.now().toString(),
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ),
                // Expanded(
                //   child: Container(
                //     height: 40,
                //     child: Text(
                //       'Hi Doc! Thank you so much. ',
                //     ),
                //     padding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
                //     decoration: BoxDecoration(
                //         color: Colors.grey[300],
                //         borderRadius: BorderRadius.circular(10)),
                //   ),
                // ),
              ],
            ),
    );
  }
}
