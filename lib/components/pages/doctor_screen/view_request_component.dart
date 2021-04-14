import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/common_pages/login_page.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/services/database.dart';

class ViewRequest extends StatefulWidget {
  final DatabaseService database;
  final List requests;
  ViewRequest({this.database, this.requests});
  @override
  _ViewRequestState createState() => _ViewRequestState();
}

class _ViewRequestState extends State<ViewRequest> {
  List<Patient> patientRequests = [];

  void fetchRequests() async {
    if (widget.requests == null) {
      List requestsData = await widget.database.getPatientRequest();

      List<Patient> requestsInfo =
          await Future.wait(requestsData.map((e) async {
        return await DatabaseService().getPatient(e['uid']);
      }));

      setState(() {
        patientRequests = requestsInfo;
      });
    } else {
      setState(() {
        patientRequests = widget.requests;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.database.uid == null) {
      return Login();
    }

    return Container(
      child: ListView(
        children: <Widget>[
          ...patientRequests.map(
            (patient) => Container(
              key: Key('requestPanel'),
              height: 110,
              child: Card(
                elevation: 10,
                child: Container(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Image(
                          image: AssetImage('assets/patient.png'),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                  child: Text(
                                    patient.fullName,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'ShipporiMincho'),
                                  ),
                                  onTap: () {
                                    /*Route to Senders Profile for Doctor's Review */
                                  },
                                ),
                                Text(
                                  'Sent you a request',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'ShipporiMincho'),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    ElevatedButton(
                                        onPressed: () {
                                          print('Confirm');
                                          widget.database
                                              .acceptPatient(patient.uid);
                                          setState(() {
                                            patientRequests.removeWhere(
                                                (e) => e.uid == patient.uid);
                                          });
                                        },
                                        child: Icon(Icons.check)),
                                    SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        print('Decline');
                                        widget.database
                                            .declinePatient(patient.uid);
                                        setState(() {
                                          patientRequests.removeWhere(
                                              (e) => e.uid == patient.uid);
                                        });
                                      },
                                      child: Icon(Icons.clear,
                                          color: Colors.black),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => Colors.grey[50]),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(width: 5),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
