import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/toast_message.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/provider/talearnt_board/match_write_provider.dart';
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

    ScrollController scrollController = ScrollController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: TopAppBar(
        onPressed: () {
          context.pop();
        },
        second: TextBtnM(
          content: '미리보기',
          onPressed: () {
            matchWriteProvider.checkTitleAndBoard();

            matchWriteProvider.isTitleAndBoardEmpty
                ? context.push('/match_preview')
                : ToastMessage.show(
                    context: context,
                    message: matchWriteProvider.boardToastMessage,
                    type: 2,
                    bottom: 50);
          },
        ),
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
                            matchWriteProvider.toggleButton("bold");
                          },
                        ),
                        IconButton(
                          icon: matchWriteProvider.isItalic
                              ? SvgPicture.asset(
                                  'assets/icons/italics_after.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/italics_before.svg',
                                ),
                          onPressed: () {
                            matchWriteProvider.isItalic
                                ? matchWriteProvider.contentController
                                    .formatSelection(
                                    Attribute.clone(Attribute.italic, null),
                                  )
                                : matchWriteProvider.contentController
                                    .formatSelection(
                                    Attribute.italic,
                                  );
                            matchWriteProvider.toggleButton("italic");
                          },
                        ),
                        IconButton(
                          icon: matchWriteProvider.isUnderline
                              ? SvgPicture.asset(
                                  'assets/icons/underline_after.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/underline_before.svg',
                                ),
                          onPressed: () {
                            matchWriteProvider.isUnderline
                                ? matchWriteProvider.contentController
                                    .formatSelection(
                                    Attribute.clone(Attribute.underline, null),
                                  )
                                : matchWriteProvider.contentController
                                    .formatSelection(
                                    Attribute.underline,
                                  );
                            matchWriteProvider.toggleButton("underline");
                          },
                        ),
                        IconButton(
                          icon: matchWriteProvider.isUl
                              ? SvgPicture.asset(
                                  'assets/icons/list_after.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/list_before.svg',
                                ),
                          onPressed: () {
                            matchWriteProvider.isUl
                                ? matchWriteProvider.contentController
                                    .formatSelection(
                                    Attribute.clone(Attribute.ul, null),
                                  )
                                : matchWriteProvider.contentController
                                    .formatSelection(
                                    Attribute.ul,
                                  );
                            matchWriteProvider.toggleButton("ul");
                          },
                        ),
                        IconButton(
                          icon: matchWriteProvider.isOl
                              ? SvgPicture.asset(
                                  'assets/icons/listnumber_after.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/listnumber_before.svg',
                                ),
                          onPressed: () {
                            matchWriteProvider.isOl
                                ? matchWriteProvider.contentController
                                    .formatSelection(
                                    Attribute.clone(Attribute.ol, null),
                                  )
                                : matchWriteProvider.contentController
                                    .formatSelection(
                                    Attribute.ol,
                                  );
                            matchWriteProvider.toggleButton("ol");
                          },
                        ),
                        IconButton(
                          icon: matchWriteProvider.alignType == "left"
                              ? SvgPicture.asset(
                                  'assets/icons/left_before.svg',
                                )
                              : matchWriteProvider.alignType == "center"
                                  ? SvgPicture.asset(
                                      'assets/icons/center_before.svg',
                                    )
                                  : matchWriteProvider.alignType == "right"
                                      ? SvgPicture.asset(
                                          'assets/icons/right_before.svg',
                                        )
                                      : SvgPicture.asset(
                                          'assets/icons/justify_before.svg',
                                        ),
                          onPressed: () {
                            if (matchWriteProvider.alignType == "left") {
                              matchWriteProvider.contentController
                                  .formatSelection(
                                Attribute.centerAlignment,
                              );
                              matchWriteProvider.toggleButton(
                                  "align", "center");
                            } else if (matchWriteProvider.alignType ==
                                "center") {
                              matchWriteProvider.contentController
                                  .formatSelection(
                                Attribute.rightAlignment,
                              );
                              matchWriteProvider.toggleButton("align", "right");
                            } else if (matchWriteProvider.alignType ==
                                "right") {
                              matchWriteProvider.contentController
                                  .formatSelection(
                                Attribute.justifyAlignment,
                              );
                              matchWriteProvider.toggleButton(
                                  "align", "justify");
                            } else if (matchWriteProvider.alignType ==
                                "justify") {
                              matchWriteProvider.contentController
                                  .formatSelection(
                                Attribute.leftAlignment,
                              );
                              matchWriteProvider.toggleButton("align", "left");
                            }
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
                        IconButton(
                          icon: matchWriteProvider.alignType == "left"
                              ? SvgPicture.asset(
                                  'assets/icons/left_before.svg',
                                )
                              : matchWriteProvider.alignType == "center"
                                  ? SvgPicture.asset(
                                      'assets/icons/center_before.svg',
                                    )
                                  : matchWriteProvider.alignType == "right"
                                      ? SvgPicture.asset(
                                          'assets/icons/right_before.svg',
                                        )
                                      : SvgPicture.asset(
                                          'assets/icons/justify_before.svg',
                                        ),
                          onPressed: () {
                            if (matchWriteProvider.alignType == "left") {
                              matchWriteProvider.contentController
                                  .formatSelection(
                                Attribute.centerAlignment,
                              );
                              matchWriteProvider.toggleButton(
                                  "align", "center");
                            } else if (matchWriteProvider.alignType ==
                                "center") {
                              matchWriteProvider.contentController
                                  .formatSelection(
                                Attribute.rightAlignment,
                              );
                              matchWriteProvider.toggleButton("align", "right");
                            } else if (matchWriteProvider.alignType ==
                                "right") {
                              matchWriteProvider.contentController
                                  .formatSelection(
                                Attribute.justifyAlignment,
                              );
                              matchWriteProvider.toggleButton(
                                  "align", "justify");
                            } else if (matchWriteProvider.alignType ==
                                "justify") {
                              matchWriteProvider.contentController
                                  .formatSelection(
                                Attribute.leftAlignment,
                              );
                              matchWriteProvider.toggleButton("align", "left");
                            }
                          },
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