import 'package:flutter/material.dart';
import 'package:mobial/login9/ui/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High importance Notification',
  description: 'This channel is used for important notifications',
  importance: Importance.high,
  playSound: true,
);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message showe up: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyB-P6C3dgduf2tu03DsrBczK4x4990ppyk",
    appId: "1:109889701868:web:451a23ce9d1be320a862c9",
    messagingSenderId: "109889701868",
    projectId: "mobial",
  ));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoBIAL',
      theme: ThemeData(
        backgroundColor: Color(0xffd5e4e1),
        colorScheme: ColorScheme.light(),
      ),
      // home: Home(
      //   email: 'vulcan@gmail.com',
      // ),
      home: Login9(),
    );
  }
}
