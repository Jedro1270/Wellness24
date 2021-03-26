import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/patient_screen/patient_schedule_page.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';

class DoctorDetails extends StatefulWidget {
  final Doctor doctor;
  final Patient currentPatient;

  DoctorDetails({this.doctor, this.currentPatient});

  @override
  _DoctorDetailsState createState() => _DoctorDetailsState(doctor: this.doctor);
}

class _DoctorDetailsState extends State<DoctorDetails> {
  final Doctor doctor;
  bool requestExists = false;

  _DoctorDetailsState({this.doctor});

  void fetchExistingRequest() async {
    final user = Provider.of<User>(context, listen: false);
    DatabaseService database = DatabaseService(uid: user.uid);
    bool result =
        await database.requestExists(doctorId: doctor.uid, patientId: user.uid);
    setState(() => requestExists = result);
  }

  @override
  void initState() {
    super.initState();
    fetchExistingRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Doctor',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/doctor.png"),
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${doctor.fullName}\n',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "ShipporiMincho",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                  text: "${doctor.specialization}",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: "ShipporiMincho",
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonAction(
                            color: Color(0xFFFFB755),
                            icon: Icons.mail,
                          ),
                          ButtonAction(
                            color: Color(0xFF58c697),
                            icon: Icons.phone,
                          )
                        ]),
                  ),
                  Divider(color: Color(0xFFA9A8A8)),
                  Text("About",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(height: 20.0),
                  Text("${doctor.about}",
                      style: TextStyle(
                          fontSize: 14.0, fontFamily: "ShipporiMincho")),
                  SizedBox(height: 20.0),
                  Divider(color: Color(0xFFA9A8A8)),
                  Text("Educational Attainment",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(height: 20.0),
                  Text("${doctor.education}",
                      style: TextStyle(
                          fontSize: 14.0, fontFamily: "ShipporiMincho")),
                  SizedBox(height: 20.0),
                  Divider(color: Color(0xFFA9A8A8)),
                  Text("Working hours",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(height: 10.0),
                  Text(
                      "${doctor.workingDays}: ${doctor.clinicStartHour} - ${doctor.clinicEndHour}",
                      style: TextStyle(
                          fontSize: 14.0, fontFamily: "ShipporiMincho")),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: SizedBox(
                        width: 90.0,
                        height: 35.0,
                        child: RaisedButton(
                          onPressed: () {},
                          color: Color(0xFFDBF3E8),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: Text(
                            "Open",
                            style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "ShipporiMincho",
                                    color: Colors.white)
                                .copyWith(color: Color(0xFF58c697)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SizedBox(
                width: double.infinity,
                height: 55.0,
                child: ElevatedButton(
                  child: Text(
                    '${requestExists ? 'Cancel Request' : 'Send Request'}',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "ShipporiMincho",
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary:
                        requestExists ? Color(0xD3D3D3) : Color(0xFF40BEEE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  onPressed: () {
                    if (requestExists) {
                      DatabaseService().cancelRequest(
                          doctorId: doctor.uid,
                          patientId: widget.currentPatient.uid);
                    } else {
                      DatabaseService().sendRequest(
                          doctorId: doctor.uid,
                          patientId: widget.currentPatient.uid);
                    }

                    setState(() {
                      requestExists = !requestExists;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SizedBox(
                width: double.infinity,
                height: 55.0,
                child: ElevatedButton(
                  child: Text(
                    'Make an Appointment',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "ShipporiMincho",
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF40BEEE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PatientAppointmentPage(),
                        ));
                    print('Make an Appointment');
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

class ButtonAction extends StatelessWidget {
  final Color color;
  final IconData icon;
  ButtonAction({this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        color: color,
      ),
      child: Icon(
        icon,
        size: 25.0,
        color: Colors.white,
      ),
    );
  }
}
