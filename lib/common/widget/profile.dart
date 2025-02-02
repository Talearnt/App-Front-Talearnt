import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Profile extends StatelessWidget {
  final String nickName;

  const Profile({super.key, required this.nickName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
            child: SvgPicture.asset(
          'assets/img/profile.svg',
        )),
        const SizedBox(
          width: 10,
        ),
        Text(
          nickName,
          style: TextTypes.bodyLarge02(
            color: Palette.text02,
          ),
        )
      ],
    );
  }
}
