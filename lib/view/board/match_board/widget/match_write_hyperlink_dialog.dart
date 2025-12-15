import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/toast_message.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/view_model/board_view_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../../../provider/board/match_write_provider.dart';

class MatchWriteHyperlinkDialog extends StatelessWidget {
  const MatchWriteHyperlinkDialog({super.key, String? initialHyperLink})
      : super();

  static Future<Map<String, String>?> show(
      BuildContext context, String? initialHyperLink) {
    return showDialog<Map<String, String>>(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          MatchWriteHyperlinkDialog(initialHyperLink: initialHyperLink),
    );
  }

  @override
  Widget build(BuildContext context) {
    final matchWriteProvider = Provider.of<MatchWriteProvider>(context);
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
              controller: matchWriteProvider.hyperLinkTextController,
              onChanged: (value) {
                matchWriteProvider.updateController(
                  matchWriteProvider.hyperLinkTextController,
                );
                matchWriteProvider.checkHyperLinkText();
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
                    isEnabled: matchWriteProvider.isHyperLinkTextNotEmpty,
                    content: "등록",
                    onPressed: () async {
                      // 다이얼로그 닫기
                      Navigator.pop(context);

                      // 로딩 시작
                      commonProvider.changeIsLoading(true);

                      // 이미지 업로드 정보 가져오기
                      await matchWriteProvider.getUploadImagesInfo();

                      // 이미지가 있으면 S3 업로드
                      if (matchWriteProvider.uploadImageInfos.isNotEmpty) {
                        await boardViewModel.getImageUploadUrl(
                            matchWriteProvider.uploadImageInfos, "MW");

                        for (int idx = 0;
                            idx < matchWriteProvider.imageUploadUrls.length;
                            idx++) {
                          await boardViewModel.uploadImage(
                            matchWriteProvider.imageUploadUrls[idx],
                            matchWriteProvider.uploadImageInfos[idx]["file"],
                            matchWriteProvider.uploadImageInfos[idx]
                                ["fileSize"],
                            matchWriteProvider.uploadImageInfos[idx]
                                ["fileType"],
                            "MW",
                          );
                        }

                        matchWriteProvider.finishImageUpload();
                      }

                      // 유효성 검사 통과 시 게시글 등록
                      if (matchWriteProvider.isTitleAndBoardEmpty) {
                        matchWriteProvider.insertMatchBoard();

                        await boardViewModel.insertMatchBoard(
                          matchWriteProvider.titleController.text,
                          matchWriteProvider.htmlContent,
                          matchWriteProvider.selectedGiveTalentKeywordCodes,
                          matchWriteProvider.selectedInterestTalentKeywordCodes,
                          false,
                          matchWriteProvider.selectedDuration,
                          matchWriteProvider.imageUploadedUrls,
                          matchWriteProvider.hyperLinkTextController.text,
                        );
                      } else {
                        // 유효성 검사 실패 시 토스트 메시지
                        ToastMessage.show(
                          context: context,
                          message: matchWriteProvider.boardToastMessage,
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
