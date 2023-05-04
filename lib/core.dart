import 'dart:async';
import 'dart:convert';

import 'package:dream/Database.dart';
import 'package:dream/firebase.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:localization/localization.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'main.dart';

String? name,uid,hale,jns,omer,deviceid;int? point;
Database? admin,feeddb,ahlam;
List<Map>? holm,feed;
ValueNotifier<int> abc=ValueNotifier(0),sel=ValueNotifier(0);
int bokra=0;
String contrycode="";
GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
bool privatechat=false;
String? lnn,iplng;
List<String> mfr=<String>[];
bool rmv=false,ggl=false;
StreamSubscription<DatabaseEvent>?dbvl;




class LocalNotificationService {
  // Instance of Flutternotification plugin
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();



  static void initialize() {
    // Initialization setting for android
    const InitializationSettings initializationSettingsAndroid =
    InitializationSettings(
        android: AndroidInitializationSettings("@drawable/ic_launcher_round"));
    _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {}
      },
    );
  }

  static Future<void> display(RemoteMessage message) async {
    // To display the notification in device
    try {
      print(message.notification!.android!.sound);
      final id = DateTime
          .now()
          .millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            message.notification!.android!.sound ?? "Channel Id",
            message.notification!.android!.sound ?? "Main Channel",
            groupKey: "gfg",
            importance: Importance.max,
            //sound: RawResourceAndroidNotificationSound(
            //   message.notification!.android!.sound ?? "gfg"),

            // different sound for
            // different notification
            playSound: true,enableVibration: true,
            priority: Priority.high),
      );
      await _notificationsPlugin.show(id, message.notification?.title,
          message.notification?.body, notificationDetails,
          payload: message.data['route']);




    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void messageListener(BuildContext context) {
    // Either you can pass buildcontext or you
    // can take a context from navigator key
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Message also contained a notification: so it will pop up ${message.notification?.body}');

      }
    });
  }


  static Future<void> shedul() async {

    int abc=DateTime.now().millisecondsSinceEpoch + 1000*60*60*24;
    tzData.initializeTimeZones();

    await _notificationsPlugin.zonedSchedule(12345,"لقد حصلت على رصيد مجاني".i18n(), "اضغط هنا للفتح".i18n(), tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local,abc),NotificationDetails(android:  AndroidNotificationDetails(
        "asdaw2345", // channel Id
        "asdsdsad"  // channel Name
    ),),uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,androidAllowWhileIdle: true,);


  }
/*  "data": {
    "click_action": "FLUTTER_NOTIFICATION_CLICK",
    "id": "1",
    "status": "done"
  },*/
  static Future<void> sendnotf(String title ,String body) async {
    mfr.forEach((element) async {

      await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),headers: {
        "Authorization": "key=AAAArz5mM4E:APA91bEgfmL4AXgyEcplUyoqKNwFqC3UrGmfFqd6-OzQu6U6yqUJTlAfWys9Dvc0kFPsXJFSA1OqLLRRSsPhJCpp5Xih1xuD-LYPyNZ4NHNsZKdyUxVu8bA-BwVDrrlzc_t47iBd_5OX",
        "content-type": "application/json"
      },body:json.encode( {
//"to" : "/topics/${uid}",
        "to":"$element",
        "notification": {"body": "$body", "title": "$title"},
        "priority": "high",

      }));
    });
  }
}
class ad{


// banner ca-app-pub-7794782835828190/9256694605
  static Widget banner=StatefulBuilder(builder: (BuildContext context,StateSetter bnstate){
    if(!rmv) {
      BannerAd? _bannerAd = BannerAd(
        adUnitId: "ca-app-pub-7794782835828190/9256694605",
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            try{
            WidgetsBinding.instance.addPostFrameCallback((_) {
              bnstate(() {});
            });}catch(e){}
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (ad, err) {
            // Dispose the ad here to free resources.
            ad.dispose();
          },
        ),
      )
        ..load();
      return _bannerAd != null ? SizedBox(
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      ) : Container();
    }
    else return Container();
  });


  static void loadAd() {
    if(!rmv){
    if (ggl) {
      if (interstitialAd != null) {
        try{
        interstitialAd!
          ..show();}catch(E){}
        interstitialAd=null;
      }
      InterstitialAd.load(
          adUnitId: "ca-app-pub-7794782835828190/3812796230",
          //ca-app-pub-7794782835828190/3812796230
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            // Called when an ad is successfully received.
            onAdLoaded: (ad) {
              debugPrint('$ad loaded.');
              // Keep a reference to the ad so you can show it later.
              interstitialAd = ad;
            },
            // Called when an ad request failed.
            onAdFailedToLoad: (LoadAdError error) {
              debugPrint('InterstitialAd failed to load: $error');
            },
          ));
    }
    else{
      UnityAds.load(
        placementId: 'in',
        onComplete: (placementId) =>UnityAds.showVideoAd(
          placementId: placementId,
          onStart: (placementId) => print('Video Ad $placementId started'),
          onClick: (placementId) => print('Video Ad $placementId click'),
          onSkipped: (placementId) => print('Video Ad $placementId skipped'),
          onComplete: (placementId) => print('Video Ad $placementId completed'),
          onFailed: (placementId, error, message) => print('Video Ad $placementId failed: $error $message'),
        ),
        onFailed: (placementId, error, message) => print('Load Failed $placementId: $error $message'),
      );
    }
  }
  }



}
String reward='ca-app-pub-7794782835828190/4997078837';//ca-app-pub-7794782835828190/4997078837
InterstitialAd? interstitialAd;
launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}