import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:wellness24/components/common/app_bar.dart';

class DoctorQueueMonitor extends StatefulWidget {
  @override
  _DoctorQueueMonitorState createState() => _DoctorQueueMonitorState();
}

class _DoctorQueueMonitorState extends State<DoctorQueueMonitor> {
  DateTime currentDate = DateTime.now();
  DateFormat format = DateFormat.yMMMMd('en_US');

  int currentNumber = 0;

  bool isAcceptingCustomers = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: '',
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Priority Numbers',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "ShipporiMincho",
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              Divider(height: 50, color: Colors.transparent),
              Text(
                format.format(currentDate),
                style: TextStyle(
                  fontFamily: "ShipporiMincho",
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Divider(height: 10, color: Colors.transparent),
              Text(
                'Now Serving',
                style: TextStyle(
                  fontFamily: "ShipporiMincho",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentNumber--;
                      });
                    },
                    iconSize: 50,
                    icon: Icon(Icons.arrow_back_ios_rounded),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$currentNumber',
                      style: TextStyle(
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.bold,
                        fontSize: 90,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentNumber++;
                      });
                    },
                    iconSize: 50,
                    icon: Icon(Icons.arrow_forward_ios_rounded),
                  )
                ],
              ),
              Text(
                isAcceptingCustomers
                    ? 'Accepting Appointments'
                    : 'Unavailable for Appointments',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "ShipporiMincho",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color:
                        isAcceptingCustomers ? Colors.green[700] : Colors.red),
              ),
              Switch(
                  value: isAcceptingCustomers,
                  onChanged: (bool newValue) {
                    if (newValue == false) {
                      _showDialog(context);
                    } else {
                      setState(() {
                        isAcceptingCustomers = true;
                      });
                    }
                  }),
            ],
          ),
        ));
  }

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content:
                  Text('This will let your patients know that you are no longer available. \n\nWould you like to continue?'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isAcceptingCustomers = false;
                      });
                      Navigator.pop(context);
                    },
                    child: Text('YES')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('NO'))
              ],
            ));
  }
}
