import 'package:amatta_front/common/const/color.dart';
import 'package:amatta_front/common/env/env_config.dart';
import 'package:amatta_front/common/provider/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() async {
  // Intl.defaultLocale = 'ko_KR';
  await initializeDateFormatting();
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  // WidgetsFlutterBinding.ensureInitialized();
  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '${Env.KAKAO_NATIVE_APP_KEY}',
    javaScriptAppKey: '${Env.KAKAO_JAVASCRIPT_APP_KEY}', // 웹 까지 할떄
  );
  runApp(
    ProviderScope(
      child: _App(),
    ),
  );
}

class _App extends ConsumerWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        fontFamily: 'NotoSans',
        primaryColor: SELECT_TEXT_COLOR,
        shadowColor: SELECT_TEXT_COLOR,
      ),
      // home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
