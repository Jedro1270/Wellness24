import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/common_pages/chat/chat_room.dart';

class UserTile extends StatelessWidget {
  final String name;

  UserTile({this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.grey,
                child: ClipOval(
                  child: SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child:
                          Image(image: AssetImage('assets/sample-patient.jpg'))),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "ShipporiMincho",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
