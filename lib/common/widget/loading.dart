import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commonProvider = Provider.of<CommonProvider>(context);

    return Container(
      color: Palette.bgBackGround,
      child: Center(
        child: AnimatedBuilder(
          animation: commonProvider.animationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: commonProvider.animationController.value * 2 * 3.14159,
              // 360도 회전
              child: child,
            );
          },
          child: SvgPicture.asset('assets/icons/loading_animation.svg'),
        ),
      ),
    );
  }
}
