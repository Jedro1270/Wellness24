import 'package:clock/clock.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blood_pressure.g.dart';

@JsonSerializable(nullable: false, explicitToJson: true)
class BloodPressure {
  String reading;
  DateTime lastChecked;

  @JsonKey(ignore: true)
  final Clock clock;

  BloodPressure({this.reading, this.lastChecked, this.clock = const Clock()});

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

  factory BloodPressure.fromJson(Map<String, dynamic> json) {
    return _$BloodPressureFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BloodPressureToJson(this);
}
