import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/loading.dart';
import 'package:app_front_talearnt/common/widget/profile.dart';
import 'package:app_front_talearnt/common/widget/state_badge.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/view/board/community_board/community_comments.dart';
import 'package:app_front_talearnt/view/board/community_board/widget/community_detail_board_bottom.dart';
import 'package:app_front_talearnt/view/board/community_board/widget/community_detail_board_comment_input.dart';
import 'package:app_front_talearnt/view_model/board_view_model.dart';
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
    final commonProvider = Provider.of<CommonProvider>(context);
    final viewModel = Provider.of<BoardViewModel>(context);

    return Scaffold(
      appBar: TopAppBar(
        onPressed: () {
          communityBoardDetailProvider.clearProvider();
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
                                                      ? Colors.black.withValues(
                                                          alpha: 153)
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
                              config: QuillEditorConfig(
                                showCursor: false,
                                readOnlyMouseCursor: MouseCursor.uncontrolled,
                                enableAlwaysIndentOnTab: false,
                                enableInteractiveSelection: false,
                                enableScribble: false,
                                embedBuilders:
                                    FlutterQuillEmbeds.editorBuilders(
                                        imageEmbedConfig:
                                            QuillEditorImageEmbedConfig(
                                                onImageClicked:
                                                    (String image) {})),
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
                                        text:
                                            '(${communityBoardDetailProvider.communityDetailBoard.commentCount})',
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
                          CommunityComments(
                            communityBoardDetailProvider:
                                communityBoardDetailProvider,
                            profileProvider: profileProvider,
                            loadComments: (postNo, lastNo) =>
                                viewModel.getComments(postNo, lastNo),
                            loadReplies: (commentNo, lastNo) =>
                                viewModel.getReplies(commentNo, lastNo),
                            detailPageContext: context,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              communityBoardDetailProvider.isCommentInputActive
                  ? CommunityDetailBoardCommentInput(
                      communityBoardDetailProvider:
                          communityBoardDetailProvider,
                      insertComment: (postNo, content) =>
                          viewModel.insertComment(postNo, content),
                      updateComment: (content) =>
                          viewModel.updateComment(content),
                      insertReply: (commentNo, content) =>
                          viewModel.insertReply(commentNo, content),
                      updateReply: (content) => viewModel.updateReply(content),
                    )
                  : CommunityDetailBoardBottom(
                      communityBoardDetailProvider:
                          communityBoardDetailProvider,
                    )
            ],
          ),
          if (commonProvider.isLoadingPage) const Loading()
        ],
      ),
    );
  }
}
