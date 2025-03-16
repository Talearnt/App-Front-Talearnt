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

import '../../../provider/board/community_write_provider.dart';
import '../../../provider/common/common_provider.dart';

class CommunityWritePreviewPage extends StatelessWidget {
  const CommunityWritePreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final communityWriteProvider = Provider.of<CommunityWriteProvider>(context);
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
            communityWriteProvider.previewImageListClear();
            commonProvider.updateBackGesture(true);
            commonProvider.removeToast();
            context.pop();
          },
          first: PrimaryS(
            content: '등록',
            onPressed: () async {
              commonProvider.removeToast();
              await communityWriteProvider.getUploadImagesInfo();

              if (communityWriteProvider.uploadImageInfo.isNotEmpty) {
                await boardViewModel.getImageUploadUrl(
                    communityWriteProvider.uploadImageInfo, "CW");

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
                          .firstWhere(
                        (item) =>
                            item['code']! ==
                            communityWriteProvider.selectedCategory,
                      )['value']!,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Wrap(
                      children: [
                        Text(
                          communityWriteProvider.titleController.text,
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
                        ...communityWriteProvider.previewImageList
                            .asMap()
                            .entries
                            .take(4)
                            .map(
                          (entry) {
                            int index = entry.key;
                            var item = entry.value;

                            double imageSize =
                                (MediaQuery.of(context).size.width - 92) / 4;

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
                                        child: Image.file(
                                          item,
                                          width: imageSize,
                                          height: imageSize,
                                          fit: BoxFit.cover,
                                          color: index == 3
                                              ? Colors.black.withOpacity(0.6)
                                              : null,
                                          colorBlendMode: index == 3
                                              ? BlendMode.darken
                                              : null,
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
                      controller: communityWriteProvider.contentController,
                      configurations: QuillEditorConfigurations(
                        showCursor: false,
                        readOnlyMouseCursor: MouseCursor.uncontrolled,
                        enableAlwaysIndentOnTab: false,
                        enableInteractiveSelection: false,
                        enableScribble: false,
                        embedBuilders: FlutterQuillEmbeds.editorBuilders(),
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
