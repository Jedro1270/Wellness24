import 'package:flutter/material.dart';

class ViewRequest extends StatefulWidget {
  @override
  _ViewRequestState createState() => _ViewRequestState();
}

class _ViewRequestState extends State<ViewRequest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            height: 105,
            child: Card(
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(15.0),
              // ),
              elevation: 10,
              child: Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Image(
                        image: AssetImage('assets/patient.png'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                child: Text(
                                  'Dummy User',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ShipporiMincho'),
                                ),
                                onTap: () {
                                  /*Route to Senders Profile for Doctor's Review */
                                },
                              ),
                              Text(
                                'Sent you a request',
                                style: TextStyle(
                                    fontSize: 15, fontFamily: 'ShipporiMincho'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              print('Confirm');
                            },
                            child: Text('Confirm'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              print('Decline');
                            },
                            child: Text(
                              'Decline',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.grey[50])),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
