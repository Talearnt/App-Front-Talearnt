import 'package:app_front_talearnt/data/model/param/fcm_token_parm.dart';
import 'package:app_front_talearnt/data/model/param/my_talent_keywords_param.dart';
import 'package:app_front_talearnt/data/model/param/notification_settng_param.dart';
import 'package:app_front_talearnt/data/model/param/readNotification_param.dart';
import 'package:app_front_talearnt/data/repositories/notification_repository.dart';
// removed: int_array_param import
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

  Future<void> readNotification(List<int> notificationNos) async {
    ReadnotificationParam param =
        ReadnotificationParam(notificationNos: notificationNos);
    final result = await notificationRepository.readNotification(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (data) {
      notificationProvider.markAsRead(notificationNos);
    });
  }

  Future<void> sendFcmToken(String token) async {
    FcmTokenParm param = FcmTokenParm(fcmToken: token);
    final result = await notificationRepository.sendFcmToken(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)),
        (data) {});
  }

  Future<void> deleteFcmToken(String token) async {
    FcmTokenParm param = FcmTokenParm(fcmToken: token);
    final result = await notificationRepository.deleteFcmToken(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)),
        (data) {});
  }

  Future<void> changeAllowNotification(
      bool keywordNotification, bool commentNotification) async {
    NotificationSettngParam param = NotificationSettngParam(
        allowKeywordNotifications: keywordNotification,
        allowCommentNotifications: commentNotification);
    final result = await notificationRepository.changeAllowNotification(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (data) {
      notificationProvider.changeKeywordNotification(keywordNotification);
      notificationProvider.changeCommentNotification(commentNotification);
    });
  }

  Future<void> getNotificationSetting() async {
    final result = await notificationRepository.getNotificationSetting();
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (data) {
      notificationProvider
          .changeKeywordNotification(data.data["allowKeywordNotifications"]);
      notificationProvider
          .changeCommentNotification(data.data["allowCommentNotifications"]);
    });
  }
}
