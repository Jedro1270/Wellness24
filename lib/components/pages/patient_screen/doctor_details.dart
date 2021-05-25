import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/common_pages/chat/messages.dart';
import 'package:wellness24/components/pages/patient_screen/patient_schedule_page.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/models/patient.dart';
import 'package:url_launcher/url_launcher.dart';
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
  bool isDoctor = false;
  final Widget emptyWidget = Container(
    width: 0,
    height: 0,
  );

  _DoctorDetailsState({this.doctor});

  void fetchExistingRequest() async {
    DatabaseService database = DatabaseService(uid: widget.currentPatient.uid);
    bool result = await database.requestExists(
        doctorId: doctor.uid, patientId: widget.currentPatient.uid);
    setState(() => requestExists = result);
  }

  void fetchIsMyDoctor() async {
    DatabaseService database = DatabaseService(uid: widget.currentPatient.uid);
    bool result = await database.isMyDoctor(doctor.uid);
    setState(() => isDoctor = result);
  }

  @override
  void initState() {
    super.initState();
    fetchExistingRequest();
    fetchIsMyDoctor();
  }

  @override
  Widget build(BuildContext context) {
    User currentPatient = Provider.of<User>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Doctor',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: 275.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/sample-patient.jpg"),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
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
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: MaterialButton(
                              child: ButtonAction(
                                color: Color(0xFFFFB755),
                                icon: Icons.mail,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Messages(currentUser: currentPatient)));
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
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
                      "${doctor.workingDays}: ${doctor.clinicStart} - ${doctor.clinicEnd}",
                      style: TextStyle(
                          fontSize: 14.0, fontFamily: "ShipporiMincho")),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SizedBox(
                width: double.infinity,
                height: 55.0,
                child: isDoctor
                    ? emptyWidget
                    : ElevatedButton(
                        child: Text(
                          '${requestExists ? 'Cancel Request' : 'Send Request'}',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "ShipporiMincho",
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: requestExists
                              ? Color(0xD3D3D3)
                              : Color(0xFF40BEEE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        onPressed: () {
                          if (requestExists) {
                            setState(() {
                              requestExists = !requestExists;
                            });
                            DatabaseService().cancelRequest(
                                doctorId: doctor.uid,
                                patientId: widget.currentPatient.uid);
                          } else {
                            displayConsentDialog(context);
                          }
                        },
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SizedBox(
                width: double.infinity,
                height: 55.0,
                child: ElevatedButton(
                  child: Text(
                    'Appointment',
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
                          builder: (context) => PatientAppointmentPage(
                            doctor: widget.doctor,
                            currentPatient: widget.currentPatient,
                          ),
                        ));
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

  displayConsentDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure you want to send this request?'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'By sending this request, you agree to let this doctor access and append your medical information.',
                  ),
                  Text(
                    '\nSteps to Verify a Doctor:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('\n1. Access the website below'),
                  TextButton(
                    onPressed: () async {
                      String verificationSiteUrl =
                          'https://online1.prc.gov.ph/Verification';

                      await canLaunch(verificationSiteUrl)
                          ? await launch(verificationSiteUrl)
                          : throw 'Cannot launch $verificationSiteUrl';
                    },
                    child: Text('PRC Online Verification Site'),
                  ),
                  Text('\n2. Choose VERIFICATION OF LICENSE (BY NAME)'),
                  Text('\n3. Enter the details provided below'),
                  Text(
                    '\n\  Profession: PHYSICIAN\n\  First Name: ${doctor.firstName.toUpperCase()}\n\  Last Name: ${doctor.lastName.toUpperCase()}',
                  ),
                  Text('\n4. Tap Verify'),
                  Text(
                      '\nDo you consent for this doctor to access, append and edit your medical information?'),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      requestExists = false;
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      requestExists = true;
                    });
                    Navigator.pop(context);
                    DatabaseService().sendRequest(
                        doctorId: doctor.uid,
                        patientId: widget.currentPatient.uid);
                  },
                  child: Text('Consent')),
            ],
          );
        });
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
