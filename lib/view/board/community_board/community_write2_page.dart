import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/loading.dart';
import 'package:app_front_talearnt/common/widget/toast_message.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/view_model/board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../provider/board/community_write_provider.dart';
import '../../../provider/common/common_provider.dart';
import 'community_write_editor_toolbar.dart';

class CommunityWrite2Page extends StatelessWidget {
  const CommunityWrite2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final communityWriteProvider = Provider.of<CommunityWriteProvider>(context);
    final boardViewModel = Provider.of<BoardViewModel>(context);
    final CommonProvider commonProvider = Provider.of<CommonProvider>(context);

    ScrollController scrollController = ScrollController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: TopAppBar(
        onPressed: () {
          context.go('/community-write1');
        },
        second: TextBtnM(
          content: '미리보기',
          onPressed: () {
            communityWriteProvider.checkTitleAndBoard();

            if (communityWriteProvider.isTitleAndBoardEmpty) {
              communityWriteProvider.makePreviewImageList();
              commonProvider.updateBackGesture(false);
              context.push('/community-preview');
            } else {
              ToastMessage.show(
                  context: context,
                  message: communityWriteProvider.boardToastMessage,
                  type: 2,
                  bottom: 50);
            }
          },
        ),
        first: PrimaryS(
          content: '등록',
          onPressed: () async {
            commonProvider.changeIsLoading(true);
            await communityWriteProvider.getUploadImagesInfo();

            if (communityWriteProvider.uploadImageInfo.isNotEmpty) {
              await boardViewModel.getImageUploadUrl(
                  communityWriteProvider.uploadImageInfo, 'CW');

              for (int idx = 0;
                  idx < communityWriteProvider.imageUploadUrls.length;
                  idx++) {
                await boardViewModel.uploadImage(
                    communityWriteProvider.imageUploadUrls[idx],
                    communityWriteProvider.uploadImageInfo[idx]["file"],
                    communityWriteProvider.uploadImageInfo[idx]["fileSize"],
                    communityWriteProvider.uploadImageInfo[idx]["fileType"],
                    "CW");
              }

              communityWriteProvider.finishImageUpload();
            }

            communityWriteProvider.checkTitleAndBoard();

            if (communityWriteProvider.isTitleAndBoardEmpty) {
              communityWriteProvider.insertCommunityBoard();

              await boardViewModel.setCommunityBoard(
                communityWriteProvider.titleController.text,
                communityWriteProvider.htmlContent,
                communityWriteProvider.selectedCategory,
                communityWriteProvider.imageUploadedUrls,
              );
            } else {
              ToastMessage.show(
                context: context,
                message: communityWriteProvider.boardToastMessage,
                type: 2,
                bottom: 50,
              );
            }
            commonProvider.changeIsLoading(false);
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
          child: const CommunityWriteEditorToolbar(),
        ),
      ),
      body: Stack(
        children: [
          Padding(
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
                  controller: communityWriteProvider.titleController,
                  focusNode: communityWriteProvider.titleFocusNode,
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
                    controller: communityWriteProvider.contentController,
                    focusNode: communityWriteProvider.contentFocusNode,
                    scrollController: scrollController,
                    config: QuillEditorConfig(
                      embedBuilders: FlutterQuillEmbeds.editorBuilders(
                          imageEmbedConfig: QuillEditorImageEmbedConfig(
                              onImageClicked: (String image) {})),
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
          if (commonProvider.isLoadingPage) const LoadingWithCharacter()
        ],
      ),
    );
  }
}
