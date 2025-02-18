import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

import '../../../provider/board/match_write_provider.dart';

class MatchWriteEditorToolbar extends StatelessWidget {
  const MatchWriteEditorToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final matchWriteProvider = Provider.of<MatchWriteProvider>(context);

    return BottomAppBar(
      color: Palette.bgBackGround,
      child: getToolbar(context, matchWriteProvider),
    );
  }
}

Widget getToolbar(BuildContext context, MatchWriteProvider matchWriteProvider) {
  if (matchWriteProvider.onToolBar == "default") {
    return Row(
      children: [
        const SizedBox(width: 10),
        IconButton(
          onPressed: () async {},
          icon: SvgPicture.asset('assets/icons/link_before.svg'),
        ),
        IconButton(
          onPressed: () async {
            await matchWriteProvider.pickImagesAndInsert(context);
          },
          icon: SvgPicture.asset('assets/icons/image_before.svg'),
        ),
        IconButton(
          onPressed: () {
            matchWriteProvider.setToolbar("style");
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
              matchWriteProvider.contentController.formatSelection(
                Attribute.centerAlignment,
              );
              matchWriteProvider.toggleButton("align", "center");
            } else if (matchWriteProvider.alignType == "center") {
              matchWriteProvider.contentController.formatSelection(
                Attribute.rightAlignment,
              );
              matchWriteProvider.toggleButton("align", "right");
            } else if (matchWriteProvider.alignType == "right") {
              matchWriteProvider.contentController.formatSelection(
                Attribute.justifyAlignment,
              );
              matchWriteProvider.toggleButton("align", "justify");
            } else if (matchWriteProvider.alignType == "justify") {
              matchWriteProvider.contentController.formatSelection(
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
              "${matchWriteProvider.contentController.document.toPlainText().length - 1}/1000",
              style: TextTypes.body02(color: Palette.text04),
            ),
          ),
        )
      ],
    );
  } else if (matchWriteProvider.onToolBar == "style") {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            matchWriteProvider.setToolbar("default");
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
                    matchWriteProvider.setToolbar("fontSize");
                  },
                  icon: SvgPicture.asset(
                      'assets/icons/font_size_${matchWriteProvider.fontSize}.svg'),
                ),
                IconButton(
                  icon: matchWriteProvider.isBold
                      ? SvgPicture.asset('assets/icons/bold_after.svg')
                      : SvgPicture.asset('assets/icons/bold_before.svg'),
                  onPressed: () {
                    matchWriteProvider.isBold
                        ? matchWriteProvider.contentController.formatSelection(
                            Attribute.clone(Attribute.bold, null))
                        : matchWriteProvider.contentController
                            .formatSelection(Attribute.bold);
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
                        ? matchWriteProvider.contentController.formatSelection(
                            Attribute.clone(Attribute.italic, null),
                          )
                        : matchWriteProvider.contentController.formatSelection(
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
                        ? matchWriteProvider.contentController.formatSelection(
                            Attribute.clone(Attribute.underline, null),
                          )
                        : matchWriteProvider.contentController.formatSelection(
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
                        ? matchWriteProvider.contentController.formatSelection(
                            Attribute.clone(Attribute.ul, null),
                          )
                        : matchWriteProvider.contentController.formatSelection(
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
                        ? matchWriteProvider.contentController.formatSelection(
                            Attribute.clone(Attribute.ol, null),
                          )
                        : matchWriteProvider.contentController.formatSelection(
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
                      matchWriteProvider.contentController.formatSelection(
                        Attribute.centerAlignment,
                      );
                      matchWriteProvider.toggleButton("align", "center");
                    } else if (matchWriteProvider.alignType == "center") {
                      matchWriteProvider.contentController.formatSelection(
                        Attribute.rightAlignment,
                      );
                      matchWriteProvider.toggleButton("align", "right");
                    } else if (matchWriteProvider.alignType == "right") {
                      matchWriteProvider.contentController.formatSelection(
                        Attribute.justifyAlignment,
                      );
                      matchWriteProvider.toggleButton("align", "justify");
                    } else if (matchWriteProvider.alignType == "justify") {
                      matchWriteProvider.contentController.formatSelection(
                        Attribute.leftAlignment,
                      );
                      matchWriteProvider.toggleButton("align", "left");
                    }
                  },
                ),
                IconButton(
                  onPressed: () {
                    matchWriteProvider.setToolbar("fontColor");
                  },
                  icon: SvgPicture.asset(
                      'assets/icons/${matchWriteProvider.colorNames[matchWriteProvider.fontColor]}_off.svg'),
                ),
                IconButton(
                  onPressed: () {
                    matchWriteProvider.setToolbar("backgroundColor");
                  },
                  icon: SvgPicture.asset(
                      'assets/icons/${matchWriteProvider.colorNames[matchWriteProvider.backGroundColor]}_off.svg'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  } else if (matchWriteProvider.onToolBar == "fontSize") {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            matchWriteProvider.setToolbar("style");
          },
          icon: SvgPicture.asset('assets/icons/back_typo.svg'),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...matchWriteProvider.fontSizeList.map(
                  (item) {
                    return IconButton(
                      onPressed: () {
                        matchWriteProvider.setFontSize(item);
                        matchWriteProvider.setToolbar('style');
                        matchWriteProvider.contentController.formatSelection(
                          Attribute.fromKeyValue('size', '$item'),
                        );
                      },
                      icon: matchWriteProvider.fontSize == item
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
  } else if (matchWriteProvider.onToolBar == "fontColor") {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            matchWriteProvider.setToolbar("style");
          },
          icon: SvgPicture.asset('assets/icons/back_typo.svg'),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...matchWriteProvider.fontColorList.map(
                  (item) {
                    return IconButton(
                      onPressed: () {
                        matchWriteProvider.setFontColor(item);
                        matchWriteProvider.setToolbar('style');
                        matchWriteProvider.contentController.formatSelection(
                          Attribute.fromKeyValue('color',
                              '#${item.value.toRadixString(16).padLeft(8, '0')}'),
                        );
                      },
                      icon: matchWriteProvider.fontColor == item
                          ? SvgPicture.asset(
                              'assets/icons/${matchWriteProvider.colorNames[item]}_on.svg')
                          : SvgPicture.asset(
                              'assets/icons/${matchWriteProvider.colorNames[item]}_off.svg'),
                    );
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  } else if (matchWriteProvider.onToolBar == "backgroundColor") {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            matchWriteProvider.setToolbar("style");
          },
          icon: SvgPicture.asset('assets/icons/back_typo.svg'),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...matchWriteProvider.backGroundColorList.map(
                  (item) {
                    return IconButton(
                      onPressed: () {
                        matchWriteProvider.setBackGroundColor(item);
                        matchWriteProvider.setToolbar('style');
                        matchWriteProvider.contentController.formatSelection(
                          Attribute.fromKeyValue('background',
                              '#${item.value.toRadixString(16).padLeft(8, '0')}'),
                        );
                      },
                      icon: matchWriteProvider.backGroundColor == item
                          ? SvgPicture.asset(
                              'assets/icons/${matchWriteProvider.colorNames[item]}_on.svg')
                          : SvgPicture.asset(
                              'assets/icons/${matchWriteProvider.colorNames[item]}_off.svg'),
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
