import 'package:amatta_front/category/view/category_screen.dart';
import 'package:amatta_front/chat/view/chat_room_detail.dart';
import 'package:amatta_front/common/view/root_tab.dart';
import 'package:amatta_front/common/view/splash_screen.dart';
import 'package:amatta_front/list/view/main_list_screen.dart';
import 'package:amatta_front/user/provider/user_auth_provider.dart';
import 'package:amatta_front/user/view/login_screen.dart';
import 'package:amatta_front/user/view/my_page_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({required this.ref}) {
    ref.listen(userAuthProvider, (previous, next) {
      if (previous != next) {
        // 라우팅 이 변경될때만 동작하게 설정
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, state) => RootTab(),
          routes: [
            GoRoute(
                path: "chat-room/:id",
                name: ChatRoomDetail.routeName,
                builder: (_, state) => ChatRoomDetail(
                      chatRoomId: state.pathParameters['id']!,
                    ))
          ],
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, state) => LoginScreen(),
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, state) => SplashScreen(),
        ),
        GoRoute(
          path: '/category',
          name: CategoryScreen.routeName,
          builder: (_, state) => CategoryScreen(),
        ),
        GoRoute(
          path: '/myPage',
          name: MyPageScreen.routeName,
          builder: (_, state) => MyPageScreen(),
        ),
        GoRoute(
          path: '/mainList',
          name: MainListScreen.routeName,
          builder: (_, state) => MainListScreen(),
        ),
        // GoRoute(
        //     path: '/chat-room',
        //     name: ChatRoomList.routeName,
        //     builder: (_, state) => ChatRoomList(),
        //     routes: [
        //       GoRoute(
        //           path: "detail/:id",
        //           name: ChatRoomDetail.routeName,
        //           builder: (_, state) => ChatRoomDetail(
        //                 chatRoomId: state.pathParameters['id']!,
        //               ))
        //     ])
      ];

  /**
   * 첫 시작은 스플래시 스크린
   * 앱 시작 후 로그인 됐는지 확인 필요 . 로그인이 필수는 아니지만
   * 로그인 기능이 필요한 경우 로그인 처리를 미리 해놓을 필요가 있음 !
   */
  String? redirectLogic(GoRouterState state) {
    return null;
    // print(state.location);
    // final loginGo = state.location == '/login';
    // // if (state.location == '/splash') {
    // //
    // //   return '/login';
    // // }
    // if (loginGo) {
    //   await Future.delayed(Duration(milliseconds: 1500));
    //   return '/login';
    // } else {
    //   return '/splash';
    // }
  }
}
