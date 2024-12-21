import 'package:app_front_talearnt/view/talearnt_board/widget/bottom_selected_chip_list.dart';
import 'package:app_front_talearnt/view/talearnt_board/widget/talearnt_chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../constants/global_value_constants.dart';
import '../../provider/talearnt_board/keyword_provider.dart';

class SetGiveTalentPage extends StatelessWidget {
  const SetGiveTalentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final setKeywordProvider = Provider.of<KeywordProvider>(context);
    return Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "나의 재능 키워드를",
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
              decoration: InputDecoration(
                hintStyle: TextTypes.caption01(color: Palette.text04),
                hintText: '원하는 키워드를 검색해 보세요.',
                prefixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
                  child: SvgPicture.asset('assets/icons/search_small.svg'),
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
            TabBar(
              controller: setKeywordProvider.keywordTabController,
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
                      child: Text(tabText.name),
                    ),
                  ),
              ],
            )
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: TabBarView(
            controller: setKeywordProvider.keywordTabController,
            children: [
              for (var tabText in GlobalValueConstants.keywordCategoris)
                SingleChildScrollView(
                  // This makes each Tab's content scrollable
                  child: TalentChipList(
                    keywords: tabText.talentKeywords,
                    selectedKeywords: setKeywordProvider.giveTalentKeywordCodes,
                    onSelectionChanged: (newSelectedKeyword) {
                      setKeywordProvider
                          .updateGiveKeywordList(newSelectedKeyword);
                    },
                  ),
                ),
            ],
          ),
        ),
        BottomSelectedChipList(
          baseCategory: GlobalValueConstants.keywordCategoris,
          keywordCodes: setKeywordProvider.giveTalentKeywordCodes,
          onDeleted: (int labelCode) {
            setKeywordProvider.removeGiveKeywordList(labelCode);
          },
        ),
      ],
    );
  }
}
