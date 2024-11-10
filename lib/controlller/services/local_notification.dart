import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class LocalNotification {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final _notificationListener = BehaviorSubject<String?>();
  static initializeNotification({bool? initialzation}) async {
    await _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (payload) async {
        _notificationListener.add(payload.payload);
      },
    );
  }

  static NotificationDetails? _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        channelDescription: 'channelDiscription',
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
      ),
    );
  }

  static showLocalNotification(
    String title,
    int id,
    String body,
    String payload,
  ) async {
    await _notification.show(
      id,
      title,
      body,
      _notificationDetails(),
    );
  }

  // static showScheduledNotification(
  //   String title,
  //   int id,
  //   String body,
  //   String payload,
  // ) async {
  //   await _notification.zonedSchedule(
  //     id,
  //     title,
  //     body,
  //     _scheduledTime(),
  //     _notificationDetails(),
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //     androidScheduleMode: AndroidScheduleMode.alarmClock,
  //     matchDateTimeComponents: DateTimeComponents.time,
  //   );
  // }
}
