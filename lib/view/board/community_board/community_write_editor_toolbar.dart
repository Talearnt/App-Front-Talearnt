import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/view/board/match_board/match_write_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../provider/board/community_write_provider.dart';
import '../../../provider/common/common_provider.dart';

class CommunityWriteEditorToolbar extends StatelessWidget {
  const CommunityWriteEditorToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final communityWriteProvider = Provider.of<CommunityWriteProvider>(context);
    final commonProvider = Provider.of<CommonProvider>(context);

    return BottomAppBar(
      color: Palette.bgBackGround,
      child: getToolbar(context, communityWriteProvider, commonProvider),
    );
  }
}

Widget getToolbar(
    BuildContext context,
    CommunityWriteProvider communityWriteProvider,
    CommonProvider commonProvider) {
  if (communityWriteProvider.onToolBar == "default") {
    return Row(
      children: [
        const SizedBox(width: 10),
        IconButton(
          onPressed: () async {
            final linkData =
                QuillTextLink.prepare(communityWriteProvider.contentController);

            communityWriteProvider.setLink(linkData.text, linkData.link);

            final result = await MatchWriteLinkDialog.show(
                context, linkData.text, linkData.link);

            if (result == null || result["url"]!.isEmpty) return;

            final updatedLink = QuillTextLink(result["text"]!, result["url"]!);

            updatedLink.submit(communityWriteProvider.contentController);
          },
          icon: SvgPicture.asset('assets/icons/link_before.svg'),
        ),
        IconButton(
          onPressed: () async {
            await communityWriteProvider.pickImagesAndInsert(
                context, commonProvider);
          },
          icon: SvgPicture.asset('assets/icons/image_before.svg'),
        ),
        IconButton(
          onPressed: () {
            communityWriteProvider.setToolbar("style");
          },
          icon: SvgPicture.asset(
            'assets/icons/typo.svg',
          ),
        ),
        IconButton(
          icon: communityWriteProvider.alignType == "left"
              ? SvgPicture.asset(
                  'assets/icons/left_before.svg',
                )
              : communityWriteProvider.alignType == "center"
                  ? SvgPicture.asset(
                      'assets/icons/center_before.svg',
                    )
                  : communityWriteProvider.alignType == "right"
                      ? SvgPicture.asset(
                          'assets/icons/right_before.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/justify_before.svg',
                        ),
          onPressed: () {
            if (communityWriteProvider.alignType == "left") {
              communityWriteProvider.contentController.formatSelection(
                Attribute.centerAlignment,
              );
              communityWriteProvider.toggleButton("align", "center");
            } else if (communityWriteProvider.alignType == "center") {
              communityWriteProvider.contentController.formatSelection(
                Attribute.rightAlignment,
              );
              communityWriteProvider.toggleButton("align", "right");
            } else if (communityWriteProvider.alignType == "right") {
              communityWriteProvider.contentController.formatSelection(
                Attribute.justifyAlignment,
              );
              communityWriteProvider.toggleButton("align", "justify");
            } else if (communityWriteProvider.alignType == "justify") {
              communityWriteProvider.contentController.formatSelection(
                Attribute.leftAlignment,
              );
              communityWriteProvider.toggleButton("align", "left");
            }
          },
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${communityWriteProvider.contentController.document.toPlainText().length - 1}/1000",
              style: TextTypes.body02(color: Palette.text04),
            ),
          ),
        )
      ],
    );
  } else if (communityWriteProvider.onToolBar == "style") {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            communityWriteProvider.setToolbar("default");
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
                    communityWriteProvider.setToolbar("fontSize");
                  },
                  icon: SvgPicture.asset(
                      'assets/icons/font_size_${communityWriteProvider.fontSize}.svg'),
                ),
                IconButton(
                  icon: communityWriteProvider.isBold
                      ? SvgPicture.asset('assets/icons/bold_after.svg')
                      : SvgPicture.asset('assets/icons/bold_before.svg'),
                  onPressed: () {
                    communityWriteProvider.isBold
                        ? communityWriteProvider.contentController
                            .formatSelection(
                                Attribute.clone(Attribute.bold, null))
                        : communityWriteProvider.contentController
                            .formatSelection(Attribute.bold);
                    communityWriteProvider.toggleButton("bold");
                  },
                ),
                IconButton(
                  icon: communityWriteProvider.isItalic
                      ? SvgPicture.asset(
                          'assets/icons/italics_after.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/italics_before.svg',
                        ),
                  onPressed: () {
                    communityWriteProvider.isItalic
                        ? communityWriteProvider.contentController
                            .formatSelection(
                            Attribute.clone(Attribute.italic, null),
                          )
                        : communityWriteProvider.contentController
                            .formatSelection(
                            Attribute.italic,
                          );
                    communityWriteProvider.toggleButton("italic");
                  },
                ),
                IconButton(
                  icon: communityWriteProvider.isUnderline
                      ? SvgPicture.asset(
                          'assets/icons/underline_after.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/underline_before.svg',
                        ),
                  onPressed: () {
                    communityWriteProvider.isUnderline
                        ? communityWriteProvider.contentController
                            .formatSelection(
                            Attribute.clone(Attribute.underline, null),
                          )
                        : communityWriteProvider.contentController
                            .formatSelection(
                            Attribute.underline,
                          );
                    communityWriteProvider.toggleButton("underline");
                  },
                ),
                IconButton(
                  icon: communityWriteProvider.isUl
                      ? SvgPicture.asset(
                          'assets/icons/list_after.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/list_before.svg',
                        ),
                  onPressed: () {
                    communityWriteProvider.isUl
                        ? communityWriteProvider.contentController
                            .formatSelection(
                            Attribute.clone(Attribute.ul, null),
                          )
                        : communityWriteProvider.contentController
                            .formatSelection(
                            Attribute.ul,
                          );
                    communityWriteProvider.toggleButton("ul");
                  },
                ),
                IconButton(
                  icon: communityWriteProvider.isOl
                      ? SvgPicture.asset(
                          'assets/icons/listnumber_after.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/listnumber_before.svg',
                        ),
                  onPressed: () {
                    communityWriteProvider.isOl
                        ? communityWriteProvider.contentController
                            .formatSelection(
                            Attribute.clone(Attribute.ol, null),
                          )
                        : communityWriteProvider.contentController
                            .formatSelection(
                            Attribute.ol,
                          );
                    communityWriteProvider.toggleButton("ol");
                  },
                ),
                IconButton(
                  icon: communityWriteProvider.alignType == "left"
                      ? SvgPicture.asset(
                          'assets/icons/left_before.svg',
                        )
                      : communityWriteProvider.alignType == "center"
                          ? SvgPicture.asset(
                              'assets/icons/center_before.svg',
                            )
                          : communityWriteProvider.alignType == "right"
                              ? SvgPicture.asset(
                                  'assets/icons/right_before.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/justify_before.svg',
                                ),
                  onPressed: () {
                    if (communityWriteProvider.alignType == "left") {
                      communityWriteProvider.contentController.formatSelection(
                        Attribute.centerAlignment,
                      );
                      communityWriteProvider.toggleButton("align", "center");
                    } else if (communityWriteProvider.alignType == "center") {
                      communityWriteProvider.contentController.formatSelection(
                        Attribute.rightAlignment,
                      );
                      communityWriteProvider.toggleButton("align", "right");
                    } else if (communityWriteProvider.alignType == "right") {
                      communityWriteProvider.contentController.formatSelection(
                        Attribute.justifyAlignment,
                      );
                      communityWriteProvider.toggleButton("align", "justify");
                    } else if (communityWriteProvider.alignType == "justify") {
                      communityWriteProvider.contentController.formatSelection(
                        Attribute.leftAlignment,
                      );
                      communityWriteProvider.toggleButton("align", "left");
                    }
                  },
                ),
                const SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {
                    communityWriteProvider.setToolbar("fontColor");
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/text_color.svg',
                      ),
                      SvgPicture.asset(
                        'assets/icons/${communityWriteProvider.colorNames[communityWriteProvider.fontColor]}_off.svg',
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
                    communityWriteProvider.setToolbar("backgroundColor");
                  },
                  icon: SvgPicture.asset('assets/icons/background_color.svg'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  } else if (communityWriteProvider.onToolBar == "fontSize") {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            communityWriteProvider.setToolbar("style");
          },
          icon: SvgPicture.asset('assets/icons/back_typo.svg'),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...communityWriteProvider.fontSizeList.map(
                  (item) {
                    return IconButton(
                      onPressed: () {
                        communityWriteProvider.setFontSize(item);
                        communityWriteProvider.setToolbar('style');
                        communityWriteProvider.contentController
                            .formatSelection(
                          Attribute.fromKeyValue('size', '$item'),
                        );
                      },
                      icon: communityWriteProvider.fontSize == item
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
  } else if (communityWriteProvider.onToolBar == "fontColor") {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            communityWriteProvider.setToolbar("style");
          },
          icon: SvgPicture.asset('assets/icons/back_typo.svg'),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...communityWriteProvider.fontColorList.map(
                  (item) {
                    return IconButton(
                      onPressed: () {
                        communityWriteProvider.setFontColor(item);
                        communityWriteProvider.setToolbar('style');
                        communityWriteProvider.contentController
                            .formatSelection(
                          Attribute.fromKeyValue('color',
                              '#${item.toARGB32().toRadixString(16).padLeft(8, '0')}'),
                        );
                      },
                      icon: communityWriteProvider.fontColor == item
                          ? SvgPicture.asset(
                              'assets/icons/${communityWriteProvider.colorNames[item]}_on.svg')
                          : SvgPicture.asset(
                              'assets/icons/${communityWriteProvider.colorNames[item]}_off.svg'),
                    );
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  } else if (communityWriteProvider.onToolBar == "backgroundColor") {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            communityWriteProvider.setToolbar("style");
          },
          icon: SvgPicture.asset('assets/icons/back_typo.svg'),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...communityWriteProvider.backGroundColorList.map(
                  (item) {
                    return IconButton(
                      onPressed: () {
                        communityWriteProvider.setBackGroundColor(item);
                        communityWriteProvider.setToolbar('style');
                        communityWriteProvider.contentController
                            .formatSelection(
                          Attribute.fromKeyValue('background',
                              '#${item.toARGB32().toRadixString(16).padLeft(8, '0')}'),
                        );
                      },
                      icon: communityWriteProvider.backGroundColor == item
                          ? SvgPicture.asset(
                              'assets/icons/${communityWriteProvider.colorNames[item]}_on.svg')
                          : SvgPicture.asset(
                              'assets/icons/${communityWriteProvider.colorNames[item]}_off.svg'),
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
