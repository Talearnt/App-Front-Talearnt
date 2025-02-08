
import 'package:app_front_talearnt/common/widget/talent_keyword_chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../common/theme.dart';
import '../../../common/widget/bottom_selected_chip_list.dart';
import '../../../common/widget/button.dart';
import '../../../common/widget/toast_message.dart';
import '../../../constants/global_value_constants.dart';
import 'keyword_tab_dot.dart';

class KeywordBottomSheet extends StatelessWidget {
  final String sheetTitle;
  final List<int> keywordCodes;
  final TabController tabController;
  final Function removeFunction;
  final Function updateFunction;
  final Function registerFunction;
  final Function resetFunction;

  const KeywordBottomSheet(
      {super.key,
      required this.sheetTitle,
      required this.keywordCodes,
      required this.tabController,
      required this.removeFunction,
      required this.updateFunction,
      required this.registerFunction,
      required this.resetFunction});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      keywordCodes: keywordCodes,
                      onDeleted: (int labelCode) {
                        removeFunction(labelCode);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWithIcon(
                      content: '초기화',
                      svgPicture: SvgPicture.asset('assets/icons/reset.svg'),
                      onPressed: () {
                        resetFunction();
                      },
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: PrimaryM(
                        content: '등록 ${keywordCodes.length}',
                        onPressed: () {
                          registerFunction();
                          context.pop();
                        },
                      ),
                    ),
                  ],
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
                sheetTitle,
                style: TextTypes.bodySemi01(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TabBar(
              controller: tabController,
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
              unselectedLabelStyle:
                  TextTypes.body02(color: Palette.text02),
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
                            (talent) => keywordCodes.contains(talent.code),
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
                  controller: tabController,
                  children: [
                    for (var tabText in GlobalValueConstants.keywordCategoris)
                      SingleChildScrollView(
                        child: TalentKeywordChipList(
                          keywords: tabText.talentKeywords,
                          selectedKeywords: keywordCodes,
                          onSelectionChanged: (newSelectedKeyword) {
                            if (newSelectedKeyword.length > 20) {
                              ToastMessage.show(
                                  context: context,
                                  message: '키워드는 20개까지만 설정 가능해요',
                                  type: 2,
                                  bottom: 42);
                            } else {
                              updateFunction(newSelectedKeyword);
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
      ),
    );
  }
}
