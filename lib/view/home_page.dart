import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../view_model/keyword_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final keywordViewModel = Provider.of<KeywordViewModel>(context);

    return Scaffold(
      appBar: TopAppBar(
        leftIcon: false,
        first: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: SvgPicture.asset("assets/icons/close.svg")),
      ),
      bottomNavigationBar: Container(
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
              horizontal: 24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/home_on.svg'),
                      const Text('홈'),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.push('/match-board-list');
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/post_off.svg'),
                      const Text(
                        '게시글',
                        style: TextStyle(
                          color: Color(0xFFA6B0B5),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await keywordViewModel.getOfferedKeywords();

                    context.push('/match_write1');
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/write_off.svg'),
                      const Text(
                        '글쓰기',
                        style: TextStyle(
                          color: Color(0xFFA6B0B5),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/chat_off.svg'),
                      const Text(
                        '채팅',
                        style: TextStyle(
                          color: Color(0xFFA6B0B5),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/my_off.svg'),
                      const Text(
                        '마이',
                        style: TextStyle(
                          color: Color(0xFFA6B0B5),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
