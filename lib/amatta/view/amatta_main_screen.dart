import 'package:amatta_front/amatta/components/calendar.dart';
import 'package:amatta_front/amatta/model/scheduler_model.dart';
import 'package:amatta_front/common/components/toggle_button.dart';
import 'package:amatta_front/common/layout/default_layout.dart';
import 'package:amatta_front/common/utils/data_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AmattaMainScreen extends ConsumerStatefulWidget {
  static String get routeName => 'amattaMain';
  const AmattaMainScreen({super.key});

  @override
  ConsumerState<AmattaMainScreen> createState() => _AmattaMainScreenState();
}

class _AmattaMainScreenState extends ConsumerState<AmattaMainScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final schedulerModels = [
      SchedulerModel(
          id: "1421412",
          scheduleName: "일정1 ",
          startDate: DataUtils.stringToDateTime("2024-12-07"),
          endDate: DataUtils.stringToDateTime("2024-12-10"),
          createdDate: "2024-12-10"),
      SchedulerModel(
          id: "142143ㄹ12",
          scheduleName: "일정2 ",
          startDate: DataUtils.stringToDateTime("2024-12-11"),
          endDate: DataUtils.stringToDateTime("2024-12-15"),
          createdDate: "2024-12-10"),
      SchedulerModel(
          id: "142143ㄹ12",
          scheduleName: "일정2 ",
          startDate: DataUtils.stringToDateTime("2024-12-18"),
          endDate: DataUtils.stringToDateTime("2024-12-25"),
          createdDate: "2024-12-10"),
    ];
    return DefaultLayout(
      child: Column(
        children: [
          Calendar(
            focusedDay: focusedDay,
            onDaySelected: onDaySelected,
            selectedDayPredicate: selectedDayPredicate,
            schedulerModels: schedulerModels,
          ),
        ],
      ),
    );
  }

  void onDaySelected(selectedDay, focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = focusedDay;
    });
  }

  bool selectedDayPredicate(DateTime day) {
    // 날짜가 선택된 날짜로 마킹해줄지 결정해주는 함수
    // print('--------');
    // print("선택한 날짜: " + day.toString());
    // print("비교할 날짜: " + this.selectedDay.toString());
    // flutter: 선택한 날짜: 2024-07-06 00:00:00.000Z
    // flutter: 비교할 날짜: 2024-06-12 00:00:00.000
    // 타임존 확인 필요
    if (this.selectedDay == null) {
      return false;
    } else {
      return day.isAtSameMomentAs(this.selectedDay!);
    }
  }
}
