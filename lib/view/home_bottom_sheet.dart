import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/board/match_write_provider.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/provider/profile/profile_provider.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeBottomSheet extends StatelessWidget {
  const HomeBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final matchWriteProvider = context.read<MatchWriteProvider>();
    final profileProvider = context.read<ProfileProvider>();
    final commonProvider = Provider.of<CommonProvider>(context);

    return Wrap(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 44, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () async {
                  commonProvider.changeIsLoading(true);
                  matchWriteProvider.setGiveTalentKeyword(
                    profileProvider.userProfile.giveTalents,
                  );
                  context.push('/match-write1');
                  commonProvider.changeIsLoading(false);
                },
                child: Center(
                  child: Text(
                    "매칭 글쓰기",
                    style: TextTypes.bodyMedium01(
                      color: Palette.text01,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Palette.line02,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () async {
                  commonProvider.changeIsLoading(true);
                  context.push('/community-write1');
                  commonProvider.changeIsLoading(false);
                },
                child: Center(
                  child: Text(
                    "커뮤니티 글쓰기",
                    style: TextTypes.bodyMedium01(
                      color: Palette.text01,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Palette.line02,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  context.pop();
                },
                child: Center(
                  child: Text(
                    "취소",
                    style: TextTypes.bodyMedium01(
                      color: Palette.text04,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
