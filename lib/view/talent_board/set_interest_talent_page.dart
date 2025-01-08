import 'package:app_front_talearnt/view/talent_board/widget/bottom_selected_chip_list.dart';
import 'package:app_front_talearnt/view/talent_board/widget/keyword_tab_dot.dart';
import 'package:app_front_talearnt/view/talent_board/widget/talearnt_chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../common/widget/toast_message.dart';
import '../../constants/global_value_constants.dart';
import '../../provider/talent_board/keyword_provider.dart';

class SetInterestTalentPage extends StatelessWidget {
  const SetInterestTalentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final setKeywordProvider = Provider.of<KeywordProvider>(context);
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "관심있는 재능 키워드를",
              style: TextTypes.heading(color: Palette.text01),
            ),
            Text(
              "선택해 주세요!",
              style: TextTypes.heading(color: Palette.text01),
            ),
            const SizedBox(height: 8),
            Text(
              "최대 5개까지 선택 가능해요",
              style: TextTypes.bodyMedium02(color: Palette.text02),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: setKeywordProvider.interestTalentSearchController,
              focusNode: setKeywordProvider.interestTalentFocusNode,
              onChanged: (value) {
                List<int> labelCode = [];
                for (var category in GlobalValueConstants.keywordCategoris) {
                  if (category.talentKeywords
                      .any((talent) => talent.name.contains(value))) {
                    var data = category.talentKeywords
                        .where((talent) => talent.name.contains(value))
                        .toList();
                    if (data.isNotEmpty) {
                      for (var talent in data) {
                        labelCode.add(talent.code);
                      }
                    }
                  }
                }
                setKeywordProvider.updateSearchInterestTalent(labelCode);
              },
              decoration: InputDecoration(
                hintStyle: TextTypes.caption01(color: Palette.text04),
                hintText: '원하는 키워드를 검색해 보세요.',
                prefixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
                  child: SvgPicture.asset(
                      setKeywordProvider.interestTalentFocusNode.hasFocus
                          ? 'assets/icons/search_small.svg'
                          : 'assets/icons/search_small_disabled.svg'),
                ),
                prefixIconColor: Colors.grey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999.0),
                  borderSide: const BorderSide(color: Palette.line01),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999.0),
                  borderSide: const BorderSide(color: Palette.line01),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999.0),
                  borderSide: const BorderSide(color: Palette.line01),
                ),
              ),
            ),
            const SizedBox(height: 24),
            setKeywordProvider.isInterestTalentSearch
                ? Container()
                : TabBar(
                    controller: setKeywordProvider.interestTalentTabController,
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Palette.text01,
                    indicatorWeight: 1.0,
                    indicatorPadding: EdgeInsets.zero,
                    dividerColor: Palette.bgUp02,
                    dividerHeight: 2.0,
                    labelColor: Palette.text01,
                    labelStyle: TextTypes.bodyLarge02(color: Palette.text01),
                    unselectedLabelStyle:
                        TextTypes.bodyLarge02(color: Palette.text02),
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
                                  (talent) => setKeywordProvider
                                      .interestTalentKeywordCodes
                                      .contains(talent.code),
                                ))
                                  const KeywordTabDot()
                              ],
                            ),
                          ),
                        ),
                    ],
                  )
          ],
        ),
        setKeywordProvider.isInterestTalentSearch
            ? Container()
            : const SizedBox(height: 20),
        Expanded(
          child: setKeywordProvider.isInterestTalentSearch
              ? SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: setKeywordProvider
                          .searchedInterestTalentKeywordCodes
                          .map((item) {
                        String labelText = '';
                        int categoryIndex = -1;
                        GlobalValueConstants.keywordCategoris
                            .asMap()
                            .forEach((index, category) {
                          if (category.talentKeywords
                              .any((talent) => talent.code == item)) {
                            var data = category.talentKeywords
                                .firstWhere((talent) => talent.code == item);
                            labelText = data.name;
                            categoryIndex = index;
                          }
                        });
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 12, 16),
                          child: ChoiceChip(
                            showCheckmark: false,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: setKeywordProvider
                                        .interestTalentKeywordCodes
                                        .contains(item)
                                    ? Palette.primary01
                                    : Palette.line01,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: Palette.bgBackGround,
                            label: Text(labelText),
                            labelStyle: TextStyle(
                              color: setKeywordProvider
                                      .interestTalentKeywordCodes
                                      .map((keyword) => keyword)
                                      .contains(item)
                                  ? Palette.primary01
                                  : Palette.text04,
                            ),
                            selected: setKeywordProvider
                                .interestTalentKeywordCodes
                                .map((keyword) => keyword)
                                .contains(item),
                            selectedColor: Palette.bgBackGround,
                            onSelected: (selected) {
                              final updatedFilter = setKeywordProvider
                                  .interestTalentKeywordCodes
                                  .toList();
                              updatedFilter
                                      .map((keyword) => keyword)
                                      .contains(item)
                                  ? updatedFilter
                                      .removeWhere((keyword) => keyword == item)
                                  : {
                                      updatedFilter.add(item),
                                    };
                              setKeywordProvider
                                  .updateSelectedSearchInterestTalentKeywordCodes
                                  .call(categoryIndex, updatedFilter);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              : TabBarView(
                  controller: setKeywordProvider.interestTalentTabController,
                  children: [
                    for (var tabText in GlobalValueConstants.keywordCategoris)
                      SingleChildScrollView(
                        child: TalentChipList(
                          keywords: tabText.talentKeywords,
                          selectedKeywords:
                              setKeywordProvider.interestTalentKeywordCodes,
                          onSelectionChanged: (newSelectedKeyword) {
                            if (newSelectedKeyword.length > 5) {
                              ToastMessage.show(
                                  context: context,
                                  message: '키워드는 5개까지만 설정 가능해요',
                                  type: 2,
                                  bottom: 42);
                            } else {
                              setKeywordProvider.updateInterestKeywordList(
                                  newSelectedKeyword);
                            }
                          },
                        ),
                      ),
                  ],
                ),
        ),
        BottomSelectedChipList(
          baseCategory: GlobalValueConstants.keywordCategoris,
          keywordCodes: setKeywordProvider.interestTalentKeywordCodes,
          onDeleted: (int labelCode) {
            setKeywordProvider.removeInterestKeywordList(labelCode);
          },
        ),
      ],
    );
  }
}