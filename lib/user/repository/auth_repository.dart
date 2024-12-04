import 'package:amatta_front/common/const/data.dart';
import 'package:amatta_front/common/dio/dio.dart';
import 'package:amatta_front/common/model/login_response.dart';
import 'package:amatta_front/user/model/login_req_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'auth_repository.g.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(dio, baseUrl: 'http://$ip$baseUrl');
});

@RestApi()
abstract class AuthRepository {
  factory AuthRepository(Dio dio, {String baseUrl}) = _AuthRepository;

  //{String? email, String? password}
  @POST('/login/social')
  @Headers({'accessToken': 'true'})
  Future<LoginResponse> login({@Body() required LoginReqModel loginReqDTO});
}
