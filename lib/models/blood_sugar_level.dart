import 'package:age/age.dart';
import 'package:clock/clock.dart';

class BloodSugarLevel {
  String reading;
  DateTime lastChecked;
  final Clock clock;

  BloodSugarLevel({this.reading, this.lastChecked, this.clock = const Clock()});

  String get sinceLastChecked {
    String output;

    final difference = lastChecked.difference(clock.now());

    if (difference.inDays < 32) {
      output = '${difference.inDays.abs()} day/s ago';
    } else {
      output = '${(difference.inDays / 7).floor().abs()} week/s ago';
    }

    return output;
  }
}
