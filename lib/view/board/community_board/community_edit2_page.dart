import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/toast_message.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/provider/board/community_edit_provider.dart';
import 'package:app_front_talearnt/view_model/board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../provider/common/common_provider.dart';
import 'community_edit_editor_toolbar.dart';

class CommunityEdit2Page extends StatelessWidget {
  const CommunityEdit2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final communityEditProvider = Provider.of<CommunityEditProvider>(context);
    final boardViewModel = Provider.of<BoardViewModel>(context);
    final CommonProvider commonProvider = Provider.of<CommonProvider>(context);

    ScrollController scrollController = ScrollController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: TopAppBar(
        onPressed: () {
          context.go('/community-edit1');
        },
        second: TextBtnM(
          content: '미리보기',
          onPressed: () {
            communityEditProvider.checkTitleAndBoard();

            if (communityEditProvider.isTitleAndBoardEmpty) {
              communityEditProvider.makePreviewImageList();
              commonProvider.updateBackGesture(false);
              context.push('/community-edit-preview');
            } else {
              ToastMessage.show(
                  context: context,
                  message: communityEditProvider.boardToastMessage,
                  type: 2,
                  bottom: 50);
            }
          },
        ),
        first: PrimaryS(
          content: '완료',
          onPressed: () async {
            await communityEditProvider.getUploadImagesInfo();

            if (communityEditProvider.uploadImageInfos.isNotEmpty) {
              await boardViewModel.getImageUploadUrl(
                  communityEditProvider.uploadImageInfos, "CE");

              for (int idx = 0;
                  idx < communityEditProvider.imageUploadUrls.length;
                  idx++) {
                await boardViewModel.uploadImage(
                    communityEditProvider.imageUploadUrls[idx],
                    communityEditProvider.uploadImageInfos[idx]["file"],
                    communityEditProvider.uploadImageInfos[idx]["fileSize"],
                    communityEditProvider.uploadImageInfos[idx]["fileType"],
                    "CE");
              }

              communityEditProvider.finishImageUpload();
            }

            communityEditProvider.checkTitleAndBoard();

            if (communityEditProvider.isTitleAndBoardEmpty) {
              communityEditProvider.setCommunityBoard();

              await boardViewModel.editCommunityBoard(
                communityEditProvider.titleController.text,
                communityEditProvider.htmlContent,
                communityEditProvider.selectedCategory,
                communityEditProvider.imageUploadedUrls,
                communityEditProvider.postNo,
              );
            } else {
              ToastMessage.show(
                context: context,
                message: communityEditProvider.boardToastMessage,
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
          child: const CommunityEditEditorToolbar(),
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
              controller: communityEditProvider.titleController,
              focusNode: communityEditProvider.titleFocusNode,
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
                controller: communityEditProvider.contentController,
                focusNode: communityEditProvider.contentFocusNode,
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
