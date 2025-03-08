import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/board/match_edit_provider.dart';
import 'package:app_front_talearnt/view/board/match_board/match_write_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

class MatchEditEditorToolbar extends StatelessWidget {
  const MatchEditEditorToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final matchEditProvider = Provider.of<MatchEditProvider>(context);

    return BottomAppBar(
      color: Palette.bgBackGround,
      child: getToolbar(context, matchEditProvider),
    );
  }
}

Widget getToolbar(BuildContext context, MatchEditProvider matchEditProvider) {
  if (matchEditProvider.onToolBar == "default") {
    return Row(
      children: [
        const SizedBox(width: 10),
        IconButton(
          onPressed: () async {
            final linkData =
                QuillTextLink.prepare(matchEditProvider.contentController);

            matchEditProvider.setLink(linkData.text, linkData.link);

            final result = await MatchWriteLinkDialog.show(
                context, linkData.text, linkData.link);

            if (result == null || result["url"]!.isEmpty) return;

            final updatedLink = QuillTextLink(result["text"]!, result["url"]!);

            updatedLink.submit(matchEditProvider.contentController);
          },
          icon: SvgPicture.asset('assets/icons/link_before.svg'),
        ),
        IconButton(
          onPressed: () async {
            await matchEditProvider.pickImagesAndInsert(context);
          },
          icon: SvgPicture.asset('assets/icons/image_before.svg'),
        ),
        IconButton(
          onPressed: () {
            matchEditProvider.setToolbar("style");
          },
          icon: SvgPicture.asset(
            'assets/icons/typo.svg',
          ),
        ),
        IconButton(
          icon: matchEditProvider.alignType == "left"
              ? SvgPicture.asset(
                  'assets/icons/left_before.svg',
                )
              : matchEditProvider.alignType == "center"
                  ? SvgPicture.asset(
                      'assets/icons/center_before.svg',
                    )
                  : matchEditProvider.alignType == "right"
                      ? SvgPicture.asset(
                          'assets/icons/right_before.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/justify_before.svg',
                        ),
          onPressed: () {
            if (matchEditProvider.alignType == "left") {
              matchEditProvider.contentController.formatSelection(
                Attribute.centerAlignment,
              );
              matchEditProvider.toggleButton("align", "center");
            } else if (matchEditProvider.alignType == "center") {
              matchEditProvider.contentController.formatSelection(
                Attribute.rightAlignment,
              );
              matchEditProvider.toggleButton("align", "right");
            } else if (matchEditProvider.alignType == "right") {
              matchEditProvider.contentController.formatSelection(
                Attribute.justifyAlignment,
              );
              matchEditProvider.toggleButton("align", "justify");
            } else if (matchEditProvider.alignType == "justify") {
              matchEditProvider.contentController.formatSelection(
                Attribute.leftAlignment,
              );
              matchEditProvider.toggleButton("align", "left");
            }
          },
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${matchEditProvider.contentController.document.toPlainText().length - 1}/1000",
              style: TextTypes.body02(color: Palette.text04),
            ),
          ),
        )
      ],
    );
  } else if (matchEditProvider.onToolBar == "style") {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            matchEditProvider.setToolbar("default");
          },
          icon: SvgPicture.asset('assets/icons/back_typo.svg'),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    matchEditProvider.setToolbar("fontSize");
                  },
                  icon: SvgPicture.asset(
                      'assets/icons/font_size_${matchEditProvider.fontSize}.svg'),
                ),
                IconButton(
                  icon: matchEditProvider.isBold
                      ? SvgPicture.asset('assets/icons/bold_after.svg')
                      : SvgPicture.asset('assets/icons/bold_before.svg'),
                  onPressed: () {
                    matchEditProvider.isBold
                        ? matchEditProvider.contentController.formatSelection(
                            Attribute.clone(Attribute.bold, null))
                        : matchEditProvider.contentController
                            .formatSelection(Attribute.bold);
                    matchEditProvider.toggleButton("bold");
                  },
                ),
                IconButton(
                  icon: matchEditProvider.isItalic
                      ? SvgPicture.asset(
                          'assets/icons/italics_after.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/italics_before.svg',
                        ),
                  onPressed: () {
                    matchEditProvider.isItalic
                        ? matchEditProvider.contentController.formatSelection(
                            Attribute.clone(Attribute.italic, null),
                          )
                        : matchEditProvider.contentController.formatSelection(
                            Attribute.italic,
                          );
                    matchEditProvider.toggleButton("italic");
                  },
                ),
                IconButton(
                  icon: matchEditProvider.isUnderline
                      ? SvgPicture.asset(
                          'assets/icons/underline_after.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/underline_before.svg',
                        ),
                  onPressed: () {
                    matchEditProvider.isUnderline
                        ? matchEditProvider.contentController.formatSelection(
                            Attribute.clone(Attribute.underline, null),
                          )
                        : matchEditProvider.contentController.formatSelection(
                            Attribute.underline,
                          );
                    matchEditProvider.toggleButton("underline");
                  },
                ),
                IconButton(
                  icon: matchEditProvider.isUl
                      ? SvgPicture.asset(
                          'assets/icons/list_after.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/list_before.svg',
                        ),
                  onPressed: () {
                    matchEditProvider.isUl
                        ? matchEditProvider.contentController.formatSelection(
                            Attribute.clone(Attribute.ul, null),
                          )
                        : matchEditProvider.contentController.formatSelection(
                            Attribute.ul,
                          );
                    matchEditProvider.toggleButton("ul");
                  },
                ),
                IconButton(
                  icon: matchEditProvider.isOl
                      ? SvgPicture.asset(
                          'assets/icons/listnumber_after.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/listnumber_before.svg',
                        ),
                  onPressed: () {
                    matchEditProvider.isOl
                        ? matchEditProvider.contentController.formatSelection(
                            Attribute.clone(Attribute.ol, null),
                          )
                        : matchEditProvider.contentController.formatSelection(
                            Attribute.ol,
                          );
                    matchEditProvider.toggleButton("ol");
                  },
                ),
                IconButton(
                  icon: matchEditProvider.alignType == "left"
                      ? SvgPicture.asset(
                          'assets/icons/left_before.svg',
                        )
                      : matchEditProvider.alignType == "center"
                          ? SvgPicture.asset(
                              'assets/icons/center_before.svg',
                            )
                          : matchEditProvider.alignType == "right"
                              ? SvgPicture.asset(
                                  'assets/icons/right_before.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/justify_before.svg',
                                ),
                  onPressed: () {
                    if (matchEditProvider.alignType == "left") {
                      matchEditProvider.contentController.formatSelection(
                        Attribute.centerAlignment,
                      );
                      matchEditProvider.toggleButton("align", "center");
                    } else if (matchEditProvider.alignType == "center") {
                      matchEditProvider.contentController.formatSelection(
                        Attribute.rightAlignment,
                      );
                      matchEditProvider.toggleButton("align", "right");
                    } else if (matchEditProvider.alignType == "right") {
                      matchEditProvider.contentController.formatSelection(
                        Attribute.justifyAlignment,
                      );
                      matchEditProvider.toggleButton("align", "justify");
                    } else if (matchEditProvider.alignType == "justify") {
                      matchEditProvider.contentController.formatSelection(
                        Attribute.leftAlignment,
                      );
                      matchEditProvider.toggleButton("align", "left");
                    }
                  },
                ),
                const SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {
                    matchEditProvider.setToolbar("fontColor");
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/text_color.svg',
                      ),
                      SvgPicture.asset(
                        'assets/icons/${matchEditProvider.colorNames[matchEditProvider.fontColor]}_off.svg',
                        width: 6,
                        height: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                IconButton(
                  onPressed: () {
                    matchEditProvider.setToolbar("backgroundColor");
                  },
                  icon: SvgPicture.asset('assets/icons/background_color.svg'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  } else if (matchEditProvider.onToolBar == "fontSize") {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            matchEditProvider.setToolbar("style");
          },
          icon: SvgPicture.asset('assets/icons/back_typo.svg'),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...matchEditProvider.fontSizeList.map(
                  (item) {
                    return IconButton(
                      onPressed: () {
                        matchEditProvider.setFontSize(item);
                        matchEditProvider.setToolbar('style');
                        matchEditProvider.contentController.formatSelection(
                          Attribute.fromKeyValue('size', '$item'),
                        );
                      },
                      icon: matchEditProvider.fontSize == item
                          ? SvgPicture.asset(
                              'assets/icons/font_size_${item}_on.svg')
                          : SvgPicture.asset(
                              'assets/icons/font_size_${item}_off.svg'),
                    );
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  } else if (matchEditProvider.onToolBar == "fontColor") {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            matchEditProvider.setToolbar("style");
          },
          icon: SvgPicture.asset('assets/icons/back_typo.svg'),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...matchEditProvider.fontColorList.map(
                  (item) {
                    return IconButton(
                      onPressed: () {
                        matchEditProvider.setFontColor(item);
                        matchEditProvider.setToolbar('style');
                        matchEditProvider.contentController.formatSelection(
                          Attribute.fromKeyValue('color',
                              '#${item.value.toRadixString(16).padLeft(8, '0')}'),
                        );
                      },
                      icon: matchEditProvider.fontColor == item
                          ? SvgPicture.asset(
                              'assets/icons/${matchEditProvider.colorNames[item]}_on.svg')
                          : SvgPicture.asset(
                              'assets/icons/${matchEditProvider.colorNames[item]}_off.svg'),
                    );
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  } else if (matchEditProvider.onToolBar == "backgroundColor") {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            matchEditProvider.setToolbar("style");
          },
          icon: SvgPicture.asset('assets/icons/back_typo.svg'),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...matchEditProvider.backGroundColorList.map(
                  (item) {
                    return IconButton(
                      onPressed: () {
                        matchEditProvider.setBackGroundColor(item);
                        matchEditProvider.setToolbar('style');
                        matchEditProvider.contentController.formatSelection(
                          Attribute.fromKeyValue('background',
                              '#${item.value.toRadixString(16).padLeft(8, '0')}'),
                        );
                      },
                      icon: matchEditProvider.backGroundColor == item
                          ? SvgPicture.asset(
                              'assets/icons/${matchEditProvider.colorNames[item]}_on.svg')
                          : SvgPicture.asset(
                              'assets/icons/${matchEditProvider.colorNames[item]}_off.svg'),
                    );
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  } else {
    return const SizedBox.shrink();
  }
}
