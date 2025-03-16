import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../provider/board/community_board_detail_provider.dart';

class CommunityBoardImageViewPage extends StatelessWidget {
  const CommunityBoardImageViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final communityBoardDetailProvider =
        Provider.of<CommunityBoardDetailProvider>(context);
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
            ...communityBoardDetailProvider.previewImageList
                .asMap()
                .entries
                .map((entry) {
              int index = entry.key;
              var item = entry.value;
              double imageSize = MediaQuery.of(context).size.width / 3;

              return GestureDetector(
                onTap: () {
                  communityBoardDetailProvider.setPreviewImageIndex(index);
                  context.push(
                      '/community-board-detail/community-image-view-detail');
                },
                child: Image.file(
                  item,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
