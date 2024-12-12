import 'package:amatta_front/amatta/model/scheduler_model.dart';
import 'package:amatta_front/common/const/color.dart';
import 'package:amatta_front/common/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final DateTime focusedDay;
  final OnDaySelected onDaySelected;
  final bool Function(DateTime day) selectedDayPredicate;
  final List<SchedulerModel>? schedulerModels;
  const Calendar({
    super.key,
    required this.focusedDay,
    required this.onDaySelected,
    required this.selectedDayPredicate,
    this.schedulerModels,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle defaultCalendarStyle = defaultTextStyle.copyWith(fontSize: 12);
    return TableCalendar(
      locale: 'ko_KR',
      focusedDay: focusedDay,
      firstDay: DateTime.utc(1900, 1, 01),
      lastDay: DateTime.utc(9999, 12, 31),
      onDaySelected: onDaySelected,
      selectedDayPredicate: selectedDayPredicate,
      headerStyle: HeaderStyle(headerMargin: EdgeInsets.all(2)),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: defaultCalendarStyle,
        // weekendStyle: defaultCalendarStyle.copyWith(
        //   color: Colors.red,
        // ),
      ),
      calendarStyle: CalendarStyle(),
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          final text = DateFormat.E('ko_KR').format(day);
          return Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            height: double.infinity,
            child: Text(
              text,
              style: defaultTextStyle.copyWith(
                  color: day.weekday == DateTime.sunday
                      ? Colors.red
                      : day.weekday == DateTime.saturday
                          ? Colors.blue
                          : SELECT_TEXT_COLOR,
                  fontSize: 10),
            ),
          );
          // 요일 부분 커스텀
        },
        defaultBuilder: (context, day, focusedDay) {
          // 기본스타일
          final text = day.day.toString();

          return Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _dayOfCustom(
                  day: day,
                  text: text,
                  opacity: 0.6,
                ),
                if (schedulerModels != null)
                  ...(schedulerModels!.map((model) {
                    return _SchedulerRange(
                        model: model, day: day, focusedDay: focusedDay);
                  }).toList()),
              ],
            ),
          );
        },
        selectedBuilder: (context, day, focusedDay) {
          // 선택영역
          final text = day.day.toString();
          return Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _dayOfCustom(
                    day: day,
                    text: text,
                    opacity: 1,
                    fontWeight: FontWeight.w800,
                    textColor: SELECT_TEXT_COLOR),
                if (schedulerModels != null)
                  ...(schedulerModels!.map((model) {
                    return _SchedulerRange(
                        model: model, day: day, focusedDay: focusedDay);
                  }).toList()),
              ],
            ),
          );
        },
        todayBuilder: (context, day, focusedDay) {
          //오늘!
          final text = day.day.toString();
          return Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _dayOfCustom(
                    day: day,
                    text: text,
                    opacity: 1,
                    fontWeight: FontWeight.w800,
                    textColor: Colors.red),
                if (schedulerModels != null)
                  ...(schedulerModels!.map((model) {
                    return _SchedulerRange(
                        model: model, day: day, focusedDay: focusedDay);
                  }).toList()),
              ],
            ),
          );
        },
        outsideBuilder: (context, day, focusedDay) {
          //이번달 아닌영역
          final text = day.day.toString();
          return Container(
              alignment: Alignment.topLeft,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _dayOfCustom(day: day, text: text, opacity: 0.2),
                    if (schedulerModels != null)
                      ...(schedulerModels!.map((model) {
                        return _SchedulerRange(
                            model: model, day: day, focusedDay: focusedDay);
                      }).toList()),
                  ]));
        },
        headerTitleBuilder: (context, day) {
          final text = day.year.toString();
          return GestureDetector(
              onTap: () {
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: SizedBox(
                          child: Text("ㅎㅇ"),
                        ),
                        actions: [
                          ElevatedButton(onPressed: () {}, child: Text("확인")),
                          ElevatedButton(onPressed: () {}, child: Text("취소")),
                        ],
                      );
                    });
              },
              child: Text(text));
        },
      ),
    );
  }
}

Widget _SchedulerRange(
    {required SchedulerModel model,
    required DateTime day,
    required DateTime focusedDay}) {
  // 크면 -1
  // 작으면 1
  // 같으면 0
  //시작 날짜와 오늘이 같고, 끝날자도 똑같다면!
  if (focusedDay.compareTo(day) == 0) {
    print(focusedDay.isBefore(model.startDate));
  }

  // 시작 보다 크고 엔드보다 작을떄
  final int startCompareToDay = model.startDate.compareTo(day);
  final int startCompareToEnd = model.startDate.compareTo(model.endDate);
  final int endCompareToDay = model.endDate.compareTo(day);
  if (startCompareToDay == 0 && startCompareToEnd == 0) {
    return _ScheduleStick(
        topRight: 5, bottomRight: 5, topLeft: 5, bottomLeft: 5);
  }
  // 일정시작 날짜인데. 일정종료일자가 같지 않다면 일정 시작날 인거임
  if (startCompareToDay == 0 && startCompareToEnd != 0) {
    return _ScheduleStick(topLeft: 5, bottomLeft: 5);
  }
  //일정 중간 일때.
  if (startCompareToDay == -1 && endCompareToDay == 1) {
    return _ScheduleStick();
  }
  if (endCompareToDay == 0 && startCompareToEnd != 0) {
    return _ScheduleStick(topRight: 5, bottomRight: 5);
  }
  return _ScheduleStick(isVisible: false);
}

Widget _dayOfCustom(
    {required double opacity,
    required String text,
    required DateTime day,
    FontWeight? fontWeight,
    Color textColor = UNSELECT_TEXT_COLOR}) {
  return Text(
    text,
    style: defaultTextStyle.copyWith(
      fontSize: 10,
      fontWeight: fontWeight ?? defaultTextStyle.fontWeight,
      color: day.weekday == DateTime.sunday
          ? Colors.red.withOpacity(opacity)
          : day.weekday == DateTime.saturday
              ? Colors.blue.withOpacity(opacity)
              : textColor.withOpacity(opacity),
    ),
    // 텍스트 영역 커스텀 가능
  );
}

// startDate ~ endDate 쉽지않네.
// 일자별로 일정을 만들어주는 건어떨까 ? 라고 생각함
// TODO : 시작 날짜 시작 시간, 끝 날짜 끝 시간, 일정이 11~17일이면 11 ,12, 13,14,15,16,17 의 데이터가 각각 쌓여야하고  그걸로 관리 해야하는거아님 ? 이걸
// TODO : 일정이 겹치는게 있다면. 빈걸넣어놓고. 일정이 겹치는게 없다면 빈걸 삭제해 ? ->
Widget _ScheduleStick(
    {double? topRight = 0.0,
    double? bottomRight = 0.0,
    double? topLeft = 0.0,
    double? bottomLeft = 0.0,
    bool? isVisible = true,
    double? withOpacity = 0.5}) {
  return Column(
    children: [
      SizedBox(
        width: double.infinity,
        height: 10,
        child: Container(
          decoration: BoxDecoration(
              color: isVisible!
                  ? Colors.red.withOpacity(withOpacity!)
                  : Colors.transparent,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(topRight!),
                bottomRight: Radius.circular(bottomRight!),
                topLeft: Radius.circular(topLeft!),
                bottomLeft: Radius.circular(bottomLeft!),
              )),
        ),
      ),
      SizedBox(
        height: 2,
      )
    ],
  );
}
