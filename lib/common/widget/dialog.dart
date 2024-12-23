import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/time_set.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoubleBtnDialog extends StatelessWidget {
  final String content, leftText, rightText;
  final bool timer;
  final VoidCallback leftFun;
  final VoidCallback rightFun;
  final ValueNotifier<int>? timeSeconds;

  const DoubleBtnDialog({
    super.key,
    required this.content,
    required this.leftText,
    required this.rightText,
    required this.leftFun,
    required this.rightFun,
    this.timer = false,
    this.timeSeconds,
  });

  // showDialog를 포함하는 정적 메서드
  static void show(
    BuildContext context, {
    required String content,
    required String leftText,
    required String rightText,
    VoidCallback? leftFun,
    VoidCallback? rightFun,
    bool timer = false,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DoubleBtnDialog(
          content: content,
          leftText: leftText,
          rightText: rightText,
          leftFun: leftFun ??
              () {
                context.pop();
              },
          rightFun: rightFun ??
              () {
                context.pop();
              },
          timer: timer,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Dialog(
        backgroundColor: Palette.bgBackGround,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          height: 195,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        content,
                        style: TextTypes.bodyLarge02(
                          color: Palette.text01,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      child: timer ? TimeSet(timerSeconds: timeSeconds) : null,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SecondaryMGray(
                        content: leftText,
                        onPressed: leftFun,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: PrimaryM(
                      content: rightText,
                      onPressed: rightFun,
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleBtnDialog extends StatelessWidget {
  final String content;
  final bool timer;
  final Widget? button;
  final ValueNotifier<int>? timeSeconds;

  const SingleBtnDialog({
    super.key,
    required this.content,
    this.timer = false,
    this.button,
    this.timeSeconds,
  });

  // showDialog를 포함하는 정적 메서드
  static void show(
    BuildContext context, {
    required String content,
    Widget? button,
    bool timer = false,
    ValueNotifier<int>? timeSeconds,
  }) {
    button ??= PrimaryM(
      content: '확인',
      onPressed: () {
        context.pop();
      },
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleBtnDialog(
          content: content,
          timer: timer,
          timeSeconds: timeSeconds,
          button: button,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Dialog(
        backgroundColor: Palette.bgBackGround,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          height: 195,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        content,
                        style: TextTypes.bodyLarge02(
                          color: Palette.text01,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      child: timer
                          ? ValueListenableBuilder<int>(
                              valueListenable:
                                  timeSeconds!, // ValueNotifier를 감시
                              builder: (context, value, child) {
                                return TimeSet(timerSeconds: timeSeconds);
                              })
                          : null,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Expanded(child: button!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
