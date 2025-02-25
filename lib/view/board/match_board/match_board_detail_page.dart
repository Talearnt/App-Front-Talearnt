import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/profile.dart';
import 'package:app_front_talearnt/common/widget/state_badge.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/widget/bottom_btn.dart';
import '../../../provider/board/match_board_detail_provider.dart';
import '../../../provider/profile/profile_provider.dart';
import '../widget/modify_board_bottom_sheet.dart';

class MatchBoardDetailPage extends StatelessWidget {
  const MatchBoardDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final matchBoardDetailProvider =
        Provider.of<MatchBoardDetailProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
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
                  isMine: matchBoardDetailProvider.matchingDetailPost.userNo ==
                      profileProvider.userProfile.userNo,
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
      body: Column(children: [
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
                      const StateBadge(
                        state: true,
                        content: "모집중",
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Wrap(
                        children: [
                          Text(
                            matchBoardDetailProvider.matchingDetailPost.title,
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
                              nickName: matchBoardDetailProvider
                                  .matchingDetailPost.nickname),
                          Row(
                            children: [
                              Text(
                                matchBoardDetailProvider
                                    .matchingDetailPost.createdAt,
                                style: TextTypes.caption01(
                                  color: Palette.text04,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                "조회 2",
                                style: TextTypes.caption01(
                                  color: Palette.text04,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Palette.bgUp02,
                  thickness: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 28,
                      ),
                      Text(
                        "주고 싶은 나의 재능",
                        style: TextTypes.caption01(
                          color: Palette.text03,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Wrap(
                        children: [
                          ...matchBoardDetailProvider
                              .matchingDetailPost.giveTalents
                              .map(
                            (item) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  right: 8,
                                  bottom: 8,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 6,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Palette.bgUp02,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        4,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    item,
                                    style: TextTypes.body02(
                                      color: Palette.text02,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "받고 싶은 나의 재능",
                        style: TextTypes.caption01(
                          color: Palette.text03,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Wrap(
                        children: [
                          ...matchBoardDetailProvider
                              .matchingDetailPost.receiveTalents
                              .map(
                            (item) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  right: 8,
                                  bottom: 8,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 6,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Palette.bgUp02,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        4,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    item,
                                    style: TextTypes.body02(
                                      color: Palette.text02,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        color: Palette.bgUp02,
                        thickness: 1.0,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(
                            "진행 방식",
                            style: TextTypes.body02(
                              color: Palette.text03,
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Text(
                            matchBoardDetailProvider
                                .matchingDetailPost.exchangeType,
                            style: TextTypes.body02(
                              color: Palette.text02,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            "진행 기간",
                            style: TextTypes.body02(
                              color: Palette.text03,
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Text(
                            matchBoardDetailProvider
                                .matchingDetailPost.duration,
                            style: TextTypes.body02(
                              color: Palette.text02,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Palette.bgUp02,
                  thickness: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 24,
                    right: 24,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ...matchBoardDetailProvider.previewImageList
                              .asMap()
                              .entries
                              .take(4)
                              .map(
                            (entry) {
                              int index = entry.key;
                              var item = entry.value;

                              double imageSize =
                                  (MediaQuery.of(context).size.width - 92) / 4;

                              return Padding(
                                padding:
                                    EdgeInsets.only(right: index < 3 ? 12 : 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (index == 3) {
                                        context.push('/match-board-detail-page/match-image-view');
                                      } else {
                                        matchBoardDetailProvider
                                            .setPreviewImageIndex(index);
                                        context
                                            .push('/match-board-detail-page/match-image-view-detail');
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
                                          child: Image.file(
                                            item,
                                            width: imageSize,
                                            height: imageSize,
                                            fit: BoxFit.cover,
                                            color: index == 3
                                                ? Colors.black.withOpacity(0.6)
                                                : null,
                                            colorBlendMode: index == 3
                                                ? BlendMode.darken
                                                : null,
                                          ),
                                        ),
                                        if (index == 3)
                                          Positioned.fill(
                                            child: GestureDetector(
                                              onTap: () => context
                                                  .push('/match-board-detail-page/match-image-view'),
                                              child: Center(
                                                child: Text(
                                                  "이미지\n더보기",
                                                  style: TextTypes.bodyMedium03(
                                                    color: Palette.bgBackGround,
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
                      const SizedBox(
                        height: 50,
                      ),
                      QuillEditor.basic(
                        controller: matchBoardDetailProvider.contentController,
                        configurations: QuillEditorConfigurations(
                          showCursor: false,
                          readOnlyMouseCursor: MouseCursor.uncontrolled,
                          enableAlwaysIndentOnTab: false,
                          enableInteractiveSelection: false,
                          enableScribble: false,
                          embedBuilders: FlutterQuillEmbeds.editorBuilders(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        BottomBtn(
          otherSetting: SvgPicture.asset('assets/icons/bookmark_default.svg'),
          mediaBottom: MediaQuery.of(context).viewInsets.bottom,
          content: '채팅하기',
          isEnabled: true,
          onPressed: () async {},
        )
      ]),
    );
  }
}
