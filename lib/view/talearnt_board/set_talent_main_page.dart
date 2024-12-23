import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/view/talearnt_board/set_give_talent_page.dart';
import 'package:app_front_talearnt/view/talearnt_board/set_interest_talent_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/common_navigator.dart';
import '../../common/widget/bottom_btn.dart';
import '../../common/widget/top_app_bar.dart';
import '../../provider/talearnt_board/keyword_provider.dart';
import 'confirmation_talent_page.dart';

class SetTalentMainPage extends StatelessWidget {
  const SetTalentMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final keywordProvider = Provider.of<KeywordProvider>(context);
    final commonNavigator = Provider.of<CommonNavigator>(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          // 뒤로가기가 처리되지 않았을 때
          if (context.mounted) {
            keywordProvider.reset(); // 초기화 작업 수행
            context.pop(); // 화면 종료
          }
        }
      },
      child: Scaffold(
        backgroundColor: Palette.bgBackGround,
        appBar: TopAppBar(
            content: '',
            onPressed: () {
              if (keywordProvider.setTalentPage == 0) {
                commonNavigator.showDoubleDialog(
                  content: "로그아웃 후\n다른 아이디로 로그인 하시겠어요?",
                  leftText: '로그아웃',
                  rightText: '키워드 설정',
                  leftFun: () {
                    context.pop();
                    context.go('/');
                  },
                );
              } else if (keywordProvider.setTalentPage == 2) {
                keywordProvider.pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
                keywordProvider.beforeSelectedGiveTalentKeywordCodes();
              } else {
                keywordProvider.pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
                keywordProvider.beforeSelectedInterestTalentKeywordCodes();
              }
            }),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: keywordProvider.pageController,
                    onPageChanged: (int page) {
                      keywordProvider.updatePage(page);
                    },
                    children: const [
                      SetGiveTalentPage(),
                      SetInterestTalentPage(),
                      ConfirmationTalentPage()
                    ],
                  ),
                ),
              ),
              keywordProvider.setTalentPage == 0
                  ? //첫번째 페이지
                  BottomBtn(
                      mediaBottom: MediaQuery.of(context).viewInsets.bottom,
                      content: '다음',
                      isEnabled: keywordProvider.isGiveTalentButtonEnabled,
                      onPressed: () {
                        keywordProvider.updateSelectedGiveTalentKeywordCodes(
                            keywordProvider.giveTalentKeywordCodes);
                        keywordProvider.pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                    )
                  : keywordProvider.setTalentPage == 1
                      ? BottomBtn(
                          mediaBottom: MediaQuery.of(context).viewInsets.bottom,
                          content: '다음',
                          isEnabled:
                              keywordProvider.isInterestTalentButtonEnabled,
                          onPressed: () async {
                            keywordProvider
                                .updateSelectedInterestTalentKeywordCodes(
                                    keywordProvider.interestTalentKeywordCodes);
                            keywordProvider.pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                        )
                      : BottomBtn(
                          mediaBottom: MediaQuery.of(context).viewInsets.bottom,
                          content: '등록하기',
                          isEnabled: keywordProvider.isGiveTalentButtonEnabled,
                          onPressed: () async {
                            context.go('/set-keyword-success');
                          },
                        )
            ],
          ),
        ),
      ),
    );
  }
}
