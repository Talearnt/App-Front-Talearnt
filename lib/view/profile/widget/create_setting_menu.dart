import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/theme.dart';

class CreateSettingMenu extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const CreateSettingMenu({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 18, 16),
        child: Row(
          children: [
            SvgPicture.asset(iconPath),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextTypes.body02(color: Palette.text02),
              ),
            ),
            SvgPicture.asset('assets/icons/chevron_right_before.svg'),
          ],
        ),
      ),
    );
  }
}
