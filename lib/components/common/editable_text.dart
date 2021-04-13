import 'package:flutter/material.dart';

class EditableTextField extends StatefulWidget {
  bool isEditing;
  EditableTextField({this.isEditing});
  @override
  _EditableTextFieldState createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {
  bool _isEditingText = false;
  TextEditingController _editingController;
  String initialText = "Title";

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditingText)
      return Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.95,
          ),
          child: TextField(
            onSubmitted: (newValue) {
              setState(() {
                initialText = newValue;
                _isEditingText = false;
              });
            },
            autofocus: true,
            controller: _editingController,
          ));

    return InkWell(
      onTap: () {
        setState(() {
          _isEditingText = true;
        });
      },
      child: Text(
        initialText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontFamily: 'ShipporiMincho',
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
