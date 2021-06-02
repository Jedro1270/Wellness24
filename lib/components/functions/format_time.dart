import 'package:flutter/material.dart';

String formatTime(TimeOfDay time) {
  String hours = time.hourOfPeriod == 0 ? '12' : '${time.hourOfPeriod}';
  String minute =
      '${time.minute}'.length < 2 ? '${time.minute}0' : '${time.minute}';
  String period = '${time.period}'.substring(10, 12).toUpperCase();

  return '$hours:$minute $period';
}
