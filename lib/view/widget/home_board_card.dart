import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/data/model/respone/community_board.dart';
import 'package:app_front_talearnt/data/model/respone/match_board.dart';
import 'package:app_front_talearnt/view/board/match_board/widget/match_board_selected_chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeMatchBoardCard extends StatelessWidget {
  final MatchBoard post;

  const HomeMatchBoardCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 308,
      height: 342,
      decoration: BoxDecoration(
        color: Palette.bgBackGround,
        border: Border.all(
          color: Palette.line02,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0, 1),
            blurRadius: 10,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: SvgPicture.asset('assets/img/profile.svg'),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      post.nickname,
                      style: TextTypes.body02(
                        color: Palette.text01,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/eye_open_grey.svg'),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "20",
                      style: TextTypes.bodySemi03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    SvgPicture.asset('assets/icons/bookmark_off.svg'),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      post.favoriteCount.toString(),
                      style: TextTypes.bodySemi03(
                        color: Palette.text03,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Palette.primaryBG04,
                  ),
                  child: Text(
                    post.status,
                    style: TextTypes.captionSemi02(color: Palette.primary01),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Palette.bgUp01,
                  ),
                  child: Text(
                    post.exchangeType,
                    style: TextTypes.captionSemi02(color: Palette.text02),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Palette.bgUp01,
                  ),
                  child: Text(
                    post.duration,
                    style: TextTypes.captionSemi02(color: Palette.text02),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 58,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  post.title,
                  style: TextTypes.heading2(
                    color: Palette.text01,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            SizedBox(
              height: 36,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  post.content,
                  style: TextTypes.bodyMedium03(
                    color: Palette.text03,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "주고 싶은 재능",
                        style: TextTypes.captionSemi02(
                          color: Palette.text04,
                        ),
                      ),
                      MatchBoardSelectedChipList(
                        keywordNames: post.giveTalents,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "받고 싶은 재능",
                        style: TextTypes.captionSemi02(
                          color: Palette.text04,
                        ),
                      ),
                      MatchBoardSelectedChipList(
                        keywordNames: post.receiveTalents,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HomeCommunityCard extends StatelessWidget {
  final CommunityBoard post;
  final int ranking;

  const HomeCommunityCard({
    super.key,
    required this.post,
    required this.ranking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 308,
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color:  Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset('assets/img/profile.svg'),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.nickname,
                      style: TextTypes.body02(
                        color: Palette.text01,
                      ),
                    ),
                    Text(
                      post.createdAt,
                      style: TextTypes.captionSemi02(
                        color: Palette.text04,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Palette.errorBG01,
                  ),
                  child: Text(
                    'Best ${ranking.toString()}',
                    style: TextTypes.captionMedium02(color: Palette.error01),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Palette.primaryBG04,
                  ),
                  child: Text(
                    post.postType,
                    style: TextTypes.captionMedium02(color: Palette.primary01),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 46,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  post.title,
                  style: TextTypes.bodySemi01(
                    color: Palette.text01,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 36,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  post.content,
                  style: TextTypes.bodyMedium03(
                    color: Palette.text03,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/thumb_up_off.svg'),
                    const SizedBox(width: 4),
                    Text(
                      post.likeCount.toString(),
                      style: TextTypes.bodySemi03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(width: 6),
                    SvgPicture.asset('assets/icons/comment.svg'),
                    const SizedBox(width: 4),
                    Text(
                      post.commentCount.toString(),
                      style: TextTypes.bodySemi03(
                        color: Palette.text03,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/eye_open_grey.svg'),
                    const SizedBox(width: 4),
                    Text(
                      post.count.toString(),
                      style: TextTypes.bodySemi03(
                        color: Palette.text03,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HomeNullCard extends StatelessWidget {
  const HomeNullCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 308,
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
