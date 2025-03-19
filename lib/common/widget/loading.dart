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

class LoadingWithCharacter extends StatelessWidget {
  const LoadingWithCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    final commonProvider = Provider.of<CommonProvider>(context);

    return Container(
      color: Colors.white70,
      child: Center(
        child: ValueListenableBuilder<bool>(
          valueListenable: commonProvider.isOnImage,
          builder: (context, isOn, child) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: SvgPicture.asset(
                isOn
                    ? 'assets/icons/loading_character_animation_on.svg'
                    : 'assets/icons/loading_character_animation_off.svg',
                key: ValueKey<bool>(isOn),
              ),
            );
          },
        ),
      ),
    );
  }
}
