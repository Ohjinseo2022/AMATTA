import 'package:amatta_front/achacha/components/achacha_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AchachaMainScreen extends ConsumerStatefulWidget {
  static String get routeName => 'achachaMain';
  const AchachaMainScreen({super.key});

  @override
  ConsumerState<AchachaMainScreen> createState() => _AchachaMainScreenState();
}

class _AchachaMainScreenState extends ConsumerState<AchachaMainScreen> {
  final int lengthIndex = 20;
  @override
  Widget build(BuildContext context) {
    // return PaginationListView(
    //     provider: chatProvider, // 리스트형태의 데이터 조회 함
    //     itemBuilder: <IModelWithId>(_, index, model) {
    //       return GestureDetector();
    //     });
    return ListView.separated(
      itemBuilder: (context, index) {
        if (index == lengthIndex - 1) {
          return AchachaCard(onTap: () {
            print("신규생성");
          });
        }
        return Padding(
          padding: EdgeInsets.only(
              top: index == 0 && lengthIndex < 6
                  ? MediaQuery.of(context).size.height / 10
                  : 0),
          child: AchachaCard(
              model: index,
              onTap: () {
                print("상세이동");
              }),
        );
      },
      itemCount: lengthIndex,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 16,
        );
      },
    );
  }
}
