import 'package:flutter/material.dart';
import 'package:wellness24/components/common/text_input.dart';

class MedicalHistory extends StatefulWidget {
  @override
  _MedicalHistoryState createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  final medicalList = [
    MedicalHistoryList(title: "None"),
    MedicalHistoryList(title: "Anemia"),
    MedicalHistoryList(title: "Asthma"),
    MedicalHistoryList(title: "Diabetes"),
    MedicalHistoryList(title: "Hypertension"),
    MedicalHistoryList(title: "Alergic Rhintis"),
    MedicalHistoryList(title: "Obesity"),
    MedicalHistoryList(title: "Others"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 35.0, horizontal: 25.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 25,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      "Medical History",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            ...medicalList
                .map((item) => Container(
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            item.value = !item.value;
                          });
                        },
                        leading: Checkbox(
                          value: item.value,
                          activeColor: Colors.blueAccent,
                          onChanged: (value) {
                            setState(() {
                              item.value = item.value;
                            });
                          },
                        ),
                        title: Text(item.title, style: TextStyle(fontSize: 20)),
                        minVerticalPadding: 2,
                      ),
                    ))
                .toList(),
            SizedBox(height: 50.0, width: 30.0, child: TextInput()),
            SizedBox(height: 10.0),
            SizedBox(
              height: 55.0,
              width: 30.0,
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.black12)),
                  color: Colors.grey.withOpacity(0.5),
                  // minWidth: 100,
                  // padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {},
                  child: Text("Submit",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 25,
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}

class MedicalHistoryList {
  String title;
  bool value;

  MedicalHistoryList({
    @required this.title,
    this.value = false,
  });
}
