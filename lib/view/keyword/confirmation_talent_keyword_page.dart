import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../common/widget/keyword_label.dart';
import '../../common/widget/loading.dart';
import '../../constants/global_value_constants.dart';
import '../../provider/common/common_provider.dart';
import '../../provider/keyword/keyword_provider.dart';

class ConfirmationTalentKeywordPage extends StatelessWidget {
  const ConfirmationTalentKeywordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final setKeywordProvider = Provider.of<KeywordProvider>(context);
    final commonProvider = Provider.of<CommonProvider>(context);

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "키워드를 이렇게 등록할게요!",
              style: TextTypes.heading(color: Palette.text01),
            ),
            const SizedBox(height: 12),
            Text(
              "선택하신 키워드는",
              style: TextTypes.bodyMedium02(color: Palette.text04),
            ),
            Text(
              "매칭 게시글 추천에 반영됩니다",
              style: TextTypes.bodyMedium02(color: Palette.text04),
            ),
            const SizedBox(height: 48),
            const KeywordLabel(
              content: '나의 재능(최소 1개)',
            ),
            const SizedBox(height: 16),
            Wrap(
              children: setKeywordProvider.giveTalentKeywordCodes.map((item) {
                String labelText = '';
                for (var category in GlobalValueConstants.keywordCategoris) {
                  if (category.talentKeywords
                      .any((talent) => talent.code == item)) {
                    var data = category.talentKeywords
                        .firstWhere((talent) => talent.code == item);
                    labelText = data.name;
                    break;
                  }
                }
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 12, 16),
                  child: ChoiceChip(
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: setKeywordProvider.selectedGiveTalentKeywordCodes
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
                      color: setKeywordProvider.selectedGiveTalentKeywordCodes
                              .map((keyword) => keyword)
                              .contains(item)
                          ? Palette.primary01
                          : Palette.text04,
                    ),
                    selected: setKeywordProvider.selectedGiveTalentKeywordCodes
                        .map((keyword) => keyword)
                        .contains(item),
                    selectedColor: Palette.bgBackGround,
                    onSelected: (selected) {
                      final updatedFilter = setKeywordProvider
                          .selectedGiveTalentKeywordCodes
                          .toList();
                      updatedFilter.map((keyword) => keyword).contains(item)
                          ? updatedFilter
                              .removeWhere((keyword) => keyword == item)
                          : {
                              updatedFilter.add(item),
                            };
                      setKeywordProvider.updateSelectedGiveTalentKeywordCodes
                          .call(updatedFilter);
                    },
                  ),
                );
              }).toList(),
            ),
            const KeywordLabel(
              content: '관심 있는 재능(최소 1개)',
            ),
            const SizedBox(height: 16),
            Wrap(
              children:
                  setKeywordProvider.interestTalentKeywordCodes.map((item) {
                String labelText = '';
                for (var category in GlobalValueConstants.keywordCategoris) {
                  if (category.talentKeywords
                      .any((talent) => talent.code == item)) {
                    var data = category.talentKeywords
                        .firstWhere((talent) => talent.code == item);
                    labelText = data.name;
                    break;
                  }
                }
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 12, 16),
                  child: ChoiceChip(
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: setKeywordProvider
                                .selectedInterestTalentKeywordCodes
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
                              .selectedInterestTalentKeywordCodes
                              .map((keyword) => keyword)
                              .contains(item)
                          ? Palette.primary01
                          : Palette.text04,
                    ),
                    selected: setKeywordProvider
                        .selectedInterestTalentKeywordCodes
                        .map((keyword) => keyword)
                        .contains(item),
                    selectedColor: Palette.bgBackGround,
                    onSelected: (selected) {
                      final updatedFilter = setKeywordProvider
                          .selectedInterestTalentKeywordCodes
                          .toList();
                      updatedFilter.map((keyword) => keyword).contains(item)
                          ? updatedFilter
                              .removeWhere((keyword) => keyword == item)
                          : {
                              updatedFilter.add(item),
                            };
                      setKeywordProvider
                          .updateSelectedInterestTalentKeywordCodes
                          .call(updatedFilter);
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        if (commonProvider.isLoadingPage) const Loading()
      ],
    );
  }
}
