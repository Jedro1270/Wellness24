import 'package:flutter/material.dart';

class PatientCondition extends StatefulWidget {
  final bool editable;
  final Widget icon;
  final String content;
  final String title;
  final Function onChanged;

  PatientCondition(
      {this.editable, this.icon, this.content, this.title, this.onChanged});

  @override
  _PatientConditionState createState() => _PatientConditionState();
}

class _PatientConditionState extends State<PatientCondition> {
  String newContent;
  bool editing = false;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();

    newContent = widget.content;
    controller = TextEditingController(text: newContent);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          editing = true;
        });
      },
      child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Row(
            children: <Widget>[
              SizedBox(width: 10.0),
              SizedBox(height: 50, width: 50, child: widget.icon),
              SizedBox(width: 10.0),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    editing && widget.editable
                        ? SizedBox(
                            height: 50,
                            width: 100,
                            child: TextField(
                              onSubmitted: (newValue) {
                                setState(() {
                                  newContent = newValue;
                                  editing = false;

                                  widget.onChanged(newContent);
                                });
                              },
                              autofocus: true,
                              controller: controller,
                            ),
                          )
                        : Text(
                            newContent == null ? '' : newContent,
                            style: TextStyle(
                                fontFamily: 'ShipporiMincho',
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontFamily: 'ShipporiMincho',
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
