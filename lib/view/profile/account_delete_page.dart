import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/common_navigator.dart';
import '../../common/theme.dart';
import '../../common/widget/button.dart';
import '../../common/widget/top_app_bar.dart';
import '../../provider/profile/profile_provider.dart';

class AccountDeletePage extends StatelessWidget {
  const AccountDeletePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final commonNavigator = Provider.of<CommonNavigator>(context);

    return Scaffold(
      appBar: TopAppBar(
        content: '계정 탈퇴',
        onPressed: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${profileProvider.userProfile.nickname}님, 탈퇴시 함께한 활동과 정보가 모두 사라져요 😢 ',
              style: TextTypes.heading4(color: Palette.text01),
            ),
            const SizedBox(height: 8),
            Text(
              '이유를 알려주실 수 있나요?',
              style: TextTypes.body02(color: Palette.text03),
            ),
            Text(
              '서비스 개선에 큰 도움이 돼요',
              style: TextTypes.body02(color: Palette.text03),
            ),
            const SizedBox(height: 56),
            const Divider(
              color: Palette.line02,
              thickness: 1.0,
            ),
            const SizedBox(height: 24),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '탈퇴 사유 ',
                    style: TextTypes.bodySemi01(color: Palette.text01),
                  ),
                  TextSpan(
                    text: '(선택)',
                    style: TextTypes.body02(color: Palette.text01),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: () {
                profileProvider.changeServiceNotUseful();
              },
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              child: Row(
                children: [
                  profileProvider.isServiceNotUseful
                      ? SvgPicture.asset("assets/icons/check_on_primary.svg")
                      : SvgPicture.asset(
                          "assets/icons/check_off_line_primary.svg"),
                  const SizedBox(width: 8),
                  Text(
                    '서비스를 더 이상 이용하지 않아요',
                    style: TextTypes.body02(color: Palette.text02),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                profileProvider.changeNoMatchingFound();
              },
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              child: Row(
                children: [
                  profileProvider.isNoMatchingFound
                      ? SvgPicture.asset("assets/icons/check_on_primary.svg")
                      : SvgPicture.asset(
                          "assets/icons/check_off_line_primary.svg"),
                  const SizedBox(width: 8),
                  Text(
                    '원하는 매칭 상대를 찾지 못했어요',
                    style: TextTypes.body02(color: Palette.text02),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                profileProvider.changeNoKeywordPosts();
              },
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              child: Row(
                children: [
                  profileProvider.isNoKeywordPosts
                      ? SvgPicture.asset("assets/icons/check_on_primary.svg")
                      : SvgPicture.asset(
                          "assets/icons/check_off_line_primary.svg"),
                  const SizedBox(width: 8),
                  Text(
                    '원하는 키워드의 게시물이 올라오지 않아요',
                    style: TextTypes.body02(color: Palette.text02),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                profileProvider.changeTemporaryWithdrawal();
              },
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: profileProvider.isTemporaryWithdrawal
                          ? SvgPicture.asset(
                              "assets/icons/check_on_primary.svg")
                          : SvgPicture.asset(
                              "assets/icons/check_off_line_primary.svg"),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '일시적인 탈퇴에요, 나중에 다시 올 예정이에요',
                        style: TextTypes.body02(color: Palette.text02),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                profileProvider.changeFrequentErrors();
              },
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              child: Row(
                children: [
                  profileProvider.isFrequentErrors
                      ? SvgPicture.asset("assets/icons/check_on_primary.svg")
                      : SvgPicture.asset(
                          "assets/icons/check_off_line_primary.svg"),
                  const SizedBox(width: 8),
                  Text(
                    '오류가 너무 자주 발생해요',
                    style: TextTypes.body02(color: Palette.text02),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                profileProvider.changeSlowSupportResponse();
              },
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              child: Row(
                children: [
                  profileProvider.isSlowSupportResponse
                      ? SvgPicture.asset("assets/icons/check_on_primary.svg")
                      : SvgPicture.asset(
                          "assets/icons/check_off_line_primary.svg"),
                  const SizedBox(width: 8),
                  Text(
                    '고객센터 응답이 너무 느려요',
                    style: TextTypes.body02(color: Palette.text02),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                profileProvider.changeInappropriateContent();
              },
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              child: Row(
                children: [
                  profileProvider.isInappropriateContent
                      ? SvgPicture.asset("assets/icons/check_on_primary.svg")
                      : SvgPicture.asset(
                          "assets/icons/check_off_line_primary.svg"),
                  const SizedBox(width: 8),
                  Text(
                    '부적절한 게시물/댓글이 많아요',
                    style: TextTypes.body02(color: Palette.text02),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                profileProvider.changeUnpleasantExperience();
              },
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              child: Row(
                children: [
                  profileProvider.isUnpleasantExperience
                      ? SvgPicture.asset("assets/icons/check_on_primary.svg")
                      : SvgPicture.asset(
                          "assets/icons/check_off_line_primary.svg"),
                  const SizedBox(width: 8),
                  Text(
                    '불쾌한 경험을 했어요',
                    style: TextTypes.body02(color: Palette.text02),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Stack(
              children: [
                TextField(
                  controller: profileProvider.etcController,
                  maxLength: 300,
                  maxLines: 5,
                  style: TextTypes.body02(color: Palette.text02),
                  decoration: InputDecoration(
                    hintText: '상세한 이유를 말씀해 주실 수 있나요?',
                    hintStyle: TextTypes.body02(color: Palette.text04),
                    contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Palette.line01),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Palette.line01),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    counterText: '', // 기본 카운터 숨김
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Text(
                    '${profileProvider.etcTextLength}/300 자',
                    style: TextTypes.bodyMedium03(color: Palette.text04),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 56),
            const Divider(
              color: Palette.line02,
              thickness: 1.0,
            ),
            const SizedBox(height: 24),
            Text('삭제되는 항목', style: TextTypes.bodySemi01(color: Palette.text01)),
            const SizedBox(height: 24),
            Text('• 프로필 사진, 닉네임, 평점 등 설정한 프로필 정보',
                style: TextTypes.body02(color: Palette.text02)),
            const SizedBox(height: 12),
            Text('• 게시물, 댓글, 찜 리스트 등 작성자 정보',
                style: TextTypes.body02(color: Palette.text02)),
            const SizedBox(height: 12),
            Text('• 설정한 관심 키워드, 나의 키워드',
                style: TextTypes.body02(color: Palette.text02)),
            const SizedBox(height: 12),
            Text('• 이름, 성별, 전화번호 등 기타 개인정보',
                style: TextTypes.body02(color: Palette.text02)),
            const SizedBox(height: 56),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
              decoration: BoxDecoration(
                color: Palette.bgUp01,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('유의사항', style: TextTypes.body02(color: Palette.text02)),
                  const SizedBox(height: 8),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• ',
                            style: TextTypes.bodySemi03(color: Palette.text02)),
                        Expanded(
                            child: Text(
                                '닉네임, IP주소, 이용 기록 등은 악용 방지를 위해 6개월동안 보관돼요.',
                                style: TextTypes.bodySemi03(
                                    color: Palette.text03)))
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• ',
                            style: TextTypes.bodySemi03(color: Palette.text02)),
                        Expanded(
                            child: Text(
                                '회원님이 남긴 글과 댓글의 작성자 정보는 ‘탈퇴회원\'으로 노출돼요.',
                                style: TextTypes.bodySemi03(
                                    color: Palette.text03)))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                profileProvider.changeAgreeToWithdraw();
              },
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              child: Row(
                children: [
                  profileProvider.isAgreeToWithdraw
                      ? SvgPicture.asset("assets/icons/check_on_primary.svg")
                      : SvgPicture.asset(
                          "assets/icons/check_off_line_primary.svg"),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text('위 내용을 확인하셨나요? 그래도 탤런트를 떠나실건가요?',
                          style: TextTypes.bodySemi03(color: Palette.text02)))
                ],
              ),
            ),
            const SizedBox(height: 120),
            const Divider(
              color: Palette.line02,
              thickness: 1.0,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: SecondaryMGray(
                    content: '그만 두기',
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: PrimaryM(
                    content: '탈퇴하기',
                    onPressed: () {
                      commonNavigator.showDoubleDialog(
                          content: "이 버튼을 누르면 탤런트와 이별하게 돼요\n정말로 탈퇴하시겠어요...?",
                          leftText: '그만두기',
                          rightText: '탈퇴하기',
                          leftFun: () {
                            if (context.mounted) {
                              context.pop();
                            }
                          },
                          rightFun: () {
                            //원래는 탈퇴 api 실행해야됨
                            context.go('/account-delete-complete');
                          });
                    },
                    isEnabled: profileProvider.isAgreeToWithdraw,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
