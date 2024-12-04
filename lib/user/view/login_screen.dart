import 'package:amatta_front/common/components/login_button.dart';
import 'package:amatta_front/common/const/color.dart';
import 'package:amatta_front/common/enumeration/social.dart';
import 'package:amatta_front/common/view/root_tab.dart';
import 'package:amatta_front/user/model/user_model.dart';
import 'package:amatta_front/user/provider/user_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => "loginScreen";
  final AnimationController? animationController;
  const LoginScreen({
    super.key,
    this.animationController,
  });

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userAuthProvider);
    if (state is UserMinModel) {
      widget.animationController?.animateTo(0);
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("AMATTA",
              style: defaultTextStyle.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                  color: GOOGLE_PRIMARY_COLOR)),
          Text(
            "로그인 방법을 선택하세요.",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 15,
            width: double.infinity,
          ),
          _googleLoginButton(onPressed: () async {
            await onLoginHandler(
                context: context, platform: SocialTypeCode.GOOGLE.code);
          }),
          SizedBox(
            height: 15,
          ),
          _kakaoLoginButton(onPressed: () async {
            await onLoginHandler(
                context: context, platform: SocialTypeCode.KAKAO.code);
          }),
          SizedBox(
            height: 15,
          ),
          // TODO : 이메일 로그인 ui 만들기
          _emailLoginButton(onPressed: () {})
          // _NaverLoginButton(onPressed: () async {
          //   await onLoginHandler(
          //       context: context, platform: SocialTypeCode.NAVER.code);
          // }),
        ],
      ),
    );
  }

  Future<void> onLoginHandler(
      {required String platform, required BuildContext context}) async {
    UserModelBase? model =
        await ref.read(userAuthProvider.notifier).login(platform: platform);
    if (model is UserMinModel) {
      context.goNamed(RootTab.routeName);
    }
  }

  Widget _googleLoginButton({required VoidCallback? onPressed}) {
    return LoginButton(
      onPressed: onPressed,
      svgPath: 'asset/svg/btn_google2.svg',
      // iconHeight: 25,
      label: "Google로 로그인",
      backgroundColor: GOOGLE_PRIMARY_COLOR,
      labelColor: KAKAO_LABEL_COLOR,
    );
  }

  Widget _kakaoLoginButton({required VoidCallback? onPressed}) {
    return LoginButton(
      onPressed: onPressed,
      svgPath: 'asset/svg/btn_kakao.svg',
      label: "KaKao로 로그인",
      backgroundColor: KAKAO_CONTAINER_COLOR,
      labelColor: KAKAO_LABEL_COLOR,
    );
  }

  Widget _emailLoginButton({required VoidCallback? onPressed}) {
    return LoginButton(
      onPressed: onPressed,
      svgPath: 'asset/svg/btn_kakao.svg',
      label: "Email로 로그인",
      backgroundColor: PRIMARY_COLOR6,
      labelColor: KAKAO_LABEL_COLOR,
    );
  }
  // Widget _NaverLoginButton({required VoidCallback? onPressed}) {
  //   return LoginButton(
  //       onPressed: onPressed,
  //       svgPath: 'asset/svg/btn_naver.svg',
  //       label: 'Naver로 로그인',
  //       backgroundColor: NAVER_PRIMARY_COLOR);
  // }
}

Future<T?> loginBottomSheet<T>(
    BuildContext context, AnimationController transitionAnimationController) {
  return showModalBottomSheet(
    transitionAnimationController: transitionAnimationController,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      // return AlertDialog(
      //   backgroundColor: Colors.transparent,
      //   elevation: 10.0,
      //   content: LoginScreen(),
      // );
      return Container(
          height: MediaQuery.of(context).size.height / 2,
          // padding: EdgeInsets.only(bottom: 50),
          margin: const EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 40,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: UNSELECT_TEXT_COLOR.withOpacity(0.3),
              width: 1,
            ),
            color: ICON_DEFAULT_COLOR, // BACK_GROUND_COLOR.withOpacity(0.8),
          ),
          child:
              LoginScreen(animationController: transitionAnimationController));
    },
  );
}