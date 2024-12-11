import 'package:app_front_talearnt/common/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonNavigator {
  final GlobalKey<NavigatorState> navigatorKey;

  CommonNavigator(this.navigatorKey);

  BuildContext get context => navigatorKey.currentContext!;

  void showSingleDialog({
    required String content,
    Widget? button,
    bool timer = false,
    ValueNotifier<int>? timeSeconds,
  }) {
    SingleBtnDialog.show(
      context,
      content: content,
      button: button,
      timer: timer,
    );
  }

  void showDoubleDialog({
    required String content,
    required String closeText,
    required Widget button,
    bool timer = false,
    ValueNotifier<int>? timeSeconds,
  }) {
    DoubleBtnDialog.show(
      context,
      content: content,
      closeText: closeText,
      button: button,
      timer: timer,
    );
  }

  void replaceRoute(String route) => context.replace(route);

  void goRoute(String route) => context.go(route);

  void goBack() => context.pop();
}
