import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/board/community_board_detail_provider.dart';
import 'package:app_front_talearnt/view/board/community_board/community_replies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CommunityComment extends StatelessWidget {
  const CommunityComment({
    super.key,
    required this.communityBoardDetailProvider,
  });

  final CommunityBoardDetailProvider communityBoardDetailProvider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyComments.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final comment = dummyComments[index];
        final nickname = comment['nickname'];
        final content = comment['content'];
        final reply = comment['replyCount'];
        final createdAt = comment['createdAt'] as DateTime;
        final formattedDate = DateFormat('yyyy.MM.dd HH:mm').format(createdAt);

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 16,
                left: 24,
                right: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: SvgPicture.asset(
                                      'assets/img/profile.svg'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      nickname,
                                      style: TextTypes.body02(
                                        color: Palette.text01,
                                      ),
                                    ),
                                    Text(
                                      formattedDate,
                                      style: TextTypes.captionMedium02(
                                        color: Palette.text04,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: SvgPicture.asset(
                                'assets/icons/kebab_menu.svg',
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            left: 40,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                content,
                                style: TextTypes.bodyMedium03(
                                  color: Palette.text02,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: SvgPicture.asset(
                                      'assets/icons/comment.svg',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '답글 달기',
                                    style: TextTypes.captionMedium02(
                                      color: Palette.text04,
                                    ),
                                  ),
                                ],
                              ),
                              if (reply > 0)
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: GestureDetector(
                                    onTap: () {
                                      communityBoardDetailProvider
                                          .toggleRepliesOpen(
                                              comment['commentNo']);
                                    },
                                    child: Container(
                                      width: 88,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: communityBoardDetailProvider
                                                  .isRepliesOpen(
                                                      comment['commentNo'])
                                              ? Palette.primary01
                                              : Palette.icon03,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          999,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          right: 6,
                                          left: 12,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '답글 $reply개',
                                              style:
                                                  communityBoardDetailProvider
                                                          .isRepliesOpen(
                                                              comment[
                                                                  'commentNo'])
                                                      ? TextTypes
                                                          .captionMedium02(
                                                          color:
                                                              Palette.primary01,
                                                        )
                                                      : TextTypes
                                                          .captionMedium02(
                                                          color: Palette.text02,
                                                        ),
                                            ),
                                            SizedBox(
                                              width: 24,
                                              height: 24,
                                              child:
                                                  communityBoardDetailProvider
                                                          .isRepliesOpen(
                                                              comment[
                                                                  'commentNo'])
                                                      ? SvgPicture.asset(
                                                          'assets/icons/chevron_up_before.svg',
                                                          color: Palette.icon01,
                                                        )
                                                      : SvgPicture.asset(
                                                          'assets/icons/chevron_down_before.svg',
                                                          color: Palette.icon03,
                                                        ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (reply > 0 &&
                communityBoardDetailProvider
                    .isRepliesOpen(comment['commentNo']))
              const CommunityReplies(),
            const Divider(
              color: Palette.bgUp02,
              height: 1,
              thickness: 1.0,
            ),
          ],
        );
      },
    );
  }
}

final List<Map<String, dynamic>> dummyComments = [
  {
    'commentNo': 1, // ✅ 고유 번호 추가
    'nickname': '잭재기',
    'content': '정말 멋진 글이에요!',
    'createdAt': DateTime(2025, 4, 7, 14, 30),
    'replyCount': 0,
  },
  {
    'commentNo': 2,
    'nickname': '해커냥이',
    'content': '저도 궁금했던 부분이네요.',
    'createdAt': DateTime(2025, 4, 6, 10, 15),
    'replyCount': 3,
  },
  {
    'commentNo': 3,
    'nickname': '코딩돌이',
    'content': '설명 짱 명쾌!',
    'createdAt': DateTime(2025, 4, 5, 20, 45),
    'replyCount': 3,
  },
];
