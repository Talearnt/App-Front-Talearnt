import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme.dart';
import '../../data/model/respone/keyword_category.dart';

class BottomSelectedChipList extends StatelessWidget {
  final List<KeywordCategory> baseCategory;
  final List<int> keywordCodes;
  final void Function(int labelCode) onDeleted;

  const BottomSelectedChipList({
    Key? key,
    required this.baseCategory,
    required this.keywordCodes,
    required this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: keywordCodes.map((chip) {
            String labelText = '';
            int labelCode = -1;
            for (var category in baseCategory) {
              if (category.talentKeywords
                  .any((talent) => talent.code == chip)) {
                var data = category.talentKeywords
                    .firstWhere((talent) => talent.code == chip);
                labelText = data.name;
                labelCode = data.code;
                break;
              }
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Chip(
                label: Text(labelText),
                deleteIcon: SvgPicture.asset('assets/icons/chips_close.svg'),
                onDeleted: () => onDeleted(labelCode),
                backgroundColor: Palette.bgUp02,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: const BorderSide(
                    color: Palette.bgUp02,
                    width: 0,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
