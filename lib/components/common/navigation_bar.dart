import 'package:flutter/material.dart';
import 'package:wellness24/services/auth_service.dart';
import 'package:wellness24/components/pages/common_pages/login_page.dart';

class NavBar extends StatelessWidget {
  final AuthService auth = AuthService();
  final String name;
  final String email;

  NavBar({this.name, this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(name),
          accountEmail: Text(email),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
                child: Image(
              image: AssetImage('assets/logo.jpg'),
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            )),
          ),
        ),
        ListTile(
          leading: Icon(Icons.settings_outlined, color: Colors.blueAccent),
          title: Text('Settings'),
          onTap: () => print("Settings"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout, color: Colors.blueAccent),
          title: Text('Log out'),
          onTap: () async {
            print("Log out");
            await auth.signOut();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
        ),
      ],
    ));
  }
}
