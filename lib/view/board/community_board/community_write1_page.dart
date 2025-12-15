import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/widget/bottom_btn.dart';
import '../../../constants/global_value_constants.dart';
import '../../../provider/board/community_write_provider.dart';

class CommunityWrite1Page extends StatelessWidget {
  const CommunityWrite1Page({super.key});

  @override
  Widget build(BuildContext context) {
    final communityWriteProvider = Provider.of<CommunityWriteProvider>(context);

    return Scaffold(
      appBar: TopAppBar(
        onPressed: () {
          communityWriteProvider.clearProvider();
          context.pop();
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/text_edit.svg',
                          width: 36,
                          height: 36,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          '필수 정보를 입력해 주세요',
                          style: TextTypes.bodySemi01(color: Palette.text01),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    color: Palette.line01, // 선 색상
                    thickness: 1.0, // 선 두께
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: Align(
                      alignment: Alignment.centerLeft, // 왼쪽 정렬 강제
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '게시판 구분',
                                style: TextTypes.bodySemi03(
                                  color: Palette.text01,
                                ),
                              ),
                              Text(
                                communityWriteProvider.categoryRequiredMessage,
                                style: TextTypes.caption01(
                                  color: Palette.error01,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Wrap(
                            spacing: 12.0,
                            runSpacing: 12.0,
                            children: [
                              ...GlobalValueConstants.communityCategoryTypes
                                  .where((item) => item['code']!.isNotEmpty)
                                  .map((item) {
                                String labelText = item['value']!;
                                String labelCode = item['code']!;
                                return ChoiceChip(
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  showCheckmark: false,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: communityWriteProvider
                                                  .selectedCategory ==
                                              labelCode
                                          ? Palette.primary01
                                          : Palette.line01,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  backgroundColor: Palette.bgBackGround,
                                  label: Text(labelText),
                                  labelPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 6),
                                  labelStyle: TextStyle(
                                    color: communityWriteProvider
                                                .selectedCategory ==
                                            labelCode
                                        ? Palette.primary01
                                        : Palette.text04,
                                  ),
                                  selected:
                                      communityWriteProvider.selectedCategory ==
                                          labelCode,
                                  selectedColor: Palette.bgBackGround,
                                  onSelected: (selected) {
                                    final updatedFilter =
                                        communityWriteProvider.selectedCategory;
                                    updatedFilter == labelCode
                                        ? communityWriteProvider
                                            .removeSelectedCategory()
                                        : communityWriteProvider
                                            .updateSelectedCategory(labelCode);
                                  },
                                );
                              }).toList(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomBtn(
            otherSetting: TextWithIcon(
              content: '초기화',
              svgPicture: SvgPicture.asset('assets/icons/reset.svg'),
              onPressed: () {
                communityWriteProvider.reset();
              },
            ),
            mediaBottom: MediaQuery.of(context).viewInsets.bottom,
            content: "다음",
            isEnabled: true,
            onPressed: () async {
              communityWriteProvider.checkChipsSelected();
              if (communityWriteProvider.isChipsSelected) {
                context.push('/community-write2');
              } else {
                null;
              }
            },
          ),
        ],
      ),
    );
  }
}
