import 'dart:convert';

import 'package:amatta_front/common/const/data.dart';
import 'package:amatta_front/common/secure_storage/secure_storage.dart';
import 'package:amatta_front/user/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

final stompProvider =
    StateNotifierProvider<StompClientStateNotifier, UserModelBase?>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return StompClientStateNotifier(storage: storage);
});

class StompClientStateNotifier extends StateNotifier<UserModelBase?> {
  final FlutterSecureStorage storage;
  StompClientStateNotifier({required this.storage}) : super(UserModelLoading());

  // 구독
  void _onConnect(dd, StompFrame frame, String token) {
    // ...
    dd!.subscribe(
        destination:
            'ws://$ip$baseUrl//topic/public/rooms/{roomId}', // 구독 url (ex: /topic/stage)
        callback: (StompFrame frame) {
          // 구독 성공하면 콜백 올 때마다 할 일
          if (frame.body != null) {
            // stage 상태 변경
            // var socketResponse = BaseSocketResponse.fromJson(
            //     jsonDecode(frame.body.toString()), null);
            // _setStageType(socketResponse, frame);
          }
        });
    // 연결 되면 구독
  }

  void connectWebSocket(String roomId) async {
    String token = await storage.read(key: ACCESS_TOKEN_KEY) ?? "";

    // /chat-message/chat/rooms/{roomId}/send
    // stomp 클라이언트 생성
    StompClient stompClient = StompClient(
        config: StompConfig(
      url:
          'ws://$ip$baseUrl/chat-message/chat/rooms/$roomId/send', // 소켓 base url (ex:  ws://0.00.000.00:8080/abc)
      onConnect: (frame) {
        _onConnect(this, frame, token);
      },
      stompConnectHeaders: {'x-access-token': token},
      webSocketConnectHeaders: {'x-access-token': token},
      onDebugMessage: (p0) => print("mmm socket: $p0"),
    ));
    // 클라이언트 활성화
    stompClient!.activate();
  }
}
