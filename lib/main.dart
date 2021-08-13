import 'dart:io';
import 'dart:async';
import 'package:animations/animations.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rewayat_alkateb_islam/blocs/blocObserver.dart';
import 'package:rewayat_alkateb_islam/views/screens/authScreen.dart';
import 'package:rewayat_alkateb_islam/views/screens/homepage.dart';
import 'package:rewayat_alkateb_islam/views/screens/offlinePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 40000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.dark
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = Colors.black.withOpacity(.3)
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..indicatorColor = Colors.black
    ..userInteractions = true
    ..dismissOnTap = false;
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

void initMessaging() async {
  /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel channel;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? message) {});

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ));
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
  });
      
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    FirebaseMessaging.instance.getToken().then((token) async {
      sharedPreferences.setString("token", token!);
      print(token);
    });
  
}
late bool isConnected;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 isConnected=await ConnectivityWrapper.instance.isConnected;
   
  await Firebase.initializeApp();
    MobileAds.instance.initialize();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  Bloc.observer = SimpleBlocObserver();
  configLoading();
  initMessaging();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'روايات الكاتب اسلام',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          //    fontFamily: 'Cairo',
          pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.android: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.scaled,
        )
      })),      builder: EasyLoading.init(),

      home:isConnected? auth.FirebaseAuth.instance.currentUser == null? AuthScreen():
          
           MyHomePage():OfflinePage(),
    );
  }
}
/*<meta-data android:name="com.facebook.sdk.ApplicationId" 
        android:value="548176002984639"/>
    
    <activity android:name="com.facebook.FacebookActivity"
        android:configChanges=
                "keyboard|keyboardHidden|screenLayout|screenSize|orientation"
        android:label="rwayat_alkateb_islam" />
    <activity
        android:name="com.facebook.CustomTabActivity"
        android:exported="true">
        <intent-filter>
            <action android:name="android.intent.action.VIEW" />
            <category android:name="android.intent.category.DEFAULT" />
            <category android:name="android.intent.category.BROWSABLE" />
            <data android:scheme="fb548176002984639" />
        </intent-filter>
    </activity>*/