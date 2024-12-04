import 'package:amatta_front/chat/model/chat_message_model.dart';
import 'package:amatta_front/common/enumeration/chat_room_status_code.dart';
import 'package:amatta_front/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';




part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel implements IModelWithId {
  @override
  final String id;
  final String roomName;
  final ChatRoomStatusCode chatRoomStatusCode;
  final List<ChatMessageModel>? message; //chatMessage
  final String createdDate;
  final String lastModifiedDate;
  final String? imageUrl;

  ChatModel(
      {required this.id,
      required this.roomName,
      required this.chatRoomStatusCode,
      required this.createdDate,
      required this.lastModifiedDate,
      this.message,
      this.imageUrl});
  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
