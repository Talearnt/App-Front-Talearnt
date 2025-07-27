import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/view_model/board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/theme.dart';
import '../../../common/widget/button.dart';

class NoMatchBoardLikeListPage extends StatelessWidget {
  const NoMatchBoardLikeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final commonProvider = context.read<CommonProvider>();
    final boardViewModel = Provider.of<BoardViewModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: (MediaQuery.of(context).size.height - 424) / 2,
          ),
          SvgPicture.asset('assets/img/mako_like.svg'),
          const SizedBox(height: 28),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '아직 찜한 게시물이 없어요',
                style: TextTypes.heading2(color: Palette.text01),
              ),
              const SizedBox(height: 8),
              Text(
                '마음에 드는 게시물을 찜해보세요!',
                style: TextTypes.bodyMedium01(color: Palette.text02),
              ),
            ],
          ),
          const SizedBox(height: 56),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PrimaryM(
              content: '게시물 찜하러가기',
              onPressed: () async {
                commonProvider.changeIsLoading(true);
                await boardViewModel.getInitMatchBoardList();
                commonProvider.changeSelectedPage('board_list');
                commonProvider.changeIsLoading(false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
