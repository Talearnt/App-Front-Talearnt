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
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/board/match_write_provider.dart';

class MatchWritePreviewPage extends StatelessWidget {
  const MatchWritePreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final matchWriteProvider = Provider.of<MatchWriteProvider>(context);
    final boardViewModel = Provider.of<BoardViewModel>(context);

    String today = DateFormat('yyyy.MM.dd').format(DateTime.now());

    return Scaffold(
      appBar: TopAppBar(
        onPressed: () {
          context.pop();
        },
        first: PrimaryS(
          content: '등록',
          onPressed: () async {
            matchWriteProvider.getUploadImagesInfo();

            if (matchWriteProvider.uploadImageInfos.isNotEmpty) {
              await boardViewModel
                  .getImageUploadUrl(matchWriteProvider.uploadImageInfos);

              for (int idx = 0;
                  idx < matchWriteProvider.imageUploadUrls.length;
                  idx++) {
                await boardViewModel.uploadImage(
                  matchWriteProvider.imageUploadUrls[idx],
                  matchWriteProvider.uploadImageInfos[idx]["file"],
                  matchWriteProvider.uploadImageInfos[idx]["fileSize"],
                  matchWriteProvider.uploadImageInfos[idx]["fileType"],
                );
              }
            }

            matchWriteProvider.checkTitleAndBoard();

            if (matchWriteProvider.isTitleAndBoardEmpty) {
              matchWriteProvider.insertMatchBoard();

              await boardViewModel.insertMatchBoard(
                matchWriteProvider.titlerController.text,
                matchWriteProvider.htmlContent,
                matchWriteProvider.selectedGiveTalentKeywordCodes,
                matchWriteProvider.selectedInterestTalentKeywordCodes,
                matchWriteProvider.selectedExchangeType,
                false,
                matchWriteProvider.selectedDuration,
                [],
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
                        matchWriteProvider.titlerController.text,
                        style: TextTypes.heading(
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
              thickness: 8.0,
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
                      ...matchWriteProvider.selectedGiveTalentKeywordCodes.map(
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
                                style: TextTypes.bodyLarge02(
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
                      ...matchWriteProvider.selectedInterestTalentKeywordCodes
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
                                style: TextTypes.bodyLarge02(
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
                  const Divider(
                    color: Palette.bgUp02,
                    thickness: 1.0,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Text(
                        "진행 방식",
                        style: TextTypes.bodyLarge02(
                          color: Palette.text03,
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        matchWriteProvider.selectedDuration,
                        style: TextTypes.bodyLarge02(
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
                        style: TextTypes.bodyLarge02(
                          color: Palette.text03,
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        matchWriteProvider.selectedExchangeType,
                        style: TextTypes.bodyLarge02(
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
              thickness: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 24,
                right: 24,
              ),
              child: Column(
                children: [
                  QuillEditor.basic(
                    controller: matchWriteProvider.contentController,
                    configurations: const QuillEditorConfigurations(
                      showCursor: false,
                      readOnlyMouseCursor: MouseCursor.uncontrolled,
                      enableAlwaysIndentOnTab: false,
                      enableInteractiveSelection: false,
                      enableScribble: false,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
