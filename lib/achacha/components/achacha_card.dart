import 'dart:math';

import 'package:amatta_front/common/const/color.dart';
import 'package:flutter/material.dart';

class AchachaCard extends StatelessWidget {
  final dynamic model;
  final VoidCallback? onTap;
  const AchachaCard({super.key, this.model, this.onTap});

  @override
  Widget build(BuildContext context) {
    final _random = Random();
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height / 10,
          decoration: BoxDecoration(
              color: Color.fromRGBO(_random.nextInt(127) + 128,
                  _random.nextInt(127) + 128, _random.nextInt(127) + 128, 1
                  // _random.nextInt(127) + 128,
                  ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: UNSELECT_TEXT_COLOR,
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  offset: const Offset(3, 3),
                ),
              ]),
          child: model == null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 40,
                    ),
                    Text(
                      "아차차 차차",
                      style: defaultTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
              : Text(
                  "아차차 이름이요",
                  style: defaultTextStyle.copyWith(
                      fontSize: 24, fontWeight: FontWeight.w700),
                ),
        ),
      ),
    );
  }
}
