import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String hint;

  TextInput({this.hint});

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.withOpacity(0.5),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: Colors.black54,
          fontSize: 25,
        ),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
      ),
    );
  }
}
