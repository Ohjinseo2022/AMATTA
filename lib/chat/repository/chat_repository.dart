import 'package:amatta_front/chat/model/chat_model.dart';
import 'package:amatta_front/common/const/data.dart';
import 'package:amatta_front/common/dio/dio.dart';
import 'package:amatta_front/common/model/cursor_pagination_model.dart';
import 'package:amatta_front/common/model/pagination_params.dart';
import 'package:amatta_front/common/repository/base_pagination_repository.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'chat_repository.g.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ChatRepository(dio, baseUrl: 'http://$ip$baseUrl/chat-room');
});

@RestApi()
abstract class ChatRepository implements IBasePaginationRepository<ChatModel> {
  factory ChatRepository(Dio dio, {String baseUrl}) = _ChatRepository;

  @override
  @GET("/list")
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<ChatModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
