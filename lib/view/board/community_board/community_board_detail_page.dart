import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/profile.dart';
import 'package:app_front_talearnt/common/widget/state_badge.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/view/board/community_board/widget/community_detail_board_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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
                        height: 17,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Palette.bgUp02,
                  height: 1,
                  thickness:
                      communityBoardDetailProvider.previewImageList.isNotEmpty
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
                                  (MediaQuery.of(context).size.width - 92) / 4;

                              return Padding(
                                padding:
                                    EdgeInsets.only(right: index < 3 ? 12 : 0),
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
                                              onTap: () => context.push(
                                                  '/community-board-detail/community-image-view'),
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
                      QuillEditor.basic(
                        controller:
                            communityBoardDetailProvider.contentController,
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
        CommunityDetailBoardBottom(
            board: communityBoardDetailProvider.communityDetailBoard)
      ]),
    );
  }
}
