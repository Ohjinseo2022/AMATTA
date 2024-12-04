import 'package:amatta_front/chat/model/chat_message_model.dart';
import 'package:amatta_front/common/components/custom_text_form_field.dart';
import 'package:amatta_front/common/const/data.dart';
import 'package:amatta_front/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class ChatRoomDetail extends ConsumerStatefulWidget {
  static String get routeName => 'chatRoomDetail';
  final String chatRoomId;
  const ChatRoomDetail({super.key, required this.chatRoomId});

  @override
  ConsumerState<ChatRoomDetail> createState() => _ChatRoomDetailState();
}

class _ChatRoomDetailState extends ConsumerState<ChatRoomDetail> {
  late StompClient stompClient;
  // 스크롤 조작 컨트롤러
  ScrollController scrollController = ScrollController();
  // 텍스트 입력 컨트롤러
  TextEditingController textController = TextEditingController();
  String sendText = '';

  // 채팅 목록을 저장할 리스트
  List<ChatMessageModel> messages = [];
  int chatRoomId = 1;
  void onConnect(StompClient stompClient, StompFrame frame) {
    stompClient.subscribe(
        destination: 'ws://$ip$baseUrl/topic/public/rooms/${widget.chatRoomId}',
        callback: (frame) {
          ChatMessageModel obj = ChatMessageModel.fromJson(
              frame.body! as Map<String, dynamic>); //json.decode(frame.body!);

          setState(() {
            messages.add(obj);
          });
        });
  }

  @override
  void initState() {
    super.initState();

    stompClient = StompClient(
      config: StompConfig(
          url:
              'ws://$ip$baseUrl/chat-message/chat/rooms/${widget.chatRoomId}/send',
          onConnect: (frame) => onConnect(stompClient, frame),
          beforeConnect: () async {
            print('waiting to connect...');
            await Future.delayed(const Duration(milliseconds: 200));
            print('connecting...');
          },
          onWebSocketError: (dynamic error) => print(error.toString())
          //stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
          //webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
          ),
    );

    stompClient.activate();
  }

  Future<void> onFieldSubmitted() async {
    //채팅 전송 로직 추가예정
    // 스크롤 위치를 맨 아래로 이동 시킴
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    textController.text = '';
  }

  @override
  void dispose() {
    super.dispose();
    // 웹소켓에서 연결 해제
    stompClient.deactivate();
    // 텍스트 입력 컨트롤러 해제
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        resizeToAvoidBottomInset: true,
        topAppBarBtn: false,
        title: widget.chatRoomId,
        child: _ChatRoomDetailScreen());
  }

  Widget _ChatRoomDetailScreen() {
    return Column(
      children: [
        // 채팅 목록을 표시하는 ListView
        Expanded(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus(); // 가상 키보드 숨기기
            },
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView.separated(
                controller: scrollController,
                shrinkWrap: true,
                reverse: true,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 16,
                  );
                },
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(messages[index].sendMessageText),
                  );
                },
              ),
            ),
          ),
        ),
        // 텍스트 입력 필드와 전송 버튼을 가진 Row
        Row(
          children: [
            // 텍스트 입력 필드
            Expanded(
              child: CustomTextFormField(onChanged: (String value) {
                sendText = value;
              }),
            ),
            // 전송 버튼
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                // 텍스트 입력 필드의 내용을 가져옴
                String message = textController.text;
                if (message.isNotEmpty) {
                  // destination에 메시지 전송
                  stompClient.send(
                    destination: '/app/message', // 전송할 destination
                    body: "", // 메시지의 내용
                  );
                  // 텍스트 입력 필드를 비움
                  textController.clear();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
