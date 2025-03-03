import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:app_front_talearnt/view_model/keyword_view_model.dart';
import 'package:app_front_talearnt/provider/board/match_edit_provider.dart';
import '../../../provider/board/match_board_detail_provider.dart';
import 'package:provider/provider.dart';

class ModifyBoardBottomSheet extends StatelessWidget {
  final bool isMine;

  const ModifyBoardBottomSheet({
    super.key,
    required this.isMine,
  });

  @override
  Widget build(BuildContext context) {
    final keywordViewModel = Provider.of<KeywordViewModel>(context);
    final matchBoardDetailProvider =
        Provider.of<MatchBoardDetailProvider>(context);
    final matchEditProvider = Provider.of<MatchEditProvider>(context);
    return Wrap(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 44, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isMine) ...[
              SizedBox(
                height: 50,
                width: double.infinity,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () async {
                    await keywordViewModel.getOfferedKeywords();
                    await matchEditProvider.setPostInfo(
                        matchBoardDetailProvider.matchingDetailPost);
                    context.push('/match-edit1');
                  },
                  child: Center(
                    // 가운데 정렬
                    child: Text(
                      "수정하기", // 문자열은 따옴표로 감싸야 함
                      style: TextTypes.body02(
                        color: Palette.text01,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Palette.line02,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () {
                    context.pop();
                  },
                  child: Center(
                    // 가운데 정렬
                    child: Text(
                      "삭제하기", // 문자열은 따옴표로 감싸야 함
                      style: TextTypes.body02(
                        color: Palette.error01,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Palette.line02,
              ),
            ] else
              ...[],
            SizedBox(
              height: 50,
              width: double.infinity,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  context.pop();
                },
                child: Center(
                  // 가운데 정렬
                  child: Text(
                    "취소", // 문자열은 따옴표로 감싸야 함
                    style: TextTypes.body02(
                      color: Palette.text04,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
