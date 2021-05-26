import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/common/large_button.dart';
import 'package:wellness24/components/common/loading_animation.dart';
import 'package:wellness24/components/common/schedule_card.dart';
import 'package:wellness24/components/pages/common_pages/chat/messages.dart';
import 'package:wellness24/components/pages/common_pages/patient_profile/patient_profile.dart';
import 'package:wellness24/components/pages/patient_screen/emergency_page.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/pages/patient_screen/my_doctors_list.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';
import 'package:wellness24/components/common/navigation_bar.dart';

import '../common_pages/login_page.dart';
import './doctor_search_page/doctor_search_page.dart';

class PatientHomePage extends StatefulWidget {
  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  Patient currentPatient;

  initializePatient() async {
    User user = Provider.of<User>(context, listen: false);
    DatabaseService database = DatabaseService(uid: user.uid);
    Patient patient = await database.getPatient(user.uid);

    if (mounted) {
      setState(() {
        currentPatient = patient;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initializePatient();
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<User>(context);

    if (currentUser == null) {
      return Login();
    }

    return Scaffold(
      drawer: NavBar(
        name: currentPatient == null ? '' : currentPatient.fullName,
        email: currentUser.email,
        uid: currentPatient?.uid,
        profilePictureUrl: currentPatient?.profilePictureUrl,
      ),
      appBar: CustomAppBar(
        title: 'Home Page',
        actions: [
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                print('Notif button clicked');
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Messages(currentUser: currentUser)));
        },
      ),
      body: currentPatient == null
          ? Loading()
          : Container(
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 60,
                    // width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorSearchPage(
                                currentPatient: currentPatient,
                                doctorDatabaseRef: DatabaseService().doctors),
                          ),
                        );
                      },
                      child: Text(
                        'Search For Doctor',
                        style: TextStyle(
                            fontFamily: 'ShipporiMincho', fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.black,
                        primary: Colors.lightBlueAccent[100],
                        minimumSize: Size(88, 36),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.only(top: 40)),

                  // LargeButton(
                  //     content: 'Search For Doctor',
                  //     backgroundColor: Colors.lightBlueAccent[100],
                  //     fontColor: Colors.black,
                  //     onPressed: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => DoctorSearchPage(
                  //                   currentPatient: currentPatient,
                  //                   doctorDatabaseRef:
                  //                       DatabaseService().doctors)));
                  //     }),
                  // LargeButton(
                  //     content: 'EMERGENCY',
                  //     key: Key('emergencyBtn'),
                  //     backgroundColor: Colors.redAccent[700],
                  //     fontColor: Colors.white,
                  //     onPressed: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) =>
                  //                   EmergencyPage(patient: currentPatient)));
                  //     }),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'My Doctors',
                      style: TextStyle(
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    child: MyDoctorsList(
                      patientDatabaseRef:
                          DatabaseService(uid: currentUser.uid).patients,
                      patientId: currentUser.uid,
                      currentPatient: currentPatient,
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 30),
                  //   child: Text(
                  //     'My Appointments',
                  //     style: TextStyle(
                  //       fontFamily: "ShipporiMincho",
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 20,
                  //     ),
                  //   ),
                  // ),
                  //buildAppointmentList(), // Replace with calendar
                  // TableCalendar(
                  //   calendarController: _controller,
                  //   initialCalendarFormat: CalendarFormat.twoWeeks,
                  // ),
                  Divider(height: 20, color: Colors.transparent),
                  SizedBox(
                    height: 60,
                    // width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientProfile(
                              editable: true,
                              patient: currentPatient,
                              database: DatabaseService(uid: currentUser.uid),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'My Current Conditions',
                        style: TextStyle(
                            fontFamily: 'ShipporiMincho', fontSize: 20),
                      ),
                      key: Key('myCurrentConditionBtn'),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.black,
                        primary: Colors.lightBlueAccent[100],
                        minimumSize: Size(88, 36),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                  ),
                  // LargeButton(
                  //   content: 'My Current Conditions',
                  //   key: Key('myCurrentConditionBtn'),
                  //   backgroundColor: Colors.lightBlueAccent[100],
                  //   fontColor: Colors.black,
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => PatientProfile(
                  //                   editable: true,
                  //                   patient: currentPatient,
                  //                   database:
                  //                       DatabaseService(uid: currentUser.uid),
                  //                 )));
                  //   },
                  // ),
                  Divider(height: 20, color: Colors.transparent),
                ],
              ),
            ),
    );
  }
}

// buildAppointmentList() {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 30),
//     child: Column(
//       children: <Widget>[
//         ScheduleCard('12', 'Jan', 'Consultation', 'Sunday 9am - 11am'),
//         SizedBox(height: 20),
//         ScheduleCard('15', 'Oct', 'Consultation', 'Monday 1pm - 3pm')
//       ],
//     ),
//   );
// }
