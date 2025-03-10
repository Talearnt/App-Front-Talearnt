import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/toast_message.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/view/board/match_board/match_write_editor_toolbar.dart';
import 'package:app_front_talearnt/view_model/board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../provider/board/match_write_provider.dart';

class MatchWrite2Page extends StatelessWidget {
  const MatchWrite2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final matchWriteProvider = Provider.of<MatchWriteProvider>(context);
    final boardViewModel = Provider.of<BoardViewModel>(context);

    ScrollController scrollController = ScrollController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: TopAppBar(
        onPressed: () {
          context.go('/match_write1');
        },
        second: TextBtnM(
          content: '미리보기',
          onPressed: () {
            matchWriteProvider.checkTitleAndBoard();

            if (matchWriteProvider.isTitleAndBoardEmpty) {
              matchWriteProvider.makePreviewImageList();
              context.push('/match-write-preview');
            } else {
              ToastMessage.show(
                  context: context,
                  message: matchWriteProvider.boardToastMessage,
                  type: 2,
                  bottom: 50);
            }
          },
        ),
        first: PrimaryS(
          content: '등록',
          onPressed: () async {
            await matchWriteProvider.getUploadImagesInfo();

            if (matchWriteProvider.uploadImageInfos.isNotEmpty) {
              await boardViewModel.getImageUploadUrl(
                  matchWriteProvider.uploadImageInfos, "W");

              for (int idx = 0;
                  idx < matchWriteProvider.imageUploadUrls.length;
                  idx++) {
                await boardViewModel.uploadImage(
                  matchWriteProvider.imageUploadUrls[idx],
                  matchWriteProvider.uploadImageInfos[idx]["file"],
                  matchWriteProvider.uploadImageInfos[idx]["fileSize"],
                  matchWriteProvider.uploadImageInfos[idx]["fileType"],
                  "W",
                );
              }

              matchWriteProvider.finishImageUpload();
            }

            matchWriteProvider.checkTitleAndBoard();

            if (matchWriteProvider.isTitleAndBoardEmpty) {
              matchWriteProvider.insertMatchBoard();

              await boardViewModel.insertMatchBoard(
                matchWriteProvider.titleController.text,
                matchWriteProvider.htmlContent,
                matchWriteProvider.selectedGiveTalentKeywordCodes,
                matchWriteProvider.selectedInterestTalentKeywordCodes,
                matchWriteProvider.selectedExchangeType,
                false,
                matchWriteProvider.selectedDuration,
                matchWriteProvider.imageUploadedUrls,
              );
            } else {
              ToastMessage.show(
                context: context,
                message: matchWriteProvider.boardToastMessage,
                type: 2,
                bottom: 50,
              );
            }
          },
        ),
      ),
      bottomNavigationBar: AnimatedPadding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        duration: const Duration(milliseconds: 0),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Palette.line01,
                width: 1.0,
              ),
            ),
          ),
          child: const MatchWriteEditorToolbar(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          left: 24,
          right: 24,
        ),
        child: Column(
          children: [
            // 제목 입력 필드
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "제목을 입력해주세요",
                hintStyle: TextTypes.heading2(
                  color: Palette.text04,
                ),
              ),
              style: TextTypes.heading2(
                color: Palette.text02,
              ),
              controller: matchWriteProvider.titleController,
              focusNode: matchWriteProvider.titleFocusNode,
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(
              color: Palette.bgUp02,
              thickness: 1.0,
            ),
            const SizedBox(
              height: 16,
            ),

            Expanded(
              child: QuillEditor(
                controller: matchWriteProvider.contentController,
                focusNode: matchWriteProvider.contentFocusNode,
                scrollController: scrollController,
                configurations: QuillEditorConfigurations(
                  embedBuilders: FlutterQuillEmbeds.editorBuilders(),
                  placeholder: "내용을 입력해주세요",
                  expands: true,
                  customStyles: DefaultStyles(
                    placeHolder: DefaultTextBlockStyle(
                      TextTypes.body02(color: Palette.text04),
                      const HorizontalSpacing(10, 10),
                      const VerticalSpacing(10, 10),
                      const VerticalSpacing(10, 10),
                      null,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
