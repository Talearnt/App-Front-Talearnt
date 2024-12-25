import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/constants/global_value_constants.dart';
import 'package:app_front_talearnt/provider/auth/match_write_provider.dart';
import 'package:app_front_talearnt/view/talearnt_board/match_write1_bottom_sheet.dart';
import 'package:app_front_talearnt/view/talearnt_board/match_write2_page.dart';
import 'package:app_front_talearnt/view_model/talearnt_board_view_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatchWrite1Page extends StatelessWidget {
  const MatchWrite1Page({super.key});

  @override
  Widget build(BuildContext context) {
    final matchWriteProvider = Provider.of<MatchWriteProvider>(context);
    final talearntBoardViewModel = Provider.of<TalearntBoardViewModel>(context);
    return Scaffold(
      appBar: TopAppBar(
        onPressed: () {
          context.pop();
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
                const TextWithIcon(
                    content: '초기화', icon: Icons.refresh_outlined),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryM(
                    content: '다음',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const MatchWrite2Page();
                          },
                        ),
                      );
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
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '주고 싶은 나의 재능',
                            style: TextTypes.bodySemi02(color: Palette.text01),
                          ),
                          TextSpan(
                            text: '(최소 1개)',
                            style: TextTypes.bodySemi02(color: Palette.text02),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Wrap(
                      spacing: 12.0,
                      runSpacing: 12.0,
                      children: [
                        // chips 들어갈 예정
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '받고 싶은 나의 재능',
                            style: TextTypes.bodySemi02(color: Palette.text01),
                          ),
                          TextSpan(
                            text: '(최소 1개)',
                            style: TextTypes.bodySemi02(color: Palette.text02),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Wrap(
                      children: [
                        ...matchWriteProvider.interestTalentKeywordCodes
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
                                  color: matchWriteProvider
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
                                color: matchWriteProvider
                                        .selectedInterestTalentKeywordCodes
                                        .contains(item)
                                    ? Palette.primary01
                                    : Palette.text04,
                              ),
                              selected: matchWriteProvider
                                  .selectedInterestTalentKeywordCodes
                                  .contains(item),
                              selectedColor: Palette.bgBackGround,
                              onSelected: (selected) {
                                final updatedFilter = matchWriteProvider
                                    .selectedInterestTalentKeywordCodes
                                    .toList();
                                updatedFilter.contains(item)
                                    ? updatedFilter.removeWhere(
                                        (keyword) => keyword == item)
                                    : updatedFilter.add(item);
                                matchWriteProvider
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
                              await talearntBoardViewModel.getKeywords();
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24),
                                  ),
                                ),
                                clipBehavior: Clip.antiAlias,
                                builder: (BuildContext context) {
                                  return const MatchWrite1BottomSheet();
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      '진행 기간',
                      style: TextTypes.bodySemi02(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Wrap(
                      spacing: 12.0,
                      runSpacing: 12.0,
                      children: [
                        // chips 들어갈 예정
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      '진행 방식',
                      style: TextTypes.bodySemi02(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Wrap(
                      spacing: 12.0,
                      runSpacing: 12.0,
                      children: [
                        // chips 들어갈 예정
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      '인증 배지 여부',
                      style: TextTypes.bodySemi02(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Wrap(
                      spacing: 12.0,
                      runSpacing: 12.0,
                      children: [
                        // chips 들어갈 예정
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
