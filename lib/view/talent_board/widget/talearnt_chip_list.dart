import 'package:flutter/material.dart';

import '../../../common/theme.dart';
import '../../../data/model/respone/keyword_talent.dart';

class TalentChipList extends StatelessWidget {
  final List<KeywordTalent> keywords;
  final List<int> selectedKeywords;
  final Function(List<int>) onSelectionChanged;

  const TalentChipList({
    super.key,
    required this.keywords,
    required this.selectedKeywords,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: keywords.map(
        (item) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 12, 16),
            child: ChoiceChip(
                showCheckmark: false,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: selectedKeywords.contains(item.code)
                        ? Palette.primary01
                        : Palette.line01,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: Palette.bgBackGround,
                label: Text(item.name),
                labelStyle: TextStyle(
                  color: selectedKeywords
                          .map((keyword) => keyword)
                          .contains(item.code)
                      ? Palette.primary01
                      : Palette.text04,
                ),
                selected: selectedKeywords
                    .map((keyword) => keyword)
                    .contains(item.code),
                selectedColor: Palette.bgBackGround,
                onSelected: (selected) {
                  final updatedFilter = selectedKeywords.toList();
                  updatedFilter.map((keyword) => keyword).contains(item.code)
                      ? updatedFilter
                          .removeWhere((keyword) => keyword == item.code)
                      : {
                          updatedFilter.add(item.code),
                        };
                  onSelectionChanged.call(updatedFilter);
                }),
          );
        },
      ).toList(),
    );
  }
}
