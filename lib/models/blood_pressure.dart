import 'package:age/age.dart';

class BloodPressure {
  String reading;
  DateTime lastChecked;

  String get sinceLastChecked {
    String output;
    DateTime present = DateTime.now();

    AgeDuration duration =
        Age.dateDifference(fromDate: lastChecked, toDate: present);

    if (duration.days < 32) {
      output = '${duration.days} days ago';
    } else if ((duration.days / 7).floor() < 5) {
      output = '${(duration.days / 7).floor()} weeks ago';
    }

    return output;
  }
}
