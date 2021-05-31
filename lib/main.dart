import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_reminder/constant/pallete.dart';
import 'package:todo_reminder/screens/sign_up.dart';
// import 'package:timezone/data/latest.dart' as tz;

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

void main() async {
  // tz.initializeTimeZones();
  //
  // var initializationSettingsAndroid = AndroidInitializationSettings('circle');
  // var initializationSettingsIOS = IOSInitializationSettings(
  //     requestAlertPermission: true,
  //     requestBadgePermission: true,
  //     requestSoundPermission: true,
  //     onDidReceiveLocalNotification:
  //         (int id, String title, String body, String payload) async {});
  // var initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: (String payload) async {
  //   if (payload != null) {
  //     debugPrint('notification payload: ' + payload);
  //   }
  // });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Pallete.mbgcolor,
      ),
      home: SignUp(),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

/// The API endpoint here accepts a raw FCM payload for demonstration purposes.
// String constructFCMPayload(String token) {
//   print("This is token");
//   print(token);
//   return jsonEncode({
//     'token': token,
//   });
// }

// Future<void> scheduleNotification(String time, String work) async {
//   if (time != null && work != null) {
//     print("this is scheduler");
//     print(work + time);
//     String remindertime = time;
//     String note = work;
//     DateTime dt = DateTime.parse(remindertime);
//     var scheduledNotificationDateTime = dt.add(Duration(seconds: 5));
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       '$note',
//       '$note',
//       'channel description',
//       icon: 'circle',
//     );
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.schedule(
//         0,
//         'Reminder for : $note',
//         'at $remindertime',
//         scheduledNotificationDateTime,
//         platformChannelSpecifics);
//   } else {
//     var scheduledNotificationDateTime =
//         DateTime.now().add(Duration(seconds: 5));
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'sada',
//       'sad',
//       'channel description',
//       icon: 'circle',
//     );
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.schedule(0, 'asda', 'sdas',
//         scheduledNotificationDateTime, platformChannelSpecifics);
//   }
// }

// void scheduleAlarm(dynamic noter, dynamic time) async {
//   // String remindertime = MySharedPreferences.instance.getStringValue("remindertime").toString();
//   // var schduleNotificationDateTime = DateTime.now().add(Duration(seconds: 10));
//   // var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//   //     "alarm_notif", "alarm_notif", "channel fr alarm",
//   //     icon: 'circle',importance: Importance.high);
//   // var platformChannelSpecifics =
//   //     NotificationDetails(android: androidPlatformChannelSpecifics);
//   //
//   String remindertime, note;
//   try {
//     print("this is note");
//     print(noter);
//
//     remindertime =
//         await MySharedPreferences.instance.getStringValue("remindertime");
//     note = await MySharedPreferences.instance.getStringValue("note");
//     var schduleNotificationDateTime = DateTime.now().add(Duration(seconds: 5));
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         "alarm_id", "$noter", "channel fr alarm",
//         icon: 'circle', importance: Importance.high);
//     var platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     // await flutterLocalNotificationsPlugin
//     //   ..zonedSchedule(
//     //       0,
//     //       'Scheduled at $remindertime',
//     //       '$note',
//     //       // DateTime.now(remindertime).add(const Duration(seconds: 5)),
//     //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//     //       const NotificationDetails(
//     //           android: AndroidNotificationDetails('your channel id',
//     //               'your channel name', 'your channel description')),
//     //       androidAllowWhileIdle: true,
//     //       uiLocalNotificationDateInterpretation:
//     //       UILocalNotificationDateInterpretation.absoluteTime);
//   } catch (e) {}
// }
