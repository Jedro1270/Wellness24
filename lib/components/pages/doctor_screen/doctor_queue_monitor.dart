import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/services/database.dart';

class DoctorQueueMonitor extends StatefulWidget {
  final Doctor currentDoctor;

  DoctorQueueMonitor(this.currentDoctor);

  @override
  _DoctorQueueMonitorState createState() => _DoctorQueueMonitorState();
}

class _DoctorQueueMonitorState extends State<DoctorQueueMonitor> {
  bool _selectDate = true;
  DateTime currentDate = DateTime.now();
  DateFormat format = DateFormat.yMMMMd('en_US');
  int queueCapacity, currentNumber = 1;
  bool isAcceptingCustomers = true;
  TextEditingController queueController;

  DatabaseService _database;

  int limitNumber = 50;

  void fetchQueueCap() async {
    _database = DatabaseService(uid: widget.currentDoctor.uid);
    int result = await _database.getAppointmentQueueCap(currentDate);
    setState(() {
      queueCapacity = result ?? 0;
      queueController.text = '$queueCapacity';
    });
  }

  @override
  void initState() {
    super.initState();
    queueController = TextEditingController();
    fetchQueueCap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: '',
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Limit: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'ShipporiMincho',
                          color: Colors.black),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: TextFormField(
                        controller: queueController,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (newLimit) {
                          setState(() {
                            int newIntLimit = int.parse(newLimit);
                            limitNumber = newIntLimit;
                            _database.updateAppointmentQueueCap(
                                int.parse(newLimit), DateTime.now());
                          });
                        },
                      ),
                    ),
                  ],
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
                          currentNumber <= 1
                              ? currentNumber = 1
                              : currentNumber--;
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
                          currentNumber >= limitNumber
                              ? currentNumber = limitNumber
                              : currentNumber++;
                        });
                      },
                      iconSize: 50,
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                    )
                  ],
                ),
              ],
            ),
          ]),
        ));
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
            decoration: _selectDate
                ? null
                : BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
            padding: EdgeInsets.all(8),
            child: Column(children: <Widget>[
              Text(
                list[widget.index],
                style: TextStyle(
                    fontWeight:
                        _selectDate ? FontWeight.normal : FontWeight.bold,
                    color: _selectDate ? Color(0xffa79abf) : Colors.white),
              ),
              Text(
                "${10 + widget.index}",
                style: TextStyle(
                    fontWeight:
                        _selectDate ? FontWeight.normal : FontWeight.bold,
                    color: _selectDate ? Color(0xffa79abf) : Colors.white),
              ),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _selectDate ? Color(0xff8e7daf) : Colors.white),
              )
            ])));
  }
}

class topRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Row(children: <Widget>[
          Text(
            "Priority",
            style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8.0),
          Text(
            "numbers",
            style: TextStyle(
                color: Color(0xffa79abf),
                fontSize: 35,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold),
          )
        ]),
        Spacer(),
        Text(
          "Apr",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
