import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/pages/common_pages/login_page.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';

class ViewRequest extends StatefulWidget {
  @override
  _ViewRequestState createState() => _ViewRequestState();
}

class _ViewRequestState extends State<ViewRequest> {
  List<Patient> patientRequests = [];

  void fetchRequests() async {
    final user = Provider.of<User>(context, listen: false);
    List requestsData =
        await DatabaseService(uid: user.uid).getPatientRequest();

    List<Patient> requestsInfo = await Future.wait(requestsData.map((e) async {
      return await DatabaseService().getPatient(e['uid']);
    }));

    setState(() {
      patientRequests = requestsInfo;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Login();
    }

    final database = DatabaseService(uid: user.uid);

    return Container(
      child: ListView(
        children: <Widget>[
          ...patientRequests.map(
            (patient) => Container(
              height: 110,
              child: Card(
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(15.0),
                // ),
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
                                          database.acceptPatient(patient.uid);
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
                                        database.declinePatient(patient.uid);
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
