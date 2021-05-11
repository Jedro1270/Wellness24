// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    content: json['content'] as String,
    dateCreated: DateTime.parse(json['dateCreated'] as String),
    receiverUid: json['receiverUid'] as String,
    senderUid: json['senderUid'] as String,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'content': instance.content,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'receiverUid': instance.receiverUid,
      'senderUid': instance.senderUid,
    };
