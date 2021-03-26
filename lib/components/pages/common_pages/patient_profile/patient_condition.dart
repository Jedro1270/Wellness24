import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wellness24/components/common/loading_animation.dart';

class PatientCondition extends StatefulWidget {
  final bool editable;
  final Widget icon;
  final String content;
  final String title;
  final Function onChanged;
  final bool loading;
  final String inputFormat;

  PatientCondition(
      {this.editable,
      this.icon,
      this.content,
      this.title,
      this.onChanged,
      this.loading = false,
      this.inputFormat});

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

    if (newContent == null || newContent == 'null') {
      newContent = '';
    }

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
          child: widget.loading
              ? Loading()
              : Row(
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
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(widget.inputFormat))
                                    ],
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
                                  newContent == ''
                                      ? 'Set ${widget.title}'
                                      : newContent,
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
