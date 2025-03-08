import 'dart:io';

import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/profile.dart';
import 'package:app_front_talearnt/common/widget/state_badge.dart';
import 'package:app_front_talearnt/common/widget/toast_message.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/constants/global_value_constants.dart';
import 'package:app_front_talearnt/provider/board/match_edit_provider.dart';
import 'package:app_front_talearnt/view_model/board_view_model.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MatchEditPreviewPage extends StatelessWidget {
  const MatchEditPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final matchEditProvider = Provider.of<MatchEditProvider>(context);
    final boardViewModel = Provider.of<BoardViewModel>(context);

    String today = DateFormat('yyyy.MM.dd').format(DateTime.now());

    return Scaffold(
      appBar: TopAppBar(
        onPressed: () {
          matchEditProvider.previewImageListclear();
          context.pop();
        },
        first: PrimaryS(
          content: '완료',
          onPressed: () async {
            await matchEditProvider.getUploadImagesInfo();

            if (matchEditProvider.uploadImageInfos.isNotEmpty) {
              await boardViewModel.getImageUploadUrl(
                  matchEditProvider.uploadImageInfos, "E");

              for (int idx = 0;
                  idx < matchEditProvider.imageUploadUrls.length;
                  idx++) {
                await boardViewModel.uploadImage(
                  matchEditProvider.imageUploadUrls[idx],
                  matchEditProvider.uploadImageInfos[idx]["file"],
                  matchEditProvider.uploadImageInfos[idx]["fileSize"],
                  matchEditProvider.uploadImageInfos[idx]["fileType"],
                  "E",
                );
              }
            }

            matchEditProvider.checkTitleAndBoard();

            if (matchEditProvider.isTitleAndBoardEmpty) {
              matchEditProvider.insertMatchBoard();

              await boardViewModel.insertMatchBoard(
                matchEditProvider.titleController.text,
                matchEditProvider.htmlContent,
                matchEditProvider.selectedGiveTalentKeywordCodes,
                matchEditProvider.selectedInterestTalentKeywordCodes,
                matchEditProvider.selectedExchangeType,
                false,
                matchEditProvider.selectedDuration,
                matchEditProvider.imageUploadedUrls,
              );
            } else {
              ToastMessage.show(
                context: context,
                message: matchEditProvider.boardToastMessage,
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
                  const StateBadge(
                    state: true,
                    content: "모집중",
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Wrap(
                    children: [
                      Text(
                        matchEditProvider.titleController.text,
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
              thickness: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 28,
                  ),
                  Text(
                    "주고 싶은 나의 재능",
                    style: TextTypes.caption01(
                      color: Palette.text03,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Wrap(
                    children: [
                      ...matchEditProvider.selectedGiveTalentKeywordCodes.map(
                        (item) {
                          String labelText = '';
                          for (var category
                              in GlobalValueConstants.keywordCategoris) {
                            if (category.talentKeywords
                                .any((talent) => talent.code == item)) {
                              var data = category.talentKeywords
                                  .firstWhere((talent) => talent.code == item);
                              labelText = data.name;
                              break;
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.only(
                              right: 8,
                              bottom: 8,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: const BoxDecoration(
                                color: Palette.bgUp02,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    4,
                                  ),
                                ),
                              ),
                              child: Text(
                                labelText,
                                style: TextTypes.body02(
                                  color: Palette.text02,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "받고 싶은 나의 재능",
                    style: TextTypes.caption01(
                      color: Palette.text03,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Wrap(
                    children: [
                      ...matchEditProvider.selectedInterestTalentKeywordCodes
                          .map(
                        (item) {
                          String labelText = '';
                          for (var category
                              in GlobalValueConstants.keywordCategoris) {
                            if (category.talentKeywords
                                .any((talent) => talent.code == item)) {
                              var data = category.talentKeywords
                                  .firstWhere((talent) => talent.code == item);
                              labelText = data.name;
                              break;
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.only(
                              right: 8,
                              bottom: 8,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: const BoxDecoration(
                                color: Palette.bgUp02,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    4,
                                  ),
                                ),
                              ),
                              child: Text(
                                labelText,
                                style: TextTypes.body02(
                                  color: Palette.text02,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    color: Palette.bgUp02,
                    thickness: 1.0,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        "진행 방식",
                        style: TextTypes.body02(
                          color: Palette.text03,
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        matchEditProvider.selectedDuration,
                        style: TextTypes.body02(
                          color: Palette.text02,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        "진행 기간",
                        style: TextTypes.body02(
                          color: Palette.text03,
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        matchEditProvider.selectedExchangeType,
                        style: TextTypes.body02(
                          color: Palette.text02,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                ],
              ),
            ),
            const Divider(
              color: Palette.bgUp02,
              thickness: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 24,
                right: 24,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ...matchEditProvider.previewImageList
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
                            padding: EdgeInsets.only(right: index < 3 ? 12 : 0),
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
                    controller: matchEditProvider.contentController,
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
            )
          ],
        ),
      ),
    );
  }
}
