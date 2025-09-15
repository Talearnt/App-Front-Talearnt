import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:app_front_talearnt/data/services/stomp_service.dart';

class TerminationProvider extends ChangeNotifier {
  static const _channel = EventChannel('app/termination_events');
  StreamSubscription<dynamic>? _sub;
  bool _done = false;
  String? lastEvent;

  TerminationProvider() {
    _sub = _channel.receiveBroadcastStream().listen((e) async {
      lastEvent = e?.toString();
      if (!_done && (lastEvent == 'onStop' || lastEvent == 'onDestroy')) {
        _done = true;
        try {
          await unsubscribeNotification();
        } catch (_) {}
        notifyListeners();
      }
    });
  }

  Future<void> forceUnsubscribe() async {
    if (_done) return;
    _done = true;
    try {
      await unsubscribeNotification();
    } catch (_) {}
    notifyListeners();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
