import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CommunityReplies extends StatelessWidget {
  const CommunityReplies({super.key, commentNo});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyReplies.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final comment = dummyReplies[index];
        final nickname = comment['nickname'];
        final content = comment['content'];
        final reply = comment['replyCount'];
        final createdAt = comment['createdAt'] as DateTime;
        final formattedDate = DateFormat('yyyy.MM.dd HH:mm').format(createdAt);

        return Padding(
          padding: const EdgeInsets.only(
            left: 56,
            top: 16,
            bottom: 8,
            right: 20,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: SvgPicture.asset('assets/img/profile.svg'),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nickname,
                            style: TextTypes.body02(color: Palette.text01),
                          ),
                          Text(
                            formattedDate,
                            style: TextTypes.captionMedium02(
                                color: Palette.text04),
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
                    ]),
              )
            ],
          ),
        );
      },
    );
  }
}

final List<Map<String, dynamic>> dummyReplies = [
  {
    'nickname': '잭재기',
    'content': '정말 멋진 글이에요!',
    'createdAt': DateTime(2025, 4, 7, 14, 30),
    'replyCount': 0,
  },
  {
    'nickname': '해커냥이',
    'content': '저도 궁금했던 부분이네요.',
    'createdAt': DateTime(2025, 4, 6, 10, 15),
    'replyCount': 2,
  },
  {
    'nickname': '코딩돌이',
    'content': '설명 짱 명쾌!',
    'createdAt': DateTime(2025, 4, 5, 20, 45),
    'replyCount': 3,
  },
];
