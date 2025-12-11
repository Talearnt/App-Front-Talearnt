import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/toast_message.dart';
import 'package:app_front_talearnt/provider/board/match_edit_provider.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/view_model/board_view_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../provider/board/match_write_provider.dart';

class MatchEditHyperlinkDialog extends StatelessWidget {
  const MatchEditHyperlinkDialog({super.key, String? initialHyperLink})
      : super();

  static Future<Map<String, String>?> show(
      BuildContext context, String? initialHyperLink) {
    return showDialog<Map<String, String>>(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          MatchEditHyperlinkDialog(initialHyperLink: initialHyperLink),
    );
  }

  @override
  Widget build(BuildContext context) {
    final matchEditProvider = Provider.of<MatchEditProvider>(context);
    final boardViewModel = Provider.of<BoardViewModel>(context);
    final commonProvider = Provider.of<CommonProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "연락할 수 있는 수단을 알려주세요",
                  style: TextTypes.bodyMedium01(
                    color: Palette.text01,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "이메일 또는 URL",
                  style: TextTypes.bodyMedium03(
                    color: Palette.text01,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            TextField(
              controller: matchEditProvider.hyperLinkTextController,
              onChanged: (value) {
                matchEditProvider.updateController(
                  matchEditProvider.hyperLinkTextController,
                );
                matchEditProvider.checkHyperLinkText();
              },
              decoration: InputDecoration(
                hintText: "example@gmail.com",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintStyle: TextTypes.body02(color: Palette.text04),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Palette.line01,
                  ),
                ),
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/fail_helper.svg',
                  width: 12,
                  height: 12,
                  color: Palette.text03,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text("오픈채팅 URL 또는 이메일 주소만 입력가능합니다.",
                    style: TextTypes.captionSemi02(color: Palette.text03))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "음란물, 불법 도박, 불법 프로그램 유포 등 법령에 위반되는 사이트의 URL은 등록할 수 없습니다. 위반 시 이용이 제한될 수 있습니다.",
              style: TextTypes.bodySemi03(
                color: Palette.text04,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: SecondaryMGray(
                    content: "취소",
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PrimaryM(
                    isEnabled: matchEditProvider.isHyperLinkTextNotEmpty,
                    content: "수정",
                    onPressed: () async {
                      // 다이얼로그 닫기
                      Navigator.pop(context);

                      commonProvider.changeIsLoading(true);
                      await matchEditProvider.getUploadImagesInfo();

                      if (matchEditProvider.uploadImageInfos.isNotEmpty) {
                        await boardViewModel.getImageUploadUrl(
                            matchEditProvider.uploadImageInfos, "ME");

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

                        matchEditProvider.finishImageUpload();
                      }

                      matchEditProvider.checkTitleAndBoard();

                      if (matchEditProvider.isTitleAndBoardEmpty) {
                        matchEditProvider.insertMatchBoard();

                        await boardViewModel.editMatchBoard(
                          matchEditProvider.titleController.text,
                          matchEditProvider.htmlContent,
                          matchEditProvider.selectedGiveTalentKeywordCodes,
                          matchEditProvider.selectedInterestTalentKeywordCodes,
                          false,
                          matchEditProvider.selectedDuration,
                          matchEditProvider.imageUploadedUrls,
                          matchEditProvider.hyperLinkTextController.text,
                          matchEditProvider.postNo,
                        );
                      } else {
                        ToastMessage.show(
                          context: context,
                          message: matchEditProvider.boardToastMessage,
                          type: 2,
                          bottom: 50,
                        );
                      }

                      // 로딩 종료
                      commonProvider.changeIsLoading(false);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
