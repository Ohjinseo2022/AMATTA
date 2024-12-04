import 'package:amatta_front/common/const/color.dart';
import 'package:amatta_front/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static String get routeName => 'splash';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  // late AnimationController controller;
  @override
  void initState() {
    // controller = AnimationController(
    //   vsync: this,
    //   duration: Duration(seconds: 2),
    // )..addListener(() {
    //     setState(() {});
    //   });
    // controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: BACK_GROUND_COLOR,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset(
            //   'asset/img/main_logo.png',
            //   width: MediaQuery.of(context).size.width / 2,
            // ),
            Container(
              height: 80,
              child: Text(
                "AMATTA",
                style: TextStyle(
                  color: SELECT_TEXT_COLOR,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ),
            // SizedBox(
            //   height: 16.0,
            // ),
            // Container(
            //   width: MediaQuery.of(context).size.width / 2,
            //   child: LinearProgressIndicator(
            //     value: controller.value,
            //     color: UNSELECT_TEXT_COLOR,
            //     backgroundColor: SELECT_TEXT_COLOR,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
