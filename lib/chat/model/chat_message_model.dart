import 'package:json_annotation/json_annotation.dart';

part "chat_message_model.g.dart";

@JsonSerializable()
class ChatMessageModel {
  final String id;
  final String chatRoomId;
  final String sendMessageText;
  // final Resource file; // 코민... 파일 주고받기 코민코민...
  final String createdDate;
  final String lastModifiedDate;
  ChatMessageModel({
    required this.id,
    required this.chatRoomId,
    required this.sendMessageText,
    required this.createdDate,
    required this.lastModifiedDate,
  });
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
}
