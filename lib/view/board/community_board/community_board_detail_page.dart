import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/loading.dart';
import 'package:app_front_talearnt/common/widget/profile.dart';
import 'package:app_front_talearnt/common/widget/state_badge.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/view/board/community_board/widget/community_detail_board_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../provider/board/community_board_detail_provider.dart';
import '../../../provider/profile/profile_provider.dart';
import '../widget/modify_board_bottom_sheet.dart';

class CommunityBoardDetailPage extends StatelessWidget {
  const CommunityBoardDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final communityBoardDetailProvider =
        Provider.of<CommunityBoardDetailProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    final commonProvider = Provider.of<CommonProvider>(context);

    return Scaffold(
      appBar: TopAppBar(
        onPressed: () {
          context.pop();
        },
        first: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              builder: (BuildContext context) {
                return ModifyBoardBottomSheet(
                  isMine: communityBoardDetailProvider
                          .communityDetailBoard.userNo ==
                      profileProvider.userProfile.userNo,
                  boardType: 'community',
                  postNo: communityBoardDetailProvider
                      .communityDetailBoard.communityPostNo,
                );
              },
            );
          },
          child: SvgPicture.asset(
            'assets/icons/kebab_menu.svg',
          ),
        ),
        second: InkWell(
          child: SvgPicture.asset(
            'assets/icons/share.svg',
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            StateBadge(
                              state: true,
                              content: communityBoardDetailProvider
                                  .communityDetailBoard.postType,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Wrap(
                              children: [
                                Text(
                                  communityBoardDetailProvider
                                      .communityDetailBoard.title,
                                  style: TextTypes.heading2(
                                    color: Palette.text01,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Profile(
                                    nickName: communityBoardDetailProvider
                                        .communityDetailBoard.nickname),
                                Row(
                                  children: [
                                    Text(
                                      communityBoardDetailProvider
                                          .communityDetailBoard.createdAt,
                                      style: TextTypes.caption01(
                                        color: Palette.text04,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      "조회 ${communityBoardDetailProvider.communityDetailBoard.count}",
                                      style: TextTypes.caption01(
                                        color: Palette.text04,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 17,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Palette.bgUp02,
                        height: 1,
                        thickness: communityBoardDetailProvider
                                .previewImageList.isNotEmpty
                            ? 12.0
                            : 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24,
                          left: 24,
                          right: 24,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ...communityBoardDetailProvider.previewImageList
                                    .asMap()
                                    .entries
                                    .take(4)
                                    .map(
                                  (entry) {
                                    int index = entry.key;
                                    var item = entry.value;

                                    double imageSize =
                                        (MediaQuery.of(context).size.width -
                                                92) /
                                            4;

                                    return Padding(
                                      padding: EdgeInsets.only(
                                          right: index < 3 ? 12 : 0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (index == 3) {
                                              context.push(
                                                  '/community-board-detail/community-image-view');
                                            } else {
                                              communityBoardDetailProvider
                                                  .setPreviewImageIndex(index);
                                              context.push(
                                                  '/community-board-detail/community-image-view-detail');
                                            }
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Palette.icon04,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Image.network(
                                                  item,
                                                  width: imageSize,
                                                  height: imageSize,
                                                  fit: BoxFit.cover,
                                                  color: index == 3
                                                      ? Colors.black
                                                          .withOpacity(0.6)
                                                      : null,
                                                  colorBlendMode: index == 3
                                                      ? BlendMode.darken
                                                      : null,
                                                ),
                                              ),
                                              if (index == 3)
                                                Positioned.fill(
                                                  child: GestureDetector(
                                                    onTap: () => context.push(
                                                        '/community-board-detail/community-image-view'),
                                                    child: Center(
                                                      child: Text(
                                                        "이미지\n더보기",
                                                        style: TextTypes
                                                            .bodyMedium03(
                                                          color: Palette
                                                              .bgBackGround,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            QuillEditor.basic(
                              controller: communityBoardDetailProvider
                                  .contentController,
                              configurations: QuillEditorConfigurations(
                                showCursor: false,
                                readOnlyMouseCursor: MouseCursor.uncontrolled,
                                enableAlwaysIndentOnTab: false,
                                enableInteractiveSelection: false,
                                enableScribble: false,
                                embedBuilders:
                                    FlutterQuillEmbeds.editorBuilders(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 56,
                      ),
                      const Divider(
                        color: Palette.bgUp02,
                        height: 1,
                        thickness: 12,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 24,
                              top: 15,
                              bottom: 15,
                              right: 20,
                            ),
                            child: Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: '댓글',
                                    style: TextTypes.bodyMedium03(
                                      color: Palette.text04,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '(0)',
                                        style: TextTypes.bodyMedium03(
                                          color: Palette.text03,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Palette.bgUp02,
                            height: 1,
                            thickness: 1.0,
                          ),
                          ListView.builder(
                            itemCount: dummyComments.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final comment = dummyComments[index];
                              final nickname = comment['nickname'];
                              final content = comment['content'];
                              final reply = comment['replyCount'];
                              final createdAt =
                                  comment['createdAt'] as DateTime;
                              final formattedDate =
                                  DateFormat('yyyy.MM.dd HH:mm')
                                      .format(createdAt);

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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            nickname,
                                                            style: TextTypes
                                                                .body02(
                                                              color: Palette
                                                                  .text01,
                                                            ),
                                                          ),
                                                          Text(
                                                            formattedDate,
                                                            style: TextTypes
                                                                .captionMedium02(
                                                              color: Palette
                                                                  .text04,
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      content,
                                                      style: TextTypes
                                                          .bodyMedium03(
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
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/icons/comment.svg',
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          '답글 달기',
                                                          style: TextTypes
                                                              .captionMedium02(
                                                            color:
                                                                Palette.text04,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    if (reply > 0)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 16),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            communityBoardDetailProvider
                                                                .toggleRepliesOpen(
                                                                    comment[
                                                                        'commentNo']);
                                                          },
                                                          child: Container(
                                                            width: 88,
                                                            height: 36,
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color: communityBoardDetailProvider.isRepliesOpen(
                                                                        comment[
                                                                            'commentNo'])
                                                                    ? Palette
                                                                        .primary01
                                                                    : Palette
                                                                        .icon03,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                999,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: 10,
                                                                bottom: 10,
                                                                right: 6,
                                                                left: 12,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    '답글 $reply개',
                                                                    style: communityBoardDetailProvider.isRepliesOpen(comment[
                                                                            'commentNo'])
                                                                        ? TextTypes
                                                                            .captionMedium02(
                                                                            color:
                                                                                Palette.primary01,
                                                                          )
                                                                        : TextTypes
                                                                            .captionMedium02(
                                                                            color:
                                                                                Palette.text02,
                                                                          ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 24,
                                                                    height: 24,
                                                                    child: communityBoardDetailProvider.isRepliesOpen(comment[
                                                                            'commentNo'])
                                                                        ? SvgPicture
                                                                            .asset(
                                                                            'assets/icons/chevron_up_before.svg',
                                                                            color:
                                                                                Palette.icon01,
                                                                          )
                                                                        : SvgPicture
                                                                            .asset(
                                                                            'assets/icons/chevron_down_before.svg',
                                                                            color:
                                                                                Palette.icon03,
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
                                    ListView.builder(
                                      itemCount: dummyReplies.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final comment = dummyReplies[index];
                                        final nickname = comment['nickname'];
                                        final content = comment['content'];
                                        final reply = comment['replyCount'];
                                        final createdAt =
                                            comment['createdAt'] as DateTime;
                                        final formattedDate =
                                            DateFormat('yyyy.MM.dd HH:mm')
                                                .format(createdAt);

                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 56, top: 16, bottom: 8),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 32,
                                                        height: 32,
                                                        child: SvgPicture.asset(
                                                            'assets/img/profile.svg'),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            nickname,
                                                            style: TextTypes
                                                                .body02(
                                                                    color: Palette
                                                                        .text01),
                                                          ),
                                                          Text(
                                                            formattedDate,
                                                            style: TextTypes
                                                                .captionMedium02(
                                                                    color: Palette
                                                                        .text04),
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
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  const Divider(
                                    color: Palette.bgUp02,
                                    height: 1,
                                    thickness: 1.0,
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              CommunityDetailBoardBottom(
                  board: communityBoardDetailProvider.communityDetailBoard)
            ],
          ),
          if (commonProvider.isLoadingPage) const Loading()
        ],
      ),
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
