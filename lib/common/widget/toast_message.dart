import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../provider/common/common_provider.dart';

class ToastMessage {
  static Widget _buildFirstToast(String message, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: Palette.bgToast01,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/finish.svg'),
          const SizedBox(
            width: 8,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextTypes.caption01(
              color: Palette.bgBackGround,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildSecondToast(String message) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: Palette.bgToast01,
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Text(
        message,
        style: TextTypes.caption01(
          color: Palette.bgBackGround,
        ),
      ),
    );
  }

  static void show({
    required BuildContext context,
    required String message,
    required int type,
    required double bottom, // 기존 하단 위치 값
  }) {
    final mediaBottom = MediaQuery.of(context).viewInsets.bottom; // 키보드 높이

    // 키보드가 올라오면 `bottom`을 키보드 높이에 맞게 조정
    final adjustedBottom = bottom + mediaBottom;

    final overlay = Overlay.of(context);

    final entry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: adjustedBottom), // 수정된 bottom 값 사용
                child: Material(
                  color: Colors.transparent,
                  child: type == 1
                      ? _buildFirstToast(message, context)
                      : _buildSecondToast(message),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 2), () {
      entry.remove();
    });
  }

  static void infinityShow(
      {required BuildContext context,
      required String message,
      required int type,
      required double bottom,
      required CommonProvider commonProvider}) {
    commonProvider.removeToast();

    final overlay = Overlay.of(context);

    final entry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottom), // 수정된 bottom 값 사용
                child: Material(
                  color: Colors.transparent,
                  child: type == 1
                      ? _buildFirstToast(message, context)
                      : _buildSecondToast(message),
                ),
              ),
            ),
          ],
        );
      },
    );
    commonProvider.updateEntry(entry);

    overlay.insert(commonProvider.currentEntry!);
  }
}
