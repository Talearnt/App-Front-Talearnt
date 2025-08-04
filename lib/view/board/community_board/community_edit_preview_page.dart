import 'dart:io';

import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/profile.dart';
import 'package:app_front_talearnt/common/widget/state_badge.dart';
import 'package:app_front_talearnt/common/widget/toast_message.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/constants/global_value_constants.dart';
import 'package:app_front_talearnt/view_model/board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../provider/board/community_edit_provider.dart';
import '../../../provider/common/common_provider.dart';

class CommunityEditPreviewPage extends StatelessWidget {
  const CommunityEditPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final communityEditProvider = Provider.of<CommunityEditProvider>(context);
    final boardViewModel = Provider.of<BoardViewModel>(context);
    final CommonProvider commonProvider = Provider.of<CommonProvider>(context);

    String today = DateFormat('yyyy.MM.dd').format(DateTime.now());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted &&
          !commonProvider.isEntryUpdate &&
          !commonProvider.isBackGesture) {
        ToastMessage.infinityShow(
            context: context,
            message: '실제로 게시될 글을 미리 확인하세요',
            type: 2,
            bottom: 50,
            commonProvider: commonProvider);
      }
    });

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop) return;
        commonProvider.updateBackGesture(true);
        commonProvider.removeToast();
      },
      child: Scaffold(
        appBar: TopAppBar(
          onPressed: () {
            communityEditProvider.previewImageListClear();
            commonProvider.updateBackGesture(true);
            commonProvider.removeToast();
            context.pop();
          },
          first: PrimaryS(
            content: '등록',
            onPressed: () async {
              commonProvider.updateBackGesture(true);
              commonProvider.removeToast();
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    StateBadge(
                      state: true,
                      content: GlobalValueConstants.communityCategoryTypes
                          .firstWhere((item) =>
                              item['value']! ==
                              communityEditProvider.selectedCategory)['value']!,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Wrap(
                      children: [
                        Text(
                          communityEditProvider.titleController.text,
                          style: TextTypes.heading2(
                            color: Palette.text01,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Profile(nickName: "닉네임"),
                        Row(
                          children: [
                            Text(
                              today,
                              style: TextTypes.caption01(
                                color: Palette.text04,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              "조회 2",
                              style: TextTypes.caption01(
                                color: Palette.text04,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Palette.bgUp02,
                thickness: 1.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: 32,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ...communityEditProvider.previewImageList
                            .asMap()
                            .entries
                            .take(4)
                            .map(
                          (entry) {
                            int index = entry.key;
                            File file = entry.value;
                            String path = file.path;

                            double imageSize =
                                (MediaQuery.of(context).size.width - 92) / 4;

                            bool isNetworkImage = path.startsWith('http://') ||
                                path.startsWith('https://');

                            return Padding(
                              padding:
                                  EdgeInsets.only(right: index < 3 ? 12 : 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Palette.icon04,
                                            width: 1,
                                          ),
                                        ),
                                        child: isNetworkImage
                                            ? Image.network(
                                                path,
                                                width: imageSize,
                                                height: imageSize,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                file,
                                                width: imageSize,
                                                height: imageSize,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      if (index == 3)
                                        Positioned.fill(
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Center(
                                              child: Text(
                                                "이미지\n더보기",
                                                style: TextTypes.bodyMedium03(
                                                  color: Palette.bgBackGround,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    QuillEditor.basic(
                      controller: communityEditProvider.contentController,
                      config: QuillEditorConfig(
                        showCursor: false,
                        readOnlyMouseCursor: MouseCursor.uncontrolled,
                        enableAlwaysIndentOnTab: false,
                        enableInteractiveSelection: false,
                        enableScribble: false,
                        embedBuilders: FlutterQuillEmbeds.editorBuilders(
                            imageEmbedConfig: QuillEditorImageEmbedConfig(
                                onImageClicked: (String image) {})),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Palette.bgUp02,
                thickness: 12.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
