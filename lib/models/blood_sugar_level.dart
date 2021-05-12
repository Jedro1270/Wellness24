import 'package:json_annotation/json_annotation.dart';
import 'package:clock/clock.dart';

part 'blood_sugar_level.g.dart';

@JsonSerializable(nullable: false, explicitToJson: true)
class BloodSugarLevel {
  String reading;
  DateTime lastChecked;

  @JsonKey(ignore: true)
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

  factory BloodSugarLevel.fromJson(Map<String, dynamic> json) {
    return _$BloodSugarLevelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BloodSugarLevelToJson(this);
}
