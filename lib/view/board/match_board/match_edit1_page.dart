import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/constants/global_value_constants.dart';
import 'package:app_front_talearnt/provider/board/match_edit_provider.dart';
import 'package:app_front_talearnt/view/board/match_board/match_edit1_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MatchEdit1Page extends StatelessWidget {
  const MatchEdit1Page({super.key});

  @override
  Widget build(BuildContext context) {
    final matchEditProvider = Provider.of<MatchEditProvider>(context);

    return Scaffold(
      appBar: TopAppBar(
        onPressed: () {
          matchEditProvider.clearProvider();
          context.go('/match-board-detail-page');
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Palette.line01,
              width: 1.0,
            ),
          ),
        ),
        child: BottomAppBar(
          color: Palette.bgBackGround,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Row(
              children: [
                TextWithIcon(
                  content: '초기화',
                  svgPicture: SvgPicture.asset('assets/icons/reset.svg'),
                  onPressed: () {
                    matchEditProvider.reset();
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryM(
                    content: '다음',
                    onPressed: () async {
                      matchEditProvider.checkChipsSelected();
                      matchEditProvider.isChipsSelected
                          ? context.go('/match-edit2')
                          : null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Align(
                alignment: Alignment.centerLeft, // 왼쪽 정렬 강제
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '주고 싶은 나의 재능',
                                style:
                                    TextTypes.bodySemi03(color: Palette.text01),
                              ),
                              TextSpan(
                                text: '(최소 1개)',
                                style:
                                    TextTypes.bodySemi03(color: Palette.text02),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          matchEditProvider.giveTalentRequiredMessage,
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
                      children: [
                        ...matchEditProvider.giveTalentKeywordCodes.map((item) {
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
                            padding: const EdgeInsets.fromLTRB(0, 0, 12, 16),
                            child: ChoiceChip(
                              showCheckmark: false,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: matchEditProvider
                                          .selectedGiveTalentKeywordCodes
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
                                color: matchEditProvider
                                        .selectedGiveTalentKeywordCodes
                                        .contains(item)
                                    ? Palette.primary01
                                    : Palette.text04,
                              ),
                              selected: matchEditProvider
                                  .selectedGiveTalentKeywordCodes
                                  .contains(item),
                              selectedColor: Palette.bgBackGround,
                              onSelected: (selected) {
                                final updatedFilter = matchEditProvider
                                    .selectedGiveTalentKeywordCodes
                                    .toList();
                                updatedFilter.contains(item)
                                    ? updatedFilter.removeWhere(
                                        (keyword) => keyword == item)
                                    : updatedFilter.add(item);
                                matchEditProvider
                                    .updateSelectedGiveTalentKeywordCodes
                                    .call(updatedFilter);
                              },
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '받고 싶은 나의 재능',
                                style:
                                    TextTypes.bodySemi03(color: Palette.text01),
                              ),
                              TextSpan(
                                text: '(최소 1개)',
                                style:
                                    TextTypes.bodySemi03(color: Palette.text02),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          matchEditProvider.interestTalentRequiredMessage,
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
                      children: [
                        ...matchEditProvider.interestTalentKeywordCodes
                            .map((item) {
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
                            padding: const EdgeInsets.fromLTRB(0, 0, 12, 16),
                            child: ChoiceChip(
                              showCheckmark: false,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: matchEditProvider
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
                                color: matchEditProvider
                                        .selectedInterestTalentKeywordCodes
                                        .contains(item)
                                    ? Palette.primary01
                                    : Palette.text04,
                              ),
                              selected: matchEditProvider
                                  .selectedInterestTalentKeywordCodes
                                  .contains(item),
                              selectedColor: Palette.bgBackGround,
                              onSelected: (selected) {
                                final updatedFilter = matchEditProvider
                                    .selectedInterestTalentKeywordCodes
                                    .toList();
                                updatedFilter.contains(item)
                                    ? updatedFilter.removeWhere(
                                        (keyword) => keyword == item)
                                    : updatedFilter.add(item);
                                matchEditProvider
                                    .updateSelectedInterestTalentKeywordCodes
                                    .call(updatedFilter);
                              },
                            ),
                          );
                        }).toList(),
                        Padding(
                          padding: const EdgeInsets.only(right: 12, bottom: 16),
                          child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/icons/add_square.svg',
                              width: 36,
                              height: 36,
                            ),
                            onPressed: () async {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24),
                                  ),
                                ),
                                clipBehavior: Clip.antiAlias,
                                builder: (BuildContext context) {
                                  return const MatchEdit1BottomSheet();
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '진행 기간',
                          style: TextTypes.bodySemi03(
                            color: Palette.text01,
                          ),
                        ),
                        Text(
                          matchEditProvider.durationRequiredMessage,
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
                        ...matchEditProvider.duration.map((item) {
                          String labelText = item;
                          return ChoiceChip(
                            showCheckmark: false,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color:
                                    matchEditProvider.selectedDuration == item
                                        ? Palette.primary01
                                        : Palette.line01,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: Palette.bgBackGround,
                            label: Text(labelText),
                            labelStyle: TextStyle(
                              color: matchEditProvider.selectedDuration == item
                                  ? Palette.primary01
                                  : Palette.text04,
                            ),
                            selected:
                                matchEditProvider.selectedDuration == item,
                            selectedColor: Palette.bgBackGround,
                            onSelected: (selected) {
                              final updatedFilter =
                                  matchEditProvider.selectedDuration;
                              updatedFilter == item
                                  ? matchEditProvider.removeSelectedDuration()
                                  : matchEditProvider
                                      .updateSelectedDuration(item);
                            },
                          );
                        }).toList(),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '진행 방식',
                          style: TextTypes.bodySemi03(
                            color: Palette.text01,
                          ),
                        ),
                        Text(
                          matchEditProvider.exchangeTypeRequiredMesage,
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
                        ...matchEditProvider.exchangeType.map((item) {
                          String labelText = item;
                          return ChoiceChip(
                            showCheckmark: false,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: matchEditProvider.selectedExchangeType ==
                                        item
                                    ? Palette.primary01
                                    : Palette.line01,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: Palette.bgBackGround,
                            label: Text(labelText),
                            labelStyle: TextStyle(
                              color:
                                  matchEditProvider.selectedExchangeType == item
                                      ? Palette.primary01
                                      : Palette.text04,
                            ),
                            selected:
                                matchEditProvider.selectedExchangeType == item,
                            selectedColor: Palette.bgBackGround,
                            onSelected: (selected) {
                              final updatedFilter =
                                  matchEditProvider.selectedExchangeType;
                              updatedFilter == item
                                  ? matchEditProvider
                                      .removeSelectedExchangeType()
                                  : matchEditProvider
                                      .updateSelectedExhangeType(item);
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
    );
  }
}
