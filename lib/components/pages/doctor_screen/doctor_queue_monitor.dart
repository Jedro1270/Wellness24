import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:wellness24/components/common/app_bar.dart';

class DoctorQueueMonitor extends StatefulWidget {
  @override
  _DoctorQueueMonitorState createState() => _DoctorQueueMonitorState();
}

class _DoctorQueueMonitorState extends State<DoctorQueueMonitor> {
  bool _selectDate = true;
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
      body: SingleChildScrollView(
        child:
        Column(
          children: <Widget>[
            // Container(
            //   color: Colors.lightBlue,
            //   padding: EdgeInsets.all(16),
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     children: <Widget>[
            //       topRow(),
            //       Padding(
            //         padding: EdgeInsets.only(top: 26),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: List.generate(7,
            //             (index) => dateWidget(
            //               index: index,
            //             )
            //           )
            //         )
            //       )
            //     ]
            //   ),
            // ),
            Column(
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
          ]
        ),
      )
    );
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
            child: Text('NO')
          )
        ],
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
              "Priority",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              "numbers",
              style: TextStyle(
                color: Color(0xffa79abf),
                fontSize: 35,
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
            fontSize: 18,
            fontFamily: "Roboto",
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}

