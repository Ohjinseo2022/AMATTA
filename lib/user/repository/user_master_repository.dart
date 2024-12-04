import 'package:amatta_front/common/const/data.dart';
import 'package:amatta_front/common/dio/dio.dart';
import 'package:amatta_front/user/model/user_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'user_master_repository.g.dart';

final userMasterRepositoryProvider = Provider<UserMasterRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return UserMasterRepository(dio, baseUrl: 'http://$ip$baseUrl/user');
});

@RestApi()
abstract class UserMasterRepository {
  factory UserMasterRepository(Dio dio, {String baseUrl}) =
      _UserMasterRepository;

  @GET('/profile')
  @Headers({'accessToken': 'true'})
  Future<UserMinModel?> userProfile();

  @GET('/logout')
  @Headers({'accessToken': 'true'})
  Future<void> userLogout();
}
