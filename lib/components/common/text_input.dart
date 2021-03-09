import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String hint;
  final keyboardType;
  final obscureText;

  TextInput({this.hint, this.keyboardType, this.obscureText});

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      // keyboardType: TextInputType.emailAddress,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.blueGrey.shade50,
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
