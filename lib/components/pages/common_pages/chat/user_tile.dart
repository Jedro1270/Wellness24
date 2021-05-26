import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/pages/common_pages/chat/chat_room.dart';
import 'package:wellness24/models/user.dart';

class UserTile extends StatelessWidget {
  final String name;
  final String profilePictureUrl;
  final String userUid;

  UserTile({this.name, this.userUid, this.profilePictureUrl});

  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<User>(context);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(
              title: name,
              currentUid: currentUser.uid,
              partnerUid: userUid,
              partnerName: name,
            ),
          ),
        );
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
                  child: Container(
                    height: 120,
                    width: 120,
                    child: profilePictureUrl == null
                        ? Image(
                            image: AssetImage('assets/logo.jpg'),
                            width: 90,
                            height: 90,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            profilePictureUrl,
                            fit: BoxFit.fill,
                          ),
                  ),
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
