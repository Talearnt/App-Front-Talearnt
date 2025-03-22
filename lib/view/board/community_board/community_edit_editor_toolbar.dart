import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/view/board/match_board/match_write_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../provider/board/community_edit_provider.dart';

class CommunityEditEditorToolbar extends StatelessWidget {
  const CommunityEditEditorToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final communityEditProvider = Provider.of<CommunityEditProvider>(context);

    return BottomAppBar(
      color: Palette.bgBackGround,
      child: getToolbar(context, communityEditProvider),
    );
  }
}

Widget getToolbar(
    BuildContext context, CommunityEditProvider communityEditProvider) {
  if (communityEditProvider.onToolBar == "default") {
    return Row(
      children: [
        const SizedBox(width: 10),
        IconButton(
          onPressed: () async {
            final linkData =
                QuillTextLink.prepare(communityEditProvider.contentController);

            communityEditProvider.setLink(linkData.text, linkData.link);

            final result = await MatchWriteLinkDialog.show(
                context, linkData.text, linkData.link);

            if (result == null || result["url"]!.isEmpty) return;

            final updatedLink = QuillTextLink(result["text"]!, result["url"]!);

            updatedLink.submit(communityEditProvider.contentController);
          },
          icon: SvgPicture.asset('assets/icons/link_before.svg'),
        ),
        IconButton(
          onPressed: () async {
            await communityEditProvider.pickImagesAndInsert(context);
          },
          icon: SvgPicture.asset('assets/icons/image_before.svg'),
        ),
        IconButton(
          onPressed: () {
            communityEditProvider.setToolbar("style");
          },
          icon: SvgPicture.asset(
            'assets/icons/typo.svg',
          ),
        ),
        IconButton(
          icon: communityEditProvider.alignType == "left"
              ? SvgPicture.asset(
                  'assets/icons/left_before.svg',
                )
              : communityEditProvider.alignType == "center"
                  ? SvgPicture.asset(
                      'assets/icons/center_before.svg',
                    )
                  : communityEditProvider.alignType == "right"
                      ? SvgPicture.asset(
                          'assets/icons/right_before.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/justify_before.svg',
                        ),
          onPressed: () {
            if (communityEditProvider.alignType == "left") {
              communityEditProvider.contentController.formatSelection(
                Attribute.centerAlignment,
              );
              communityEditProvider.toggleButton("align", "center");
            } else if (communityEditProvider.alignType == "center") {
              communityEditProvider.contentController.formatSelection(
                Attribute.rightAlignment,
              );
              communityEditProvider.toggleButton("align", "right");
            } else if (communityEditProvider.alignType == "right") {
              communityEditProvider.contentController.formatSelection(
                Attribute.justifyAlignment,
              );
              communityEditProvider.toggleButton("align", "justify");
            } else if (communityEditProvider.alignType == "justify") {
              communityEditProvider.contentController.formatSelection(
                Attribute.leftAlignment,
              );
              communityEditProvider.toggleButton("align", "left");
            }
          },
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${communityEditProvider.contentController.document.toPlainText().length - 1}/1000",
              style: TextTypes.body02(color: Palette.text04),
            ),
          ),
        )
      ],
    );
  } else if (communityEditProvider.onToolBar == "style") {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            communityEditProvider.setToolbar("default");
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
                    communityEditProvider.setToolbar("fontSize");
                  },
                  icon: SvgPicture.asset(
                      'assets/icons/font_size_${communityEditProvider.fontSize}.svg'),
                ),
                IconButton(
                  icon: communityEditProvider.isBold
                      ? SvgPicture.asset('assets/icons/bold_after.svg')
                      : SvgPicture.asset('assets/icons/bold_before.svg'),
                  onPressed: () {
                    communityEditProvider.isBold
                        ? communityEditProvider.contentController
                            .formatSelection(
                                Attribute.clone(Attribute.bold, null))
                        : communityEditProvider.contentController
                            .formatSelection(Attribute.bold);
                    communityEditProvider.toggleButton("bold");
                  },
                ),
                IconButton(
                  icon: communityEditProvider.isItalic
                      ? SvgPicture.asset(
                          'assets/icons/italics_after.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/italics_before.svg',
                        ),
                  onPressed: () {
                    communityEditProvider.isItalic
                        ? communityEditProvider.contentController
                            .formatSelection(
                            Attribute.clone(Attribute.italic, null),
                          )
                        : communityEditProvider.contentController
                            .formatSelection(
                            Attribute.italic,
                          );
                    communityEditProvider.toggleButton("italic");
                  },
                ),
                IconButton(
                  icon: communityEditProvider.isUnderline
                      ? SvgPicture.asset(
                          'assets/icons/underline_after.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/underline_before.svg',
                        ),
                  onPressed: () {
                    communityEditProvider.isUnderline
                        ? communityEditProvider.contentController
                            .formatSelection(
                            Attribute.clone(Attribute.underline, null),
                          )
                        : communityEditProvider.contentController
                            .formatSelection(
                            Attribute.underline,
                          );
                    communityEditProvider.toggleButton("underline");
                  },
                ),
                IconButton(
                  icon: communityEditProvider.isUl
                      ? SvgPicture.asset(
                          'assets/icons/list_after.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/list_before.svg',
                        ),
                  onPressed: () {
                    communityEditProvider.isUl
                        ? communityEditProvider.contentController
                            .formatSelection(
                            Attribute.clone(Attribute.ul, null),
                          )
                        : communityEditProvider.contentController
                            .formatSelection(
                            Attribute.ul,
                          );
                    communityEditProvider.toggleButton("ul");
                  },
                ),
                IconButton(
                  icon: communityEditProvider.isOl
                      ? SvgPicture.asset(
                          'assets/icons/listnumber_after.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/listnumber_before.svg',
                        ),
                  onPressed: () {
                    communityEditProvider.isOl
                        ? communityEditProvider.contentController
                            .formatSelection(
                            Attribute.clone(Attribute.ol, null),
                          )
                        : communityEditProvider.contentController
                            .formatSelection(
                            Attribute.ol,
                          );
                    communityEditProvider.toggleButton("ol");
                  },
                ),
                IconButton(
                  icon: communityEditProvider.alignType == "left"
                      ? SvgPicture.asset(
                          'assets/icons/left_before.svg',
                        )
                      : communityEditProvider.alignType == "center"
                          ? SvgPicture.asset(
                              'assets/icons/center_before.svg',
                            )
                          : communityEditProvider.alignType == "right"
                              ? SvgPicture.asset(
                                  'assets/icons/right_before.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/justify_before.svg',
                                ),
                  onPressed: () {
                    if (communityEditProvider.alignType == "left") {
                      communityEditProvider.contentController.formatSelection(
                        Attribute.centerAlignment,
                      );
                      communityEditProvider.toggleButton("align", "center");
                    } else if (communityEditProvider.alignType == "center") {
                      communityEditProvider.contentController.formatSelection(
                        Attribute.rightAlignment,
                      );
                      communityEditProvider.toggleButton("align", "right");
                    } else if (communityEditProvider.alignType == "right") {
                      communityEditProvider.contentController.formatSelection(
                        Attribute.justifyAlignment,
                      );
                      communityEditProvider.toggleButton("align", "justify");
                    } else if (communityEditProvider.alignType == "justify") {
                      communityEditProvider.contentController.formatSelection(
                        Attribute.leftAlignment,
                      );
                      communityEditProvider.toggleButton("align", "left");
                    }
                  },
                ),
                const SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {
                    communityEditProvider.setToolbar("fontColor");
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/text_color.svg',
                      ),
                      SvgPicture.asset(
                        'assets/icons/${communityEditProvider.colorNames[communityEditProvider.fontColor]}_off.svg',
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
                    communityEditProvider.setToolbar("backgroundColor");
                  },
                  icon: SvgPicture.asset('assets/icons/background_color.svg'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  } else if (communityEditProvider.onToolBar == "fontSize") {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            communityEditProvider.setToolbar("style");
          },
          icon: SvgPicture.asset('assets/icons/back_typo.svg'),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...communityEditProvider.fontSizeList.map(
                  (item) {
                    return IconButton(
                      onPressed: () {
                        communityEditProvider.setFontSize(item);
                        communityEditProvider.setToolbar('style');
                        communityEditProvider.contentController.formatSelection(
                          Attribute.fromKeyValue('size', '$item'),
                        );
                      },
                      icon: communityEditProvider.fontSize == item
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
  } else if (communityEditProvider.onToolBar == "fontColor") {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            communityEditProvider.setToolbar("style");
          },
          icon: SvgPicture.asset('assets/icons/back_typo.svg'),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...communityEditProvider.fontColorList.map(
                  (item) {
                    return IconButton(
                      onPressed: () {
                        communityEditProvider.setFontColor(item);
                        communityEditProvider.setToolbar('style');
                        communityEditProvider.contentController.formatSelection(
                          Attribute.fromKeyValue('color',
                              '#${item.value.toRadixString(16).padLeft(8, '0')}'),
                        );
                      },
                      icon: communityEditProvider.fontColor == item
                          ? SvgPicture.asset(
                              'assets/icons/${communityEditProvider.colorNames[item]}_on.svg')
                          : SvgPicture.asset(
                              'assets/icons/${communityEditProvider.colorNames[item]}_off.svg'),
                    );
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  } else if (communityEditProvider.onToolBar == "backgroundColor") {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            communityEditProvider.setToolbar("style");
          },
          icon: SvgPicture.asset('assets/icons/back_typo.svg'),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...communityEditProvider.backGroundColorList.map(
                  (item) {
                    return IconButton(
                      onPressed: () {
                        communityEditProvider.setBackGroundColor(item);
                        communityEditProvider.setToolbar('style');
                        communityEditProvider.contentController.formatSelection(
                          Attribute.fromKeyValue('background',
                              '#${item.value.toRadixString(16).padLeft(8, '0')}'),
                        );
                      },
                      icon: communityEditProvider.backGroundColor == item
                          ? SvgPicture.asset(
                              'assets/icons/${communityEditProvider.colorNames[item]}_on.svg')
                          : SvgPicture.asset(
                              'assets/icons/${communityEditProvider.colorNames[item]}_off.svg'),
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
