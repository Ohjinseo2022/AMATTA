import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  static String get routeName => 'categoryScreen';
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('카테고리 선택'),
    );
  }
}
