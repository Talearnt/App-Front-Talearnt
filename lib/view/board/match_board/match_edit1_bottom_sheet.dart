import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/bottom_selected_chip_list.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/talent_keyword_chip_list.dart';
import 'package:app_front_talearnt/common/widget/toast_message.dart';
import 'package:app_front_talearnt/constants/global_value_constants.dart';
import 'package:app_front_talearnt/provider/board/match_edit_provider.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../keyword/widget/keyword_tab_dot.dart';

class MatchEdit1BottomSheet extends StatelessWidget {
  const MatchEdit1BottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final matchEditProvider = Provider.of<MatchEditProvider>(context);
    final commonProvider = Provider.of<CommonProvider>(context);

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 134,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // 가로 스크롤 활성화
              child: Row(
                children: [
                  const SizedBox(
                    width: 24,
                  ),
                  BottomSelectedChipList(
                    baseCategory: GlobalValueConstants.keywordCategoris,
                    keywordCodes: matchEditProvider.interestTalentKeywordCodes,
                    onDeleted: (int labelCode) {
                      matchEditProvider.removeInterestKeywordList(labelCode);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: SizedBox(
                width: double.infinity,
                child: PrimaryM(
                  content:
                      '추가 ${matchEditProvider.interestTalentKeywordCodes.length}',
                  onPressed: () async {
                    matchEditProvider.updateSelectedInterestTalentKeywordCodes(
                        matchEditProvider.interestTalentKeywordCodes);

                    if (!matchEditProvider.isChipsSelected) {
                      matchEditProvider.checkChipsSelected();
                      if (matchEditProvider.isChipsSelected) {
                        commonProvider.removeToast();
                      } else {
                        commonProvider.removeToast();
                        ToastMessage.infinityShow(
                          context: context,
                          message: matchEditProvider.errorMessage,
                          type: 2,
                          bottom: 42,
                          commonProvider: commonProvider,
                        );
                      }
                    }

                    context.pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 28,
              left: 24,
              right: 24,
            ),
            child: Text(
              '받고 싶은 상대의 재능',
              style: TextTypes.bodySemi01(),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TabBar(
            controller: matchEditProvider.interestTalentTabController,
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Palette.text01,
            indicatorWeight: 1.0,
            indicatorPadding: EdgeInsets.zero,
            dividerColor: Palette.bgUp02,
            dividerHeight: 2.0,
            labelColor: Palette.text01,
            labelStyle: TextTypes.body02(color: Palette.text01),
            unselectedLabelStyle: TextTypes.body02(color: Palette.text02),
            padding: EdgeInsets.zero,
            tabs: [
              for (var tabText in GlobalValueConstants.keywordCategoris)
                Container(
                  alignment: Alignment.center,
                  child: Tab(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 7),
                            child: Text(tabText.name)),
                        if (tabText.talentKeywords.any(
                          (talent) => matchEditProvider
                              .interestTalentKeywordCodes
                              .contains(talent.code),
                        ))
                          const KeywordTabDot()
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TabBarView(
                controller: matchEditProvider.interestTalentTabController,
                children: [
                  for (var tabText in GlobalValueConstants.keywordCategoris)
                    SingleChildScrollView(
                      child: TalentKeywordChipList(
                        keywords: tabText.talentKeywords,
                        selectedKeywords:
                            matchEditProvider.interestTalentKeywordCodes,
                        onSelectionChanged: (newSelectedKeyword) {
                          if (newSelectedKeyword.length > 5) {
                            ToastMessage.show(
                                context: context,
                                message: '키워드는 5개까지만 설정 가능해요',
                                type: 2,
                                bottom: 42);
                          } else {
                            matchEditProvider
                                .updateInterestKeywordList(newSelectedKeyword);
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
