import 'package:amatta_front/common/const/color.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String label;
  const ActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          child: Column(
            children: [
              icon,
              Text(
                label,
                style: TextStyle(fontSize: 8.0),
              ),
            ],
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: BACK_GROUND_COLOR,
            foregroundColor: SELECT_TEXT_COLOR,
            elevation: 10,
            shape: CircleBorder(),
          ),
        ),
      ],
    );
  }
}