// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      id: json['id'] as String,
      roomName: json['roomName'] as String,
      chatRoomStatusCode:
          $enumDecode(_$ChatRoomStatusCodeEnumMap, json['chatRoomStatusCode']),
      createdDate: json['createdDate'] as String,
      lastModifiedDate: json['lastModifiedDate'] as String,
      message: (json['message'] as List<dynamic>?)
          ?.map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'id': instance.id,
      'roomName': instance.roomName,
      'chatRoomStatusCode':
          _$ChatRoomStatusCodeEnumMap[instance.chatRoomStatusCode]!,
      'message': instance.message,
      'createdDate': instance.createdDate,
      'lastModifiedDate': instance.lastModifiedDate,
      'imageUrl': instance.imageUrl,
    };

const _$ChatRoomStatusCodeEnumMap = {
  ChatRoomStatusCode.IDLE: 'IDLE',
  ChatRoomStatusCode.ACTIVE: 'ACTIVE',
  ChatRoomStatusCode.INACTIVE: 'INACTIVE',
  ChatRoomStatusCode.UNDEFINED: 'UNDEFINED',
};
