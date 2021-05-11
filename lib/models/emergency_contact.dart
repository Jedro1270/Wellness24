import 'package:json_annotation/json_annotation.dart';

part 'emergency_contact.g.dart';

@JsonSerializable(nullable: false, explicitToJson: true)
class EmergencyContact {
  String firstName, lastName, middleInitial, address, contactNo, relationship;

  EmergencyContact({
    this.lastName,
    this.firstName,
    this.middleInitial,
    this.address,
    this.contactNo,
    this.relationship,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyContactToJson(this);
}
