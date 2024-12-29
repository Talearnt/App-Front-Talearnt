import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/profile.dart';
import 'package:app_front_talearnt/common/widget/state_badge.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/constants/global_value_constants.dart';
import 'package:app_front_talearnt/provider/auth/match_write_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class MatchWritePreviewPage extends StatelessWidget {
  const MatchWritePreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final matchWriteProvider = Provider.of<MatchWriteProvider>(context);
    String today = DateFormat('yyyy.MM.dd').format(DateTime.now());

    return Scaffold(
      appBar: TopAppBar(
        onPressed: () {
          context.pop();
        },
        first: const PrimaryS(content: '등록'),
      ),
      body: Column(
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
                Wrap(
                  children: [
                    const StateBadge(
                      state: true,
                      content: "모집중",
                    ),
                    const SizedBox(
                      width: 12,
                    ),
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
                    ...matchWriteProvider.interestTalentKeywordCodes.map(
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
                  height: 24,
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
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Text(
                  matchWriteProvider.contentController.document.toPlainText(),
                  style: TextTypes.bodyLarge02(
                    color: Palette.text02,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
