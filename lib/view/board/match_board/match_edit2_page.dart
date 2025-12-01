import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/loading.dart';
import 'package:app_front_talearnt/common/widget/toast_message.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/provider/board/match_edit_provider.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/view/board/match_board/match_edit_editor_toolbar.dart';
import 'package:app_front_talearnt/view/board/match_board/widget/match_edit_hyperlink_dialog.dart';
import 'package:app_front_talearnt/view/board/match_board/widget/match_write_hyperlink_dialog.dart';
import 'package:app_front_talearnt/view_model/board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MatchEdit2Page extends StatelessWidget {
  const MatchEdit2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final matchEditProvider = Provider.of<MatchEditProvider>(context);
    final boardViewModel = Provider.of<BoardViewModel>(context);
    final commonProvider = Provider.of<CommonProvider>(context);

    ScrollController scrollController = ScrollController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: TopAppBar(
        onPressed: () {
          context.go('/match-edit1');
        },
        second: TextBtnM(
          content: '미리보기',
          onPressed: () {
            matchEditProvider.checkTitleAndBoard();

            if (matchEditProvider.isTitleAndBoardEmpty) {
              matchEditProvider.makePreviewImageList();
              context.push('/match-edit-preview');
            } else {
              ToastMessage.show(
                  context: context,
                  message: matchEditProvider.boardToastMessage,
                  type: 2,
                  bottom: 50);
            }
          },
        ),
        first: PrimaryS(
          content: '완료',
          onPressed: () async {
            matchEditProvider.checkTitleAndBoard();

            if (matchEditProvider.isTitleAndBoardEmpty) {
              await MatchEditHyperlinkDialog.show(context, null);
            } else {
              ToastMessage.show(
                context: context,
                message: matchEditProvider.boardToastMessage,
                type: 2,
                bottom: 50,
              );
            }
          },
        ),
      ),
      bottomNavigationBar: AnimatedPadding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        duration: const Duration(milliseconds: 0),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Palette.line01,
                width: 1.0,
              ),
            ),
          ),
          child: const MatchEditEditorToolbar(),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 24,
              right: 24,
            ),
            child: Column(
              children: [
                // 제목 입력 필드
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "제목을 입력해주세요",
                    hintStyle: TextTypes.heading2(
                      color: Palette.text04,
                    ),
                  ),
                  style: TextTypes.heading2(
                    color: Palette.text02,
                  ),
                  controller: matchEditProvider.titleController,
                  focusNode: matchEditProvider.titleFocusNode,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Divider(
                  color: Palette.bgUp02,
                  thickness: 1.0,
                ),
                const SizedBox(
                  height: 16,
                ),

                Expanded(
                  child: QuillEditor(
                    controller: matchEditProvider.contentController,
                    focusNode: matchEditProvider.contentFocusNode,
                    scrollController: scrollController,
                    config: QuillEditorConfig(
                      embedBuilders: FlutterQuillEmbeds.editorBuilders(
                          imageEmbedConfig: QuillEditorImageEmbedConfig(
                              onImageClicked: (String image) {})),
                      placeholder: "내용을 입력해주세요",
                      expands: true,
                      customStyles: DefaultStyles(
                        placeHolder: DefaultTextBlockStyle(
                          TextTypes.body02(color: Palette.text04),
                          const HorizontalSpacing(10, 10),
                          const VerticalSpacing(10, 10),
                          const VerticalSpacing(10, 10),
                          null,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (commonProvider.isLoadingPage) const LoadingWithCharacter()
        ],
      ),
    );
  }
}
