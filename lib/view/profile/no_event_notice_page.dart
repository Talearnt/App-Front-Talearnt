import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../common/widget/button.dart';
import '../../provider/common/common_provider.dart';
import '../../view_model/board_view_model.dart';

class NoEventNoticePage extends StatelessWidget {
  final String type; //event, notice

  const NoEventNoticePage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final commonProvider = Provider.of<CommonProvider>(context);
    final boardViewModel = Provider.of<BoardViewModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                type == 'event' ? '등록된 이벤트가 없어요' : '등록된 공지사항이 없어요',
                style: TextTypes.heading4(color: Palette.text01),
              ),
              const SizedBox(height: 8),
              Text(
                type == 'event' ? '좋은 이벤트를 가져올게요' : '좋은 소식을 가져올게요',
                style: TextTypes.body02(color: Palette.text03),
              ),
              Text(
                '조금만 기다려 주세요',
                style: TextTypes.body02(color: Palette.text03),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PrimaryM(
              content: '매칭 구경하러 가기',
              onPressed: () async {
                commonProvider.changeIsLoading(true);
                await boardViewModel.getInitMatchBoardList().whenComplete(() {
                  commonProvider.changeSelectedPage('board_list');
                  commonProvider.changeIsLoading(false);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
