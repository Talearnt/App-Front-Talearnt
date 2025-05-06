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

  //해당 페이지는 원 클립이 제대로 되지 않아 이후에 다시 확인 할 필요가 있음.
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final containerWidth = MediaQuery.of(context).size.width;
          final containerHeight = MediaQuery.of(context).size.height;

          final imageWidth = profileProvider.tempImageSize!.width;
          final imageHeight = profileProvider.tempImageSize!.height;

          final widthScale = containerWidth / imageWidth;
          final heightScale = containerHeight / imageHeight;
          final scale = widthScale < heightScale ? widthScale : heightScale;

          final cropRadius = (104 * scale) / 2;

          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: Image.file(
                  profileProvider.tempImageFile!,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Positioned.fill(
                child: ClipPath(
                  clipper: CircleHoleClipper(radius: cropRadius),
                  child: Container(
                    color: Colors.black.withAlpha((0.7 * 255).toInt()),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CircleHoleClipper extends CustomClipper<Path> {
  final double radius;

  CircleHoleClipper({required this.radius});

  @override
  Path getClip(Size size) {
    final outer = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final center = Offset(size.width / 2, size.height / 2);
    final hole = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));

    return Path.combine(PathOperation.difference, outer, hole);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
