import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/provider/auth/match_write_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart';

class MatchWrite2Page extends StatelessWidget {
  const MatchWrite2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final matchWriteProvider = Provider.of<MatchWriteProvider>(context);

    // QuillEditor와 QuillToolbar에 필요한 ScrollController
    ScrollController scrollController = ScrollController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: TopAppBar(
        onPressed: () {
          context.pop();
        },
        second: const TextBtnM(content: '미리보기'),
        first: const PrimaryS(content: '등록'),
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
          child: BottomAppBar(
            color: Palette.bgBackGround,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: matchWriteProvider.onToolBar
                  ? Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            matchWriteProvider.setToolbar(false);
                          },
                          icon: SvgPicture.asset('assets/icons/back_typo.svg'),
                        ),
                        IconButton(
                          icon: matchWriteProvider.isBold
                              ? SvgPicture.asset(
                                  'assets/icons/bold_after.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/bold_before.svg',
                                ),
                          onPressed: () {
                            matchWriteProvider.isBold
                                ? matchWriteProvider.contentController
                                    .formatSelection(
                                    Attribute.clone(Attribute.bold, null),
                                  )
                                : matchWriteProvider.contentController
                                    .formatSelection(
                                    Attribute.bold,
                                  );
                          },
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/italics_before.svg',
                          ),
                          onPressed: () {
                            matchWriteProvider.contentController
                                .formatSelection(
                              Attribute.italic,
                            );
                          },
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/underline_before.svg',
                          ),
                          onPressed: () {
                            matchWriteProvider.contentController
                                .formatSelection(
                              Attribute.underline,
                            );
                          },
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          'assets/icons/link_before.svg',
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SvgPicture.asset(
                          'assets/icons/image_before.svg',
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            matchWriteProvider.setToolbar(true);
                          },
                          icon: SvgPicture.asset(
                            'assets/icons/typo.svg',
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          'assets/icons/center_before.svg',
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${matchWriteProvider.contentController.document.toPlainText().length - 1}/1000", // 텍스트 길이 계산
                              style: TextTypes.bodyLarge02(
                                color: Palette.text04,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ),
      ),
      body: Padding(
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
                hintStyle: TextTypes.heading(
                  color: Palette.text04,
                ),
              ),
              style: TextTypes.heading(
                color: Palette.text02,
              ),
              controller: matchWriteProvider.titlerController,
              focusNode: matchWriteProvider.titleFocusNode,
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
                controller: matchWriteProvider.contentController,
                focusNode: matchWriteProvider.contentFocusNode,
                scrollController: scrollController,
                configurations: QuillEditorConfigurations(
                  placeholder: "내용을 입력해주세요",
                  expands: true,
                  customStyles: DefaultStyles(
                    placeHolder: DefaultTextBlockStyle(
                      TextTypes.bodyLarge02(color: Palette.text04),
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
    );
  }
}
