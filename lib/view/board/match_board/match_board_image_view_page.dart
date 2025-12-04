import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../provider/board/match_board_detail_provider.dart';

class MatchBoardImageViewPage extends StatelessWidget {
  const MatchBoardImageViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final matchBoardDetailProvider =
        Provider.of<MatchBoardDetailProvider>(context);
    return Scaffold(
      appBar: TopAppBar(
        content: '이미지 모아보기 ',
        onPressed: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            ...matchBoardDetailProvider.previewImageList
                .asMap()
                .entries
                .map((entry) {
              int index = entry.key;
              var item = entry.value;
              double imageSize = MediaQuery.of(context).size.width / 3;

              return GestureDetector(
                onTap: () {
                  matchBoardDetailProvider.setPreviewImageIndex(index);
                  context.push(
                      '/board-list/match-board-detail-page/match-image-view-detail');
                },
                child: Container(
                  child: Image.network(
                    item,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
