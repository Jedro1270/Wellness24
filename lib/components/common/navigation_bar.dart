import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Sapphire Tech'),
            accountEmail: Text('sapphiretech@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image(
                  image: AssetImage('assets/logo.jpg'),
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                )
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home_outlined,
              color: Colors.blueAccent,
            ),
            title: Text('Home'),
            onTap: () => print("Home"),
          ),
          ListTile(
            leading: Icon(
              Icons.notifications_outlined,
              color: Colors.blueAccent
            ),
            title: Text('Notifications'),
            onTap: () => print("Notifications"),
          ),
          ListTile(
            leading: Icon(
              Icons.person_outline,
              color: Colors.blueAccent
            ),
            title: Text('My Patients'),
            onTap: () => print("My Patients"),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.settings_outlined,
              color: Colors.blueAccent
            ),
            title: Text('Settings'),
            onTap: () => print("Settings"),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.blueAccent
            ),
            title: Text('Log out'),
            onTap: () => print("Log out"),
          ),
        ],
      )
    );
  }
}