import 'package:flutter/material.dart';

import '../../../common/theme.dart';

class BoardSelectedChipList extends StatelessWidget {
  final List<String> keywordNames;

  const BoardSelectedChipList({
    Key? key,
    required this.keywordNames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: keywordNames.map((chip) {
          return Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Chip(
              label: Text(
                chip,
                style: TextTypes.bodyMedium03(
                  color: Palette.text02,
                ),
              ),
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
    );
  }
}
