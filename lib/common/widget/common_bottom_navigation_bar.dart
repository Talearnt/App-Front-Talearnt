import 'package:app_front_talearnt/view/home/widget/home_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../provider/auth/login_provider.dart';
import '../../provider/common/common_provider.dart';
import '../../view_model/board_view_model.dart';
import '../theme.dart';

class CommonBottomNavigationBar extends StatelessWidget {
  const CommonBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final commonProvider = context.read<CommonProvider>();
    final loginProvider = context.read<LoginProvider>();

    final boardViewModel = Provider.of<BoardViewModel>(context);
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 56,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Palette.line01,
              width: 1.0,
            ),
          ),
        ),
        child: BottomAppBar(
          padding: const EdgeInsets.symmetric(vertical: 8.5),
          color: Palette.bgBackGround,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    context.go('/home');
                    commonProvider.changeSelectedPage('home');
                  },
                  child: Column(
                    children: [
                      commonProvider.selectedPage == 'home'
                          ? SvgPicture.asset('assets/icons/home_on.svg')
                          : SvgPicture.asset('assets/icons/home_off.svg'),
                      Text(
                        '홈',
                        style: TextTypes.label01(
                            color: commonProvider.selectedPage == 'home'
                                ? Palette.text01
                                : Palette.text04),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () async {
                    commonProvider.changeIsLoading(true);
                    await boardViewModel.getInitMatchBoardList();
                    commonProvider.changeSelectedPage('board_list');
                    commonProvider.changeIsLoading(false);
                  },
                  child: Column(
                    children: [
                      commonProvider.selectedPage == 'board_list'
                          ? SvgPicture.asset('assets/icons/post_on.svg')
                          : SvgPicture.asset('assets/icons/post_off.svg'),
                      Text(
                        '게시글',
                        style: TextTypes.label01(
                            color: commonProvider.selectedPage == 'board_list'
                                ? Palette.text01
                                : Palette.text04),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () async {
                    if (loginProvider.isLoggedIn) {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        builder: (BuildContext context) {
                          return const HomeBottomSheet();
                        },
                      );
                    } else {
                      context.push('/login');
                    }
                  },
                  child: Column(
                    children: [
                      commonProvider.selectedPage == 'write_board'
                          ? SvgPicture.asset('assets/icons/write_on.svg')
                          : SvgPicture.asset('assets/icons/write_off.svg'),
                      Text(
                        '글쓰기',
                        style: TextTypes.label01(
                            color: commonProvider.selectedPage == 'write_board'
                                ? Palette.text01
                                : Palette.text04),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    context.go('/profile');
                    commonProvider.changeSelectedPage('profile');
                  },
                  child: Column(
                    children: [
                      commonProvider.selectedPage == 'profile'
                          ? SvgPicture.asset('assets/icons/my_on.svg')
                          : SvgPicture.asset('assets/icons/my_off.svg'),
                      Text(
                        '마이',
                        style: TextTypes.label01(
                            color: commonProvider.selectedPage == 'profile'
                                ? Palette.text01
                                : Palette.text04),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
