import 'package:amatta_front/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinScreen extends ConsumerStatefulWidget {
  static String get routeName => "JoinScreen";
  const JoinScreen({super.key});

  @override
  ConsumerState<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends ConsumerState<JoinScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "회원가입",
      topAppBarBtn: false,
      child: Center(
        child: Text("회원가입 화면"),
      ),
    );
  }
}
