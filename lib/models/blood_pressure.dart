import 'package:age/age.dart';

class BloodPressure {
  String reading;
  DateTime lastChecked;

  BloodPressure({this.reading, this.lastChecked});

  String get sinceLastChecked {
    String output;
    DateTime present = DateTime.now();

    AgeDuration duration =
        Age.dateDifference(fromDate: lastChecked, toDate: present);

    if (duration.days < 32) {
      output = '${duration.days} day/s ago';
    } else if ((duration.days / 7).floor() < 5) {
      output = '${(duration.days / 7).floor()} week/s ago';
    }

    return output;
  }
}
