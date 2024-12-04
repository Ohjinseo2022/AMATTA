import 'package:amatta_front/chat/components/chat_card.dart';
import 'package:amatta_front/chat/model/chat_model.dart';
import 'package:amatta_front/chat/provider/chat_provider.dart';
import 'package:amatta_front/chat/view/chat_room_detail.dart';
import 'package:amatta_front/common/components/pagination_list_view.dart';
import 'package:amatta_front/common/enumeration/chat_room_status_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatRoomList extends ConsumerStatefulWidget {
  static String get routeName => 'chatRoomList';
  const ChatRoomList({super.key});

  @override
  ConsumerState<ChatRoomList> createState() => _ChatRoomListState();
}

class _ChatRoomListState extends ConsumerState<ChatRoomList> {
  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     ChatCard.fromModel(
    //       isSkeleton: true,
    //       model: ChatModel(
    //           id: "ddd",
    //           roomName: "오진서",
    //           chatRoomStatusCode: ChatRoomStatusCode.ACTIVE,
    //           createdDate: "2024-11-25",
    //           lastModifiedDate: "2024-11-25"),
    //     )
    //   ],
    // );
    return PaginationListView(
        provider: chatProvider,
        itemBuilder: <ChatModel>(_, index, model) {
          return GestureDetector(
            onTap: () {
              context.goNamed(ChatRoomDetail.routeName,
                  pathParameters: {'id': model.id});
            },
            child: ChatCard.fromModel(
                isSkeleton:
                    model.chatRoomStatusCode == ChatRoomStatusCode.UNDEFINED,
                model: model),
          );
        },
        skeletonBuilder: ChatModel(
            id: '68',
            roomName: "방이름",
            chatRoomStatusCode: ChatRoomStatusCode.ACTIVE,
            // ChatRoomStatusCode.UNDEFINED,
            createdDate: '2024-11-11',
            lastModifiedDate: '',
            imageUrl: null,
            message: null));
  }
}
