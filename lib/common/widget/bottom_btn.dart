import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';

class BottomBtn extends StatelessWidget {
  final double mediaBottom;
  final bool isEnabled;
  final String content;
  final VoidCallback? onPressed;
  final Widget? otherSetting;

  const BottomBtn({
    super.key,
    required this.mediaBottom,
    required this.content,
    this.isEnabled = false,
    this.onPressed,
    this.otherSetting,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: mediaBottom > 0 ? 0 : 24,
        right: mediaBottom > 0 ? 0 : 24,
        bottom: mediaBottom > 0 ? 0 : 12,
        top: mediaBottom > 0 ? 0 : 16,
      ),
      child: Row(
        children: [
          if (otherSetting != null) ...[
            InkWell(child: otherSetting!),
            const SizedBox(width: 12), // 간격 추가
          ],
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isEnabled ? Palette.primary01 : Palette.bgUp02,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    mediaBottom > 0 ? 0 : 12,
                  ),
                ),
                elevation: 0,
              ),
              onPressed: isEnabled ? onPressed : null,
              child: Center(
                child: Text(
                  content,
                  style: TextTypes.bodyMedium01(
                    color: isEnabled ? Palette.bgBackGround : Palette.text04,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
