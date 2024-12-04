// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) =>
    ChatMessageModel(
      id: json['id'] as String,
      chatRoomId: json['chatRoomId'] as String,
      sendMessageText: json['sendMessageText'] as String,
      createdDate: json['createdDate'] as String,
      lastModifiedDate: json['lastModifiedDate'] as String,
    );

Map<String, dynamic> _$ChatMessageModelToJson(ChatMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatRoomId': instance.chatRoomId,
      'sendMessageText': instance.sendMessageText,
      'createdDate': instance.createdDate,
      'lastModifiedDate': instance.lastModifiedDate,
    };
