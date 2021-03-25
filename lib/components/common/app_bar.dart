import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Widget leading;
  final List<Widget> actions;
  final Size preferredSize = Size.fromHeight(65);

  CustomAppBar({this.title, this.leading, this.actions});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: widget.preferredSize,
      child: AppBar(
          centerTitle: true,
          toolbarHeight: 75,
          backgroundColor: widget.title == 'Emergency' ? Colors.red[600] : Colors.blue,
          title: Text(widget.title,
              style: TextStyle(
                  fontFamily: "ShipporiMincho", fontWeight: FontWeight.normal)),
          leading: widget.leading,
          actions: widget.actions),
    );
  }
}
