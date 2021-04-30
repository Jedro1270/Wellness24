import 'package:flutter/material.dart';

class EditableTitle extends StatefulWidget {
  final String initialText;
  final Function onSubmitted;

  EditableTitle({@required this.initialText, @required this.onSubmitted});

  @override
  _EditableTitleState createState() => _EditableTitleState();
}

class _EditableTitleState extends State<EditableTitle> {
  bool _isEditingText = false;
  TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.95,
        ),
        child: _isEditingText
            ? TextField(
                onSubmitted: (newValue) {
                  widget.onSubmitted(newValue);
                  setState(() {
                    _isEditingText = false;
                  });
                },
                autofocus: true,
                controller: _editingController,
              )
            : InkWell(
                onTap: () {
                  setState(() {
                    _isEditingText = true;
                  });
                },
                child: Text(
                  widget.initialText,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontFamily: 'ShipporiMincho',
                      fontWeight: FontWeight.bold),
                ),
              ));
  }
}
