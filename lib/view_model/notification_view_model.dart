import 'package:app_front_talearnt/data/repositories/notification_repository.dart';
import 'package:flutter/material.dart';

import '../common/common_navigator.dart';
import '../utils/error_message.dart';
import '../provider/notification/notification_provider.dart';
import '../data/model/respone/notification.dart';

class NotificationViewModel extends ChangeNotifier {
  final CommonNavigator commonNavigator;
  final NotificationRepository notificationRepository;
  final NotificationProvider notificationProvider;

  NotificationViewModel(
    this.commonNavigator,
    this.notificationRepository,
    this.notificationProvider,
  );

  Future<void> getNotification() async {
    final result = await notificationRepository.getNotification();
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (data) {
      List<NotificationData> notifications = List<NotificationData>.from(
          data.map((item) => NotificationData.fromJson(item)));
      notificationProvider.setNotifications(notifications);
    });
  }
}
