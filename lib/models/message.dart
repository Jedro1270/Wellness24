import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable(nullable: false, explicitToJson: true)
class Message {
  String content;
  DateTime dateCreated;

  String receiverUid;
  String senderUid;

  Message({this.content, this.dateCreated, this.receiverUid, this.senderUid});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
