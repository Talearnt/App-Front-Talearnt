import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../../provider/board/match_write_provider.dart';

class MatchWriteLinkDialog extends StatelessWidget {
  const MatchWriteLinkDialog(
      {super.key, String? initialText, String? initialUrl})
      : super();

  static Future<Map<String, String>?> show(
      BuildContext context, String? initialText, String? initialUrl) {
    return showDialog<Map<String, String>>(
      context: context,
      barrierDismissible: false,
      builder: (context) => MatchWriteLinkDialog(
          initialText: initialText, initialUrl: initialUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    final matchWriteProvider = Provider.of<MatchWriteProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        width: MediaQuery.of(context).size.width * 0.75,
        height: 302,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "내용문구",
                  style: TextTypes.bodyMedium03(color: Palette.text01),
                ),
              ],
            ),
            const SizedBox(height: 4),
            TextField(
              controller: matchWriteProvider.linkTextController,
              onChanged: (value) {
                matchWriteProvider.updateController(
                  matchWriteProvider.linkTextController,
                );
                matchWriteProvider.checkLinkText();
              },
              decoration: InputDecoration(
                hintText: "예: 제 포트폴리오입니다.",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Palette.line01,
                  ),
                ),
                hintStyle: TextTypes.body02(color: Palette.text04),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "하이퍼링크",
                  style: TextTypes.bodyMedium03(
                    color: Palette.text01,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            TextField(
              controller: matchWriteProvider.urlController,
              onChanged: (value) {
                matchWriteProvider.updateController(
                  matchWriteProvider.urlController,
                );
                matchWriteProvider.checkLinkText();
              },
              decoration: InputDecoration(
                hintText: "URL을 입력해 주세요.",
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
                    isEnabled: matchWriteProvider.isLinkTextNotEmpty,
                    content: "완료",
                    onPressed: () {
                      Navigator.pop(context, {
                        "text": matchWriteProvider.linkTextController.text,
                        "url": matchWriteProvider.urlController.text,
                      });
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
