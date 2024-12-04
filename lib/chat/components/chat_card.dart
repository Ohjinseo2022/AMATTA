import 'package:amatta_front/chat/model/chat_message_model.dart';
import 'package:amatta_front/chat/model/chat_model.dart';
import 'package:amatta_front/common/const/color.dart';
import 'package:amatta_front/common/enumeration/chat_room_status_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';


class ChatCard extends StatelessWidget {
  final bool? isSkeleton;
  final String? id;
  final String? roomName;
  final ChatRoomStatusCode? chatRoomStatusCode;
  final List<ChatMessageModel>? message; //chatMessage
  final String? createdDate;
  final String? lastModifiedDate;
  final String? imageUrl;

  const ChatCard({
    super.key,
    this.isSkeleton = false,
    this.id,
    this.roomName,
    this.chatRoomStatusCode,
    this.lastModifiedDate,
    this.createdDate,
    this.message,
    this.imageUrl,
  });
  factory ChatCard.fromModel(
      {required ChatModel model,
      bool isDetail = false,
      bool isSkeleton = false}) {
    return ChatCard(
      isSkeleton: isSkeleton,
      id: model.id,
      roomName: model.roomName,
      chatRoomStatusCode: model.chatRoomStatusCode,
      createdDate: model.createdDate,
      lastModifiedDate: model.lastModifiedDate,
      imageUrl: model.imageUrl is String ? model.imageUrl : null,
      message: model.message ?? [],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isSkeleton!,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: BACK_GROUND_COLOR,
          border: Border.all(
            color: UNSELECT_TEXT_COLOR.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: isSkeleton!
              ? null
              : [
                  BoxShadow(
                    color: UNSELECT_TEXT_COLOR.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(1, 2),
                  )
                ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Hero(
                tag: ObjectKey(id),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: imageUrl is String
                      ? Image.network(
                          imageUrl!,
                          height: 60.0,
                          width: 60.0,
                          fit: BoxFit.cover,
                        )
                      : _noImageWidget(),
                ),
              ),
            ),
            Expanded(
              // flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      roomName != null && roomName != ""
                          ? roomName as String
                          : "방이름",
                      style: defaultTextStyle.copyWith(
                          fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    // SizedBox(
                    //   height: 8,
                    // ),
                    Text(
                        message != null && message!.length > 0
                            ? message![0].sendMessageText
                            : "아직 첫 대화 내용이 없습니다.",
                        style: defaultTextStyle.copyWith(
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w300)),
                  ],
                ),
              ),
            ),
            //오늘이면 시간 아니면 날짜
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                message != null && message!.length > 0
                    ? message![0].sendMessageText
                    : createdDate!,
                style: defaultTextStyle.copyWith(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _noImageWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: BACK_GROUND_COLOR,
        border: Border.all(
          color: UNSELECT_TEXT_COLOR.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: UNSELECT_TEXT_COLOR.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(1, 2),
          )
        ],
      ),
      width: 60,
      height: 60,
      child: Icon(Icons.person, size: 60, color: ICON_DEFAULT_COLOR),
    );
  }
}

// SvgPicture.asset(
// svgPath,
// height: iconHeight,
// )
