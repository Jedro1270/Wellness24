import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// class DoctorQueueMonitor extends StatefulWidget {
//   @override
//   _DoctorQueueMonitorState createState() => _DoctorQueueMonitorState();
// }

// class _DoctorQueueMonitorState extends State<DoctorQueueMonitor> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//       padding: EdgeInsets.all(75),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             'Schedules',
//             style: TextStyle(
//               fontFamily: "ShipporiMincho",
//               fontWeight: FontWeight.bold,
//               fontSize: 40,
//             ),
//           ),
//           Divider(height: 50, color: Colors.transparent),
//           Text(
//             'April 25, 2021',
//             style: TextStyle(
//               fontFamily: "ShipporiMincho",
//               fontWeight: FontWeight.bold,
//               fontSize: 30,
//             ),
//           ),
//           Divider(height: 10, color: Colors.transparent),
//           Text(
//             'Now Serving',
//             style: TextStyle(
//               fontFamily: "ShipporiMincho",
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.arrow_back_ios_rounded),
//               Text(
//                 '24',
//                 style: TextStyle(
//                   fontFamily: "ShipporiMincho",
//                   fontWeight: FontWeight.bold,
//                   fontSize: 90,
//                 ),
//               ),
//               Icon(Icons.arrow_forward_ios_rounded)
//             ],
//           ),
//           Container(
//               child: Text(
//                 'Accept Appointments',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontFamily: "ShipporiMincho",
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//               ),
//               color: Colors.greenAccent[700],
//               padding: EdgeInsets.all(25)),
//         ],
//       ),
//     ));
//   }
// }
//
class DoctorQueueMonitor extends StatefulWidget {
  @override
  _DoctorQueueMonitorState createState() => _DoctorQueueMonitorState();
}

class _DoctorQueueMonitorState extends State<DoctorQueueMonitor> {
  bool _selectDate = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 32, color: Colors.deepPurpleAccent),
            Container(
              color: Colors.deepPurpleAccent,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  topRow(),
                  Padding(
                    padding: EdgeInsets.only(top: 26),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(7,
                        (index) => dateWidget(
                          index: index,
                        )
                      )
                    )
                  )
                ]
              ),
            ),
          ]
        ),
      )
    );
  }
}

class dateWidget extends StatefulWidget {
  final index;

  const dateWidget({Key key, this.index}) : super(key: key);
  @override
  _dateWidgetState createState() => _dateWidgetState();
}

class _dateWidgetState extends State<dateWidget> {
  bool _selectDate = true;
  final list = ["Mon", "Tue", "Wed", "Thu", "Fr", "Sat", "Sun"];
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectDate = !_selectDate;
        });
      },
      child: Container(
        decoration: _selectDate ? null : BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(
            Radius.circular(4)
          )
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Text(
              list[widget.index],
              style: TextStyle(
                fontWeight: _selectDate ? FontWeight.normal : FontWeight.bold,
                color: _selectDate ?  Color(0xffa79abf) : Colors.white
              ),
            ),
            Text(
              "${10 + widget.index}",
              style: TextStyle(
                fontWeight: _selectDate ? FontWeight.normal : FontWeight.bold,
                color:  _selectDate ?  Color(0xffa79abf) : Colors.white
              ),
            ),
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:  _selectDate ? Color(0xff8e7daf) : Colors.white
              ),
            )
          ]
        )
      )
    );
  }
}

class topRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "Daily",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              "appointments",
              style: TextStyle(
                color: Color(0xffa79abf),
                fontSize: 24,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold
              ),
            )
          ]
        ),
        Spacer(),
        Text(
          "Apr",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: "Roboto",
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}