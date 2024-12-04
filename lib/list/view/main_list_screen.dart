import 'package:flutter/material.dart';

class MainListScreen extends StatelessWidget {
  static String get routeName => 'mainListScreen';
  const MainListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('메인리스트 & 홈'),
    );
  }
}
