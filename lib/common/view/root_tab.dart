import 'package:amatta_front/category/view/category_screen.dart';
import 'package:amatta_front/chat/view/chat_room_list.dart';
import 'package:amatta_front/common/components/action_button.dart';
import 'package:amatta_front/common/components/custom_floating_action_button.dart';
import 'package:amatta_front/common/const/color.dart';
import 'package:amatta_front/common/layout/default_layout.dart';
import 'package:amatta_front/common/model/permission_model.dart';
import 'package:amatta_front/common/provider/permission_provider.dart';
import 'package:amatta_front/common/view/splash_screen.dart';
import 'package:amatta_front/list/view/main_list_screen.dart';
import 'package:amatta_front/user/model/user_model.dart';
import 'package:amatta_front/user/provider/user_auth_provider.dart';
import 'package:amatta_front/user/view/login_screen.dart';
import 'package:amatta_front/user/view/my_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'rootTab';
  final int indexNumber;
  const RootTab({super.key, this.indexNumber = 0});

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab>
    with TickerProviderStateMixin {
  late TabController controller;
  late AnimationController animationController;
  late int index = widget.indexNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = BottomSheet.createAnimationController(this);
    animationController
      ..duration = Duration(milliseconds: 500)
      ..reverseDuration = Duration(milliseconds: 500);
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);
  }

  //bottomNavigationBar 와 TabBarView 를 연동시키는 방법 !
  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    controller.removeListener(tabListener);
    // TODO: implemet dispose

    super.dispose();
  }

  Future<PermissionStatus> initPermission() async {
    final permission = await Permission.calendarFullAccess.request();
    print(Permission.calendarFullAccess.runtimeType == Permission);
    if (permission != PermissionStatus.granted) {
      showDialog(
          context: context,
          barrierDismissible: false,
          // barrierColor: Colors.white,
          builder: (context) {
            return AlertDialog(
              content: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.height / 10,
                child: Center(
                    child: Text(
                  "접근권한을 허용해 주세요.",
                  style: defaultTextStyle.copyWith(fontWeight: FontWeight.w700),
                )),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      openAppSettings();
                    },
                    child: Text("확인"))
              ],
            );
          });

      // throw "캘린더 접근권한이 없습니다.";
    }
    return permission;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userAuthProvider);
    final permission = ref.watch(permissionProvider);
    // if (permission is PermissionLoading) {
    //   return SplashScreen();
    // }
    // return FutureBuilder(
    //     future: initPermission(),
    //     builder: (context, snapshot) {
    //       print("snapshot : ${snapshot.data}");
    //       return snapshot.data != PermissionStatus.granted
    //           ? SplashScreen()
    //           : AnimatedSwitcher(
    //               duration: Duration(milliseconds: 500),
    //               child: _rootTab(state: state),
    //             );
    //     });
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: permission is PermissionGranted
            ? SplashScreen()
            : _rootTab(state: state));
  }

  Widget _rootTab({required UserModelBase? state}) {
    List<dynamic> tabList = [
      {"title": "AMATTA", "child": MainListScreen()},
      {"title": "카테고리", "child": CategoryScreen()},
      {"title": "메세지", "child": ChatRoomList()},
      {
        "title": state is UserMinModel ? "메이페이지" : null,
        "child": _MyPageOrLoginPageLayout(isLogin: state is UserMinModel)
      },
    ];
    if (state is UserModelLoading
        //    || state is UserModelError
        ) {
      return SplashScreen();
    }
    if (state is UserModelError) {
      state = UserModelGuest();
    }
    return DefaultLayout(
        title: tabList[index]["title"],
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: tabList.map((e) => e["child"] as Widget).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: SELECT_TEXT_COLOR,
          unselectedItemColor: UNSELECT_TEXT_COLOR,
          backgroundColor: BACK_GROUND_COLOR,
          elevation: 1,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            if (index == 3 && state is UserModelGuest) {
              loginBottomSheet(context, animationController);
              return;
            }
            controller.animateTo(index);
          },
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(index == 0 ? Icons.home : Icons.home_outlined),
              label: "메인",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                    index == 1 ? Icons.interests : Icons.interests_outlined),
                label: "카테고리"),
            BottomNavigationBarItem(
                icon:
                    Icon(index == 2 ? Icons.groups_2 : Icons.groups_2_outlined),
                label: "메세지"),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.accessibility_new_outlined), label: "로그인"),
            BottomNavigationBarItem(
                icon: Icon(
                  index == 3
                      ? Icons.account_circle
                      : Icons.account_circle_outlined,
                ),
                label: state is UserMinModel ? "마이페이지" : "로그인"),
          ],
        ),
        floatingActionButton:
            // _floatingActionButtons(),
            CustomFloatingActionButton(
          distance: 70,
          children: [
            ActionButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_chart,
              ),
              label: "대시보드",
            ),
            ActionButton(
              onPressed: () {},
              icon: Icon(Icons.handshake),
              label: "일정추가",
            ),
            ActionButton(
              onPressed: () {},
              icon: Icon(Icons.group_add),
              label: "방만들기",
            ),
            ActionButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
              ),
              label: "설정",
            ),
          ],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }

  Widget _MyPageOrLoginPageLayout({required bool isLogin}) {
    return MyPageScreen();
    // return isLogin ? MyPageScreen() : LoginScreen();
  }
}
