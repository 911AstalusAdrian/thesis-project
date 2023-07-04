import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessagesHandler{

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void setupMessaging(){

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.requestPermission();
    initLocalNotifications();

    FirebaseMessaging.onMessage.listen( (RemoteMessage message) {
      String title = message.notification!.title!;
      String body = message.notification!.body!;
      _displayNotification(title, body);
      print('onMessageListen --- Received message: ${message.notification!.body}');
      print('onMessageListen --- Received message: ${message.notification!.title}');


    });
  }

  Future<void> initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher'); // Replace 'app_icon' with your app icon name

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }


  Future<void> _displayNotification(String title, String body) async {
    const AndroidNotificationDetails specifics =
    AndroidNotificationDetails(
      "channel_id",
      "channel_name",
      channelDescription: 'channel_desc',
      importance: Importance.high,
      priority: Priority.high
    );

    const NotificationDetails platformSpecifics = NotificationDetails(android: specifics);

    await flutterLocalNotificationsPlugin.show(0, title, body, platformSpecifics, payload: 'notification_payload',);
  }

}