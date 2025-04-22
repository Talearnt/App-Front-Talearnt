import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../common/widget/button.dart';
import '../../common/widget/top_app_bar.dart';
import '../../provider/profile/profile_provider.dart';

class UserImagePreviewPage extends StatelessWidget {
  const UserImagePreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    if (profileProvider.tempImageFile == null) {
      return Scaffold(
        body: Container(),
      );
    }
    return Scaffold(
      appBar: TopAppBar(
        content: "",
        leftWidget: IconButton(
          hoverColor: Colors.transparent,
          icon: SvgPicture.asset(
            'assets/icons/back_arrow_white.svg', // SVG 파일 경로
          ),
          onPressed: () => context.pop(),
        ),
        first: TextBtnM(
            content: '등록',
            btnStyle: TextTypes.body02(color: Palette.primary01),
            onPressed: () {
              profileProvider.applyTempImage();
              context.go('/modify-user-info');
            }),
        bgColor: Palette.text01,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: Colors.black, // 검정색 배경
            alignment: Alignment.center,
            child: Image.file(
              profileProvider.tempImageFile!,
              fit: BoxFit.contain, // 비율 유지하면서 중앙 배치
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned.fill(
            child: ClipPath(
              clipper: CircleHoleClipper(),
              child: Container(
                color: Colors.black.withAlpha((0.6 * 255).toInt()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleHoleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final outer = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final center = Offset(size.width / 2, size.height / 2);
    const radius = 208.0;
    final hole = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));

    return Path.combine(PathOperation.difference, outer, hole);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
