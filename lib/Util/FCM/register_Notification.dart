import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class RegisterNotification {
  FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    String token = await _messaging.getToken(
      vapidKey: "AAAAQ25nlng:APA91bFZ4w-w6ZWC9awAZ_x9ISI_8KRsppn7f4H6gNX61yQp_lSvnENWq2jxiRTiqerXDf0REJZc4Amx3cm2CexwLYdpHdcYf3Su2UnbIB1Sw_-CCaWT2Ua4_2LOcjg_MWFOcU0QFVN-",
    );
    print(token);

    // 2. On iOS, this helps to take the user permissions
    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    // TODO: handle the received notifications
  }

}