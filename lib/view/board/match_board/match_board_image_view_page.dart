import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import '../../../provider/board/match_write_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatchBoardImageViewPage extends StatelessWidget {
  const MatchBoardImageViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final matchWriteProvider = Provider.of<MatchWriteProvider>(context);
    return Scaffold(
      appBar: TopAppBar(
        content: '이미지 모아보기 ',
        onPressed: () {
          context.go('/match_preview');
        },
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            ...matchWriteProvider.previewImageList.asMap().entries.map((entry) {
              int index = entry.key;
              var item = entry.value;
              double imageSize = MediaQuery.of(context).size.width / 3;

              return GestureDetector(
                onTap: () {
                  matchWriteProvider.setPreviewImageIndex(index);
                  context.push('/match_image_view_detail');
                },
                child: Container(
                  child: Image.file(
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
