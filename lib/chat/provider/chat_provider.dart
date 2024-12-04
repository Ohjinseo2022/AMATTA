import 'package:amatta_front/chat/model/chat_model.dart';
import 'package:amatta_front/chat/repository/chat_repository.dart';
import 'package:amatta_front/common/model/cursor_pagination_model.dart';
import 'package:amatta_front/common/provider/pagination_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatProvider =
    StateNotifierProvider<ChatStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  final notifier = ChatStateNotifier(repository: repository);
  return notifier;
});

class ChatStateNotifier extends PaginationProvider<ChatModel, ChatRepository> {
  ChatStateNotifier({required super.repository});
}
