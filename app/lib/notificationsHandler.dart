import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MessagesHandler{

  static void setupMessaging(){

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.requestPermission();
    messaging.getToken().then( (token) => print('FCM Token: $token'));

    FirebaseMessaging.onMessage.listen( (RemoteMessage message) {
      print('Received message: ${message.notification!.body}');
    });

  }

}