import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';

class DoctorDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Doctor',
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.home_outlined),
            iconSize: 30.0,
          )
        ],
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
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Elimjoyce Abagat\n',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "ShipporiMincho",
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),
                            ),
                            TextSpan(
                              text: "Cardiologist",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "ShipporiMincho",
                                color: Colors.black
                              )
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      ButtonAction(
                        color: Color(0xFFFFB755),
                        icon: Icons.mail,
                      ),
                      SizedBox(width: 14.0),
                      ButtonAction(
                        color: Color(0xFF58c697),
                        icon: Icons.phone,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Divider(color: Color(0xFFA9A8A8)),
                  SizedBox(height: 20.0),
                  Text("About", style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "ShipporiMincho",
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  )),
                  SizedBox(height: 20.0),
                  Text("AAAAAAAAAASDasdasdasdsad sdfdfgfdg", style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: "ShipporiMincho"
                  )),
                  SizedBox(height: 20.0),
                  Text("Working hours", style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "ShipporiMincho",
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  )),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text("Mon - Fri 8:00 - 16:00", style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: "ShipporiMincho"
                      )),
                      SizedBox(width: 20.0),
                      SizedBox(
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
                              color: Colors.white
                            ).copyWith(color: Color(0xFF58c697)),
                          ),
                        ),
                      ),
                    ],
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
                child: RaisedButton(
                  onPressed: () {},
                  elevation: 0.0,
                  color: Color(0xFF40BEEE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Center(
                    child: Text(
                      "Make an appointment",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "ShipporiMincho",
                        color: Colors.white
                      ),
                    ),
                  ),
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