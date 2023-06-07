import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:dream/Database.dart';
import 'package:dream/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/languages.g.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'Notifications.dart' as prefix0;
import 'package:url_launcher/url_launcher.dart';
import 'package:localization/localization.dart';
import 'Deals.dart';
import 'SecondPage.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'WishList.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:dream/core.dart' as core;
import 'package:http/http.dart' as http;
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:social_share/social_share.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

var countrylng= ['af-ZA',
  'am-ET',
  'ar-AE',
  'ar-BH',
  'ar-DZ',
  'ar-EG',
  'ar-IQ',
  'ar-JO',
  'ar-KW',
  'ar-LB',
  'ar-LY',
  'ar-MA',
  'arn-CL',
  'ar-OM',
  'ar-QA',
  'ar-SA',
  'ar-SY',
  'ar-TN',
  'ar-YE',
  'as-IN',
  'az-Cyrl-AZ',
  'az-Latn-AZ',
  'ba-RU',
  'be-BY',
  'bg-BG',
  'bn-BD',
  'bn-IN',
  'bo-CN',
  'br-FR',
  'bs-Cyrl-BA',
  'bs-Latn-BA',
  'ca-ES',
  'co-FR',
  'cs-CZ',
  'cy-GB',
  'da-DK',
  'de-AT',
  'de-CH',
  'de-DE',
  'de-LI',
  'de-LU',
  'dsb-DE',
  'dv-MV',
  'el-GR',
  'en-029',
  'en-AU',
  'en-BZ',
  'en-CA',
  'en-GB',
  'en-IE',
  'en-IN',
  'en-JM',
  'en-MY',
  'en-NZ',
  'en-PH',
  'en-SG',
  'en-TT',
  'en-US',
  'en-ZA',
  'en-ZW',
  'es-AR',
  'es-BO',
  'es-CL',
  'es-CO',
  'es-CR',
  'es-DO',
  'es-EC',
  'es-ES',
  'es-GT',
  'es-HN',
  'es-MX',
  'es-NI',
  'es-PA',
  'es-PE',
  'es-PR',
  'es-PY',
  'es-SV',
  'es-US',
  'es-UY',
  'es-VE',
  'et-EE',
  'eu-ES',
  'fa-IR',
  'fi-FI',
  'fil-PH',
  'fo-FO',
  'fr-BE',
  'fr-CA',
  'fr-CH',
  'fr-FR',
  'fr-LU',
  'fr-MC',
  'fy-NL',
  'ga-IE',
  'gd-GB',
  'gl-ES',
  'gsw-FR',
  'gu-IN',
  'ha-Latn-NG',
  'he-IL',
  'hi-IN',
  'hr-BA',
  'hr-HR',
  'hsb-DE',
  'hu-HU',
  'hy-AM',
  'id-ID',
  'ig-NG',
  'ii-CN',
  'is-IS',
  'it-CH',
  'it-IT',
  'iu-Cans-CA',
  'iu-Latn-CA',
  'ja-JP',
  'ka-GE',
  'kk-KZ',
  'kl-GL',
  'km-KH',
  'kn-IN',
  'kok-IN',
  'ko-KR',
  'ky-KG',
  'lb-LU',
  'lo-LA',
  'lt-LT',
  'lv-LV',
  'mi-NZ',
  'mk-MK',
  'ml-IN',
  'mn-MN',
  'mn-Mong-CN',
  'moh-CA',
  'mr-IN',
  'ms-BN',
  'ms-MY',
  'mt-MT',
  'nb-NO',
  'ne-NP',
  'nl-BE',
  'nl-NL',
  'nn-NO',
  'nso-ZA',
  'oc-FR',
  'or-IN',
  'pa-IN',
  'pl-PL',
  'prs-AF',
  'ps-AF',
  'pt-BR',
  'pt-PT',
  'qut-GT',
  'quz-BO',
  'quz-EC',
  'quz-PE',
  'rm-CH',
  'ro-RO',
  'ru-RU',
  'rw-RW',
  'sah-RU',
  'sa-IN',
  'se-FI',
  'se-NO',
  'se-SE',
  'si-LK',
  'sk-SK',
  'sl-SI',
  'sma-NO',
  'sma-SE',
  'smj-NO',
  'smj-SE',
  'smn-FI',
  'sms-FI',
  'sq-AL',
  'sr-Cyrl-BA',
  'sr-Cyrl-CS',
  'sr-Cyrl-ME',
  'sr-Cyrl-RS',
  'sr-Latn-BA',
  'sr-Latn-CS',
  'sr-Latn-ME',
  'sr-Latn-RS',
  'sv-FI',
  'sv-SE',
  'sw-KE',
  'syr-SY',
  'ta-IN',
  'te-IN',
  'tg-Cyrl-TJ',
  'th-TH',
  'tk-TM',
  'tn-ZA',
  'tr-TR',
  'tt-RU',
  'tzm-Latn-DZ',
  'ug-CN',
  'uk-UA',
  'ur-PK',
  'uz-Cyrl-UZ',
  'uz-Latn-UZ',
  'vi-VN',
  'wo-SN',
  'xh-ZA',
  'yo-NG',
  'zh-CN',
  'zh-HK',
  'zh-MO',
  'zh-SG',
  'zh-TW',
  'zu-ZA'];
List<Language> droplng=[
  Language.fromIsoCode("en"),
  Language.fromIsoCode("es"),
  Language.fromIsoCode("bn"),
  Language.fromIsoCode("ar"),
  Language.fromIsoCode("fr"),
  Language.fromIsoCode("id"),
  Language.fromIsoCode("ru"),
  Language.fromIsoCode("sv"),
  Language.fromIsoCode("tr"),
  Language.fromIsoCode("ur"),
  Language.fromIsoCode("fa"),
];


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  prefs=await SharedPreferences.getInstance();
   core.lnn=await prefs?.getString("language");
  try {
    core.iplng = json.decode((await http.post(Uri.parse("http://ip-api.com/json")))
        .body)['countryCode'];
    countrylng.forEach((element) {
      if(element.split("-")[1].toUpperCase()==core.iplng!.toUpperCase()){

        core.iplng=element;

      }
    });
    core.iplng=core.iplng!.split("-")[0];
  }
  catch(E){
    core.iplng=Platform.localeName.split("_")[0];
  }
  UnityAds.init(
    gameId: '5262359',
    onComplete: () => print('Initialization Complete'),
    onFailed: (error, message) => print('Initialization Failed: $error $message'),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,).whenComplete(() {

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  });
 await MobileAds.instance.initialize();
if(!droplng.contains(Language.fromIsoCode(core.iplng!)))core.iplng="en";

  LocalJsonLocalization.delegate.directories = ['assets/len'];
  runApp(Phoenix(
      child:myapp()
      ));
}
Future backgroundHandler(RemoteMessage msg) async {


}
class myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     localizationsDelegates: [
       // delegate from flutter_localization
       GlobalMaterialLocalizations.delegate,
       GlobalWidgetsLocalizations.delegate,
       GlobalCupertinoLocalizations.delegate,
       // delegate from localization package.
       LocalJsonLocalization.delegate,
     ],
     supportedLocales: [
       Locale('en', ''), // English, no country code
       Locale('es', ''), // Spanish, no country code
       Locale('bn', ''),
       Locale('ar', ''),
       Locale('fr', ''),
       Locale('id', ''),
       Locale('ru', ''),
       Locale('sv', ''),
       Locale('tr', ''),
       Locale('ur', ''),
       Locale('fa', ''),
     ],
     localeResolutionCallback: (locale, supportedLocales) {
       String finallng=core.lnn==null?core.iplng!:core.lnn!;


       switch(finallng){
         case "ar":
           return Locale("en",'arsd');
         case "ur":
           return Locale("en",'ursd');
         case "fa" :
           return Locale("en",'fasd');
         default:
           return Locale(finallng,'');
       }



     },

     navigatorKey: core.navState,
     debugShowCheckedModeBanner: false,
     home:core.lnn==null?lng(): BottomNav(),
     theme: appTheme,
     title: "مفسر الاحلام".i18n(),
   );
  }

}

class lng extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
   return Scaffold(
     body:WillPopScope(
       child:Center(
         child: Column(

           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
           children:  [
             Text(
               "اللغة".i18n(),
               style: TextStyle(
                   fontSize: 25,
                   fontWeight: FontWeight.bold),
             ),
             SizedBox(
               height: height! * 0.04,
             ),
             Container(
               width: width! * 0.45,
               child:LanguagePickerDropdown(
                 initialValue: Language.fromIsoCode(core.iplng!),
                 languages: droplng,
                 itemBuilder:(Lan){return Center(
                   child: Text(Lan.name.i18n()),
                 );},
                 onValuePicked: (Language language) {
                     core.iplng=language.isoCode.toLowerCase();
                 },
               ) ,
               decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius:
                   BorderRadius.all(Radius.circular(15),),boxShadow: [
                 BoxShadow(
                   color: Colors.purpleAccent,
                   offset: const Offset(
                     5.0,
                     5.0,
                   ),
                   blurRadius: 10.0,
                   spreadRadius: 2.0,
                 ), //BoxShadow
                 BoxShadow(
                   color: Colors.white,
                   offset: const Offset(0.0, 0.0),
                   blurRadius: 0.0,
                   spreadRadius: 0.0,
                 ), //BoxShadow
               ]),
             ),
             SizedBox(
               height: height! * 0.03,
             ),
             ElevatedButton(
                 onPressed: () async {
                  await prefs?.setString("language",core.iplng!);
                  core.lnn=core.iplng!;
                  Phoenix.rebirth(context);
                 },
                 child: Row(
                   mainAxisSize: MainAxisSize.min,
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     Icon(
                       Icons.check_circle,
                       size: 19,
                       color: Colors.purpleAccent,
                     ),
                     SizedBox(
                       width: width! * .035,
                     ),
                     Text(
                       "حفظ".i18n(),
                       style:
                       TextStyle(color: Colors.lightBlue, fontSize: 19),
                     )
                   ],
                 ),
                 style: ElevatedButton.styleFrom(
                   minimumSize: Size(110, 42),
                   // padding: EdgeInsets.symmetric(horizontal: 16),
                   backgroundColor: Colors.white,elevation: 10,shadowColor: Colors.purpleAccent
                   ,
                   shape: const RoundedRectangleBorder(
                     borderRadius: BorderRadius.all(Radius.circular(20)),
                   ),
                 ))
           ],
         ),
       )  ,
     onWillPop: ()async {
    showDialog(context: context, builder: (BuildContext context){return AlertDialog(elevation: 5,title: Text("هل تريد الخروج؟".i18n() ),actions: [
    TextButton(onPressed: () async {
    SystemNavigator.pop();

    }, child: Text("متابعة".i18n(),style: TextStyle(fontSize: 19),)),
    TextButton(onPressed: (){
    Navigator.pop(context);
    }, child: Text("الغاء".i18n(),style: TextStyle(fontSize: 19),)),
    ],);});
         return false;
         },)

   );
  }


}



FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference ref = FirebaseDatabase.instance.ref("users");

final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
ThemeData appTheme = ThemeData(
    primaryColor: Colors.purple,
    /* Colors.tealAccent,*/
    secondaryHeaderColor: Colors.blue,
    /* Colors.teal*/
    fontFamily: 'arb');


bool shw=false;
SharedPreferences? prefs ;
double? width;
double? height;
final bodies = [HomeScreen(), WishList(private: false,mofser: ""), Deals(false), prefix0.Notification()];

class BottomNav extends StatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  _BottomNavState createState() => _BottomNavState();
}
class _BottomNavState extends State<BottomNav> {
  List<BottomNavigationBarItem> createItems() {
    List<BottomNavigationBarItem> items = [];
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.home,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.home,
          color: Colors.black,
        ),
        label: "فسر حلمك".i18n()));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.chat_bubble_rounded,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.chat_bubble_rounded,
          color: Colors.black,
        ),
        label: "مقهى الانتظار".i18n()));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.shopping_bag_rounded,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.shopping_bag_rounded,
          color: Colors.black,
        ),
        label: "المتجر".i18n()));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.supervisor_account_rounded,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.supervisor_account_rounded,
          color: Colors.black,
        ),
        label: "حساب المفسر".i18n()));
    return items;

  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;
    return WillPopScope(child:  ValueListenableBuilder(valueListenable: core.sel,builder:(BuildContext context,intr ,child){
      return SideMenu(child: Scaffold(
          body: bodies.elementAt( core.sel.value),
          bottomNavigationBar:BottomNavigationBar(
            items: createItems(),
            unselectedItemColor: Colors.black,
            selectedItemColor: appTheme.primaryColor,
            type: BottomNavigationBarType.shifting,
            showUnselectedLabels: false,
            showSelectedLabels: true,
            currentIndex:  core.sel.value,
            elevation: 1.5,
            onTap: (int index) {
              if (index !=  core.sel.value)
                setState(() {
                  core.sel.value = index;
                });
              try{
                if(!shw)core.ad.loadAd();
                shw=!shw;

              }catch(e){}

            },
          )),  key: _sideMenuKey,
        menu: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: width!*0.13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Padding(padding:EdgeInsets.only(left: width!*0.07),child: Column(children: [
                    CircleAvatar(backgroundImage: AssetImage("assets/images/user.png"),maxRadius: 45,backgroundColor: Colors.white,),
                    SizedBox(height: height!*0.02,),
                    Text(core.name==null?"":core.name!,style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center),

                  ]),),
                  SizedBox(height:height!*0.04),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Profile()));
                    },
                    leading: const Icon(Icons.person, size: 25.0, color: Colors.white),
                    title:  Text("الملف الشخصي".i18n(),style: TextStyle(fontSize: 18),),
                    textColor: Colors.white,
                    dense: true,
                  ),
                  SizedBox(height:height!*0.01),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>ahlm_feed(lst: 0)));

                    },
                    leading: const Icon(Icons.list_alt_rounded, size: 25.0, color: Colors.white),
                    title:  Text("الاحلام المفسرة".i18n(),style: TextStyle(fontSize: 18),),
                    textColor: Colors.white,
                    dense: true,
                  ),
                  SizedBox(height:height!*0.01),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>ahlm_feed(lst: 1)));

                    },
                    leading: const Icon(Icons.list_alt_rounded, size: 25.0, color: Colors.white),
                    title:  Text("الملاحظات".i18n(),style: TextStyle(fontSize: 18),),
                    textColor: Colors.white,
                    dense: true,
                  ),
                  SizedBox(height:height!*0.01),
                  ListTile(
                    onTap: () {
                      showDialog(context: context, builder: (BuildContext context){

                        return AlertDialog(elevation: 5,title: Text("احصل على نقاط رصيد".i18n() ),content:StatefulBuilder(builder: (BuildContext context , StateSetter sa){
                          StreamController<int> controller = StreamController<int>();
                          int b=0;
                          bool sh=false;
                          return Container(
                              height: height!*0.5,
                              width: width!,
                              child:Column(mainAxisSize: MainAxisSize.min,children: [Container(height:height!*0.3,child:FortuneWheel(
                                selected: controller.stream,onAnimationEnd: () async {

                                if(b>0){

                                  int b2=0;
                                  switch(b){
                                    case 1:
                                      b2=18;
                                      break;
                                    case 3:
                                      b2=5;
                                      break;
                                    case 6:
                                      b2=100;
                                      break;
                                    case 7:
                                      b2=7;
                                      break;
                                    case 8:
                                      b2=23;
                                      break;
                                    case 10:
                                      b2=1000;
                                      break;
                                  }
                                  b=0;
                                  Navigator.of(context).pop();
                                  showDialog(context: context, builder: (_)=>Material(child: Center(child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.purpleAccent,
                                            offset: const Offset(
                                              5.0,
                                              5.0,
                                            ),
                                            blurRadius: 10.0,
                                            spreadRadius: 2.0,
                                          ), //BoxShadow
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: const Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            spreadRadius: 0.0,
                                          ), //BoxShadow
                                        ]),
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("لقد حصلت على".i18n()+b2.toString()+"نقاط".i18n(),style: TextStyle(fontSize: 31),),
                                        SizedBox(height: 15,),
                                        Row(mainAxisAlignment:
                                        MainAxisAlignment.center,
                                          children: [




                                            TextButton(onPressed: (){
                                              Navigator.of(core.navState.currentContext!).pop();
                                            }, child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.check,
                                                  size: 30,
                                                  color: Colors.purpleAccent,
                                                ),
                                                SizedBox(
                                                  width:10,
                                                ),
                                                Text(
                                                  "حسنا".i18n(),
                                                  style: TextStyle(
                                                      color: Colors.lightBlue, fontSize: 26),
                                                )
                                              ],
                                            ),),
                                          ],
                                        ),
                                        SizedBox(height:5,),
                                      ],
                                    ),

                                  ),),type: MaterialType.transparency,));
                                  //  showToast("لقد حصلت على".i18n()+b2.toString()+"نقاط".i18n(),context: context,animation:StyledToastAnimation.scale,borderRadius: BorderRadius.all(Radius.circular(20)));

                                  final snapshot = await ref.child('${core.uid}/point').get();
                                  if (snapshot.exists) {
                                    await ref.child('${core.uid}').update({
                                      "point":((snapshot.value) as int) +b2

                                    });
                                    core.point=((snapshot.value) as int) +b2;

                                    firebase().updatedblocally();
                                    core.abc.value+=1;
                                  }
                                }
                                else{b=-1;}
                              },
                                physics: CircularPanPhysics(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.decelerate,
                                ),
                                onFling: () {


                                },
                                items: [
                                  FortuneItem(child: Text('  1')),
                                  FortuneItem(child: Text('  18')),
                                  FortuneItem(child: Text('  50')),
                                  FortuneItem(child: Text('  5')),
                                  FortuneItem(child: Text('  300')),
                                  FortuneItem(child: Text('  3')),
                                  FortuneItem(child: Text('  100')),
                                  FortuneItem(child: Text('  7')),
                                  FortuneItem(child: Text('  23')),
                                  FortuneItem(child: Text('  85')),
                                  FortuneItem(child: Text('  1000')),
                                ],
                              ),),

                                SizedBox(height:height!*0.01),

                                TextButton(onPressed: () async {
                                  if(b==-1) {
                                    loading(context);
                                    sa(() async {
                                      int nb = Random().nextInt(180);

                                      if (nb == 1)
                                        b = 10;
                                      else if (nb > 10 && nb < 14)
                                        b = 1;
                                      else if (nb > 14 && nb < 50)
                                        b = 8;
                                      else if (nb > 50 && nb < 80)
                                        b = 7;
                                      else if (nb > 80 && nb < 81)
                                        b = 6;
                                      else
                                        b = 3;

                                      if (await firebase().checkbalance() >= 5) {
                                        Navigator.of(context).pop();
                                        final snapshot = await ref.child(
                                            '${core.uid}/point').get();
                                        if (snapshot.exists) {
                                          await ref.child('${core.uid}').update({
                                            "point": ((snapshot.value) as int) - 5
                                          });
                                          core.point =
                                              ((snapshot.value) as int) - 5;
                                          controller.add(b);
                                        }
                                      }
                                      else {
                                        Navigator.of(context).pop();
                                        showDialog(context: context,
                                            builder: (BuildContext context) {
                                              return Center(child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(30)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors
                                                            .purpleAccent,
                                                        offset: const Offset(
                                                          5.0,
                                                          5.0,
                                                        ),
                                                        blurRadius: 10.0,
                                                        spreadRadius: 2.0,
                                                      ), //BoxShadow
                                                      BoxShadow(
                                                        color: Colors.white,
                                                        offset: const Offset(
                                                            0.0, 0.0),
                                                        blurRadius: 0.0,
                                                        spreadRadius: 0.0,
                                                      ), //BoxShadow
                                                    ]),
                                                padding: EdgeInsets.only(top: 40,
                                                    bottom: 40,
                                                    right: 20,
                                                    left: 20),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text("للاسف ليس لديك رصيد كاف"
                                                        .i18n(), style: TextStyle(
                                                        fontSize: 29),
                                                        textAlign: TextAlign
                                                            .center),
                                                    SizedBox(height: 15,),
                                                    Text(
                                                        "انت بحاجة الى 5 نقاط للمتابعة"
                                                            .i18n(),
                                                        style: TextStyle(
                                                            fontSize: 25),
                                                        textAlign: TextAlign
                                                            .center),
                                                    SizedBox(height: 30,),
                                                    Row(mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context);
                                                            core.sel.value = 2;
                                                          }, child: Row(
                                                          mainAxisSize: MainAxisSize
                                                              .min,
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceBetween,
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons.check,
                                                              size: 30,
                                                              color: Colors
                                                                  .purpleAccent,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "موافق".i18n(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .lightBlue,
                                                                  fontSize: 26),
                                                            )
                                                          ],
                                                        ),),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5,),
                                                  ],
                                                ),

                                              ),);
                                            });
                                      }
                                    });
                                  }

                                }, child: Text("تدوير ب 5 نقاط".i18n(),style: TextStyle(fontSize: 19),)),
                                SizedBox(height:height!*0.01),
                                TextButton(onPressed: (){
                                  if(b==-1) {
                                    loading(context);
                                    sa(()  {
                                      int nb = Random().nextInt(180);

                                      if (nb == 1)
                                        b = 10;
                                      else if (nb > 10 && nb < 14)
                                        b = 1;
                                      else if (nb > 14 && nb < 50)
                                        b = 8;
                                      else if (nb > 50 && nb < 80)
                                        b = 7;
                                      else if (nb > 80 && nb < 81)
                                        b = 6;
                                      else
                                        b = 3;
                                    if(core.ggl) {
                                      RewardedInterstitialAd.load(
                                        adUnitId: core.reward,
                                        request: const AdRequest(),
                                        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
                                          // Called when an ad is successfully received.
                                          onAdLoaded: (ad) {
                                            debugPrint('$ad loaded.');
                                            // Keep a reference to the ad so you can show it later.

                                            ad.show(onUserEarnedReward: (
                                                AdWithoutView ad,
                                                RewardItem rewardItem) {
                                              Navigator.of(context).pop();
                                              controller.add(b);
                                            });
                                          },
                                          // Called when an ad request failed.
                                          onAdFailedToLoad: (
                                              LoadAdError error) {
                                            debugPrint(
                                                'RewardedInterstitialAd failed to load: $error');
                                          },
                                        ),);
                                    }
                                    else{
                                      UnityAds.load(
                                        placementId: 're',
                                        onComplete: (placementId) {
                                          Navigator.of(context).pop();
                                          UnityAds.showVideoAd(
                                          placementId: placementId,
                                          onStart: (placementId) => print('Video Ad $placementId started'),
                                          onClick: (placementId) => print('Video Ad $placementId click'),
                                          onSkipped: (placementId) => print('Video Ad $placementId skipped'),
                                          onComplete: (placementId){
                                            controller.add(b);
                                          },
                                          onFailed: (placementId, error, message) => print('Video Ad $placementId failed: $error $message'),
                                        );},
                                        onFailed: (placementId, error, message) =>  Navigator.of(context).pop(),
                                      );
                                    }


                                    });
                                  }
                                }, child: Text("مشاهدة اعلان للتدوير".i18n(),style: TextStyle(fontSize: 19),))

                                ,],)

                          );

                        },)
                        );});
                    },
                    leading: const Icon(Icons.sports_soccer_outlined, size: 25.0, color: Colors.white),
                    title:  Text("عجلة الحظ".i18n(),style: TextStyle(fontSize: 18),),
                    textColor: Colors.white,
                    dense: true,
                  ), SizedBox(height:height!*0.01),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Deals(true)));
                    },
                    leading: const Icon(Icons.ads_click_rounded, size: 25.0, color: Colors.white),
                    title:  Text("ازالة الاعلانات".i18n(),style: TextStyle(fontSize: 18),),
                    textColor: Colors.white,
                    dense: true,
                  ), SizedBox(height:height!*0.01),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.account_circle_rounded, size: 25.0, color: Colors.white),
                    title:  Text("الحساب (قريبا)".i18n(),style: TextStyle(fontSize: 18),),
                    textColor: Colors.white,
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(context: context, builder:(BuildContext context){
                        return Scaffold(
                            body:WillPopScope(
                              child:Center(
                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text(
                                      'اللغة'.i18n(),
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: height! * 0.04,
                                    ),
                                    Container(
                                      width: width! * 0.45,
                                      child:LanguagePickerDropdown(
                                        initialValue: Language.fromIsoCode(core.lnn!),
                                        languages: droplng,
                                        itemBuilder:(Lan){return Center(
                                          child: Text(Lan.name.i18n()),
                                        );},
                                        onValuePicked: (Language language) {
                                          core.iplng=language.isoCode.toLowerCase();
                                        },
                                      ) ,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(15),),boxShadow: [
                                        BoxShadow(
                                          color: Colors.purpleAccent,
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: const Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        ), //BoxShadow
                                      ]),
                                    ),
                                    SizedBox(
                                      height: height! * 0.03,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          await prefs?.setString("language",core.iplng!);
                                          core.lnn=core.iplng!;
                                          Phoenix.rebirth(context);
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(
                                              Icons.check_circle,
                                              size: 19,
                                              color: Colors.purpleAccent,
                                            ),
                                            SizedBox(
                                              width: width! * .035,
                                            ),
                                            Text(
                                              "حفظ".i18n(),
                                              style:
                                              TextStyle(color: Colors.lightBlue, fontSize: 19),
                                            )
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(110, 42),
                                          // padding: EdgeInsets.symmetric(horizontal: 16),
                                          backgroundColor: Colors.white,elevation: 10,shadowColor: Colors.purpleAccent
                                          ,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                          ),
                                        ))
                                  ],
                                ),
                              )  ,
                              onWillPop: ()async {

                                return true;
                              },)

                        );

                      });
                    },
                    leading: const Icon(Icons.language_rounded, size: 25.0, color: Colors.white),
                    title:  Text("اللغة".i18n(),style: TextStyle(fontSize: 18),),
                    textColor: Colors.white,
                    dense: true,
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(padding: EdgeInsets.only(left: width!*0.25),child:Text("Powred by SpiderMBZ \n Ver 6.7.7",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),)
            ,SizedBox(height: height!*0.04,)
          ],
        ),
        type: SideMenuType.slideNRotate,inverse: true, );

    }),
        onWillPop: ()async {
          showDialog(context: context, builder: (BuildContext context){return AlertDialog(elevation: 5,title: Text("هل تريد الخروج؟".i18n() ),actions: [
            TextButton(onPressed: () async {
              SystemNavigator.pop();

            }, child: Text("متابعة".i18n(),style: TextStyle(fontSize: 19),)),
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("الغاء".i18n(),style: TextStyle(fontSize: 19),)),
          ],);});

          return false;
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  Future<void> ini() async {

   try{
     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
     FlutterLocalNotificationsPlugin();
     flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
         AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
   }catch(E){}
    Directory d =
    await Directory('/data/user/0/com.spidermbz.dream/DreamVoice');



    if (!await d.exists()) await d.create(recursive: false);

    // print(firebase().authinit(context));
    try {
      core.deviceid = await UniqueIdentifier.serial;
    } on PlatformException {
      print('Failed to get Unique Identifier');
    }
    core.contrycode=json.decode((await  http.post(Uri.parse("http://ip-api.com/json"))).body)['countryCode'];
    if(await firebase().authinit(context)==false)loginui(context);
    else{


      loading(context);
      await DBProvider().checkdb();

      await FirebaseMessaging.instance.subscribeToTopic(core.uid!);
      if(core.ggl) core.ad.loadAd();
      setState(() {



      });
      Navigator.pop(context);
      await firebase().getdatabasesinit(context);
      prefs = await SharedPreferences.getInstance();
      try{
        if(await prefs?.getBool("rmv")!=null){
          core.rmv=(await prefs?.getBool("rmv"))!;
        }
      }catch(e){}
      if(await prefs?.getInt("bokra")!=null&&DateTime.now().millisecondsSinceEpoch<(await prefs?.getInt("bokra"))!){
        core.bokra=(await prefs?.getInt("bokra"))!;
        setState(() {
          core.abc.value++;
        });
      }
      else{
        core.bokra=DateTime.now().millisecondsSinceEpoch+1000*60*60*24;
        await prefs?.setInt("bokra",DateTime.now().millisecondsSinceEpoch+1000*60*60*24 );
        await firebase().free();
        showToast("لقد حصلت على 5 نقاط".i18n(),context: context,animation:StyledToastAnimation.scale,borderRadius: BorderRadius.all(Radius.circular(20)));
        setState(() {

          core.abc.value++;

        });
      }


      if(core.jns==null||(core.jns!=null&&core.jns!.length<1)){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Profile()),
            ModalRoute.withName('/')
        );
      }
      else{


        check3();
      }
    }


  }
  void check3()async{
    final sp1= await ref.child("a@dmin").get();

    int ver =sp1.child("ver").value as int;
    int localver = int.parse((await PackageInfo.fromPlatform()).buildNumber);
    List<String> blocked =<String>[];
    String cause="";
    sp1.child("zz").children.forEach((elem){
      blocked.add(elem.key.toString());

    });
    if(localver<ver){
      showDialog(context: context, builder: (BuildContext context){return WillPopScope(child: AlertDialog(elevation: 5,title: Text("هناك تحديث جديد".i18n() ),actions: [
        TextButton(onPressed: () async {
          Navigator.pop(context);
          core.launchUrl("market://details?id=com.spidermbz.dream");

        }, child: Text("متابعة".i18n(),style: TextStyle(fontSize: 19),)),

      ],), onWillPop: ()async=>true);});
    }
    if(blocked.isNotEmpty&&blocked.contains(core.deviceid)) {
      cause=sp1.child("zz/${core.deviceid}").value as String;
      showDialog(context: context, builder: (BuildContext context){return WillPopScope(child: AlertDialog(elevation: 5,title: Text(cause ),actions: [
        TextButton(onPressed: () async {
          SystemNavigator.pop();

        }, child: Text("متابعة".i18n(),style: TextStyle(fontSize: 19),)),

      ],), onWillPop: ()async=>false);});

    }
    if((await prefs?.getInt("rate"))!=null&&(await prefs?.getInt("rate"))!<6){
      await prefs?.setInt("rate",(await prefs?.getInt("rate"))!+1);
    }
    else{
      if((await prefs?.getInt("rate"))==null)await prefs?.setInt("rate",1);
      if((await prefs?.getInt("rate"))!=null&&(await prefs?.getInt("rate"))==6){


        showDialog(context: context, builder: (BuildContext context){return WillPopScope(child: AlertDialog(elevation: 5,title: Text("هل يمكنك تقييمنا ؟".i18n() ),actions: [
          TextButton(onPressed: () async {
            await prefs?.setInt("rate",(await prefs?.getInt("rate"))!+1);
            Navigator.pop(context);
            core.launchUrl("market://details?id=com.spidermbz.dream");

          }, child: Text("متابعة".i18n(),style: TextStyle(fontSize: 19),)),

        ],), onWillPop: ()async=>true);});

      }
    }



  }

  void loginui(BuildContext context){showDialog(
      context: context,barrierDismissible: false,
      builder: (BuildContext contexts) {
        return  Material(child: WillPopScope(
            child: Container(
              height: height!,
              width: width!,
              padding: EdgeInsets.only(
                  top: height! * 0.25,
                  bottom: height! * 0.25,
                  left: width! * 0.07,
                  right: width! * 0.07),
              color: Colors.black12,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purpleAccent,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ]),
                padding: EdgeInsets.all(height! * 0.02),
                child: Column(children: [
                  Text(
                    "عليك تسجيل الدخول".i18n(),
                    style: TextStyle(fontSize: 27),
                  ),
                  SizedBox(height: height!*0.0425,),

                  ElevatedButton(
                      onPressed: () async {
                        // FirebaseAuth.instance.signOut();
                        // print(FirebaseAuth.instance.currentUser!.uid);
                        //firebase().authinit(context);
                        //firebase().googlesignin(context);
                        ;

                        loading(context);
                        if( await firebase().guestsignin(context)!=null){
                          Navigator.pop(context);
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            loading(context);
                            ini();
                          });
                        }
                        else
                          Navigator.pop(context);
                        //firebase().guesttogoogle(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.coffee_rounded,
                            size: 30,
                            color: Colors.purpleAccent,
                          ),
                          SizedBox(
                            width: width! * .035,
                          ),
                          Text(
                            "ضيف".i18n(),
                            style: TextStyle(
                                color: Colors.lightBlue, fontSize: 26),
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(120, 52),elevation:5 ,shadowColor: Colors.purpleAccent,
                        // padding: EdgeInsets.symmetric(horizontal: 16),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      )),

                  SizedBox(height: height!*0.0225,),
                  Text(
                    "او".i18n(),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: height!*0.0225,),
                  ElevatedButton(
                      onPressed: () async {
                        // FirebaseAuth.instance.signOut();
                        // print(FirebaseAuth.instance.currentUser!.uid);
                        //firebase().authinit(context);
                        loading(context);
                        if( await firebase().googlesignin(context)!=null){
                          Navigator.pop(context);
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            loading(context);
                            ini();
                          });
                        }
                        else
                          Navigator.pop(context);
                        //firebase().guestsignin(context);
                        //firebase().guesttogoogle(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.gpp_good_sharp,
                            size: 30,
                            color: Colors.purpleAccent,
                          ),
                          SizedBox(
                            width: width! * .035,
                          ),
                          Text(
                            "جوجل".i18n(),
                            style: TextStyle(
                                color: Colors.lightBlue, fontSize: 26),
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(120, 52),elevation:5 ,shadowColor: Colors.purpleAccent,
                        // padding: EdgeInsets.symmetric(horizontal: 16),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      )),
                  SizedBox(height: height!*0.0325,),

                  Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                          text: "عبر تسجيل الدخول فانت توافق على ".i18n(),style: TextStyle(fontSize: 17,),
                          children: [
                            TextSpan(
                              text: "سياسة  الخصوصية".i18n(),style: TextStyle(fontSize: 17,color:Colors.lightBlue),recognizer: TapGestureRecognizer()..onTap = () => core.launchUrl("https://spidermbz.blogspot.com/2021/06/privacy-policy-for-www.html"),),

                            TextSpan(
                              text: " و ".i18n(),style: TextStyle(fontSize: 17,), ),

                            TextSpan(
                              text: "شروط الاستخدام".i18n(),style: TextStyle(fontSize: 17,color:Colors.lightBlue),recognizer: TapGestureRecognizer()..onTap = () => core.launchUrl("https://spidermbz.blogspot.com/2022/02/blog-post.html"), ),


                          ]
                      )
                  ),
                ]),
              ),
            ),
            onWillPop: () async => false),type: MaterialType.transparency,);
      });}
  void loading(BuildContext context){showDialog(
      context: context,barrierDismissible: false,
      builder: (BuildContext contexts) {
        return  Material(child: WillPopScope(
            child: Container(
              height: height!,
              width: width!,
              padding: EdgeInsets.only(
                  top: height! * 0.35,
                  bottom: height! * 0.35,
                  left: width! * 0.30,
                  right: width! * 0.30),
              color: Colors.black12,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purpleAccent,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ]),
                padding: EdgeInsets.all(height! * 0.02),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                    children: [


                      CircularProgressIndicator(color: Colors.purpleAccent,),
                      SizedBox(height: height!*0.0425,),

                      Text(
                        "جار التحميل".i18n(),
                        style: TextStyle(fontSize: 19,),textAlign: TextAlign.center,
                      ),
                    ]),
              ),
            ),
            onWillPop: () async => false),type: MaterialType.transparency,);
      });}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    core.LocalNotificationService.initialize();
    // To initialise the sg
    FirebaseMessaging.instance.getInitialMessage().then((message) {

    });

    // To initialise when app is not terminated
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        core.LocalNotificationService.display(message);
      }
    });

    // To handle when app is open in
    // user divide and heshe is using it
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("on message opened app");
    });


    WidgetsBinding.instance.addPostFrameCallback((_) {
      loading(context);
      ini();
    });

  }
}





class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);
  bool close=false;
  _profile createState() => _profile();
}
class _profile extends State<Profile> {
  int _currentValue = 18;
  TextEditingController name=TextEditingController();


  @override
  void initState() {
    super.initState();

    if(core.name!=null&&core.name!.length>0)name.text=core.name!;
    if(core.omer!=null&&core.omer!.length>0)_currentValue=int.parse(core.omer.toString()!);
    if(core.hale!=null&&core.hale!.length>0)selectalaka=core.hale!;
    if(core.jns!=null&&core.hale!.length>0) {

      selectednaw3 = core.jns!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  WillPopScope(child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            ClipPath(
              clipper: Clipper08(),
              child: Container(
                // height: height! * .65 < 450 ? height! * .65 : 500, //400
                //color: Colors.tealAccent,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      appTheme.primaryColor,
                      appTheme.secondaryHeaderColor
                    ])),
                child:Column(
                  children: [  Padding(
                    padding: EdgeInsets.only(top: 50, right: 13, left: 13),
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("الملف الشخصي".i18n(),style: TextStyle(color: Colors.white,fontSize: 26),)]),
                  ),

                    SizedBox(height: height! * 0.0675),
                  ],
                ),
              ),
            ),
            //SizedBox(height: height!*0.0325,),
            Text("الاسم".i18n(),style: TextStyle(fontSize: 20),),
            SizedBox(height: height!*0.0225,),
            Container(
              padding: EdgeInsets.only(left: 10,right: 10,),
              child: TextFormField(controller:name ,maxLines: 1,maxLength: 20,inputFormatters: [

                FilteringTextInputFormatter.deny(
                    RegExp(r'\s')),
              ],
                  decoration: InputDecoration(counterText: '',border:InputBorder.none,prefixIcon:Icon(Icons.accessibility,color: Colors.purpleAccent),hintText: "اكتب اسمك هنا...".i18n())),width: width!*0.75,decoration: BoxDecoration( boxShadow: [
              BoxShadow(
                color: Colors.purpleAccent,
                offset: const Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],borderRadius: BorderRadius.all(Radius.circular(20))),),
            SizedBox(height: height!*0.0325,),

            Text("العمر".i18n(),style: TextStyle(fontSize: 20),),
            SizedBox(height: height!*0.0225,),
            Container(
              padding: EdgeInsets.only(left: 10,right: 10,),
              child: NumberPicker(
                value: _currentValue,
                minValue: 13,
                maxValue: 150,
                onChanged: (value) => setState(() => _currentValue = value),
              ),
              width: width!*0.75,decoration: BoxDecoration( boxShadow: [
              BoxShadow(
                color: Colors.purpleAccent,
                offset: const Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],borderRadius: BorderRadius.all(Radius.circular(20))),),
            SizedBox(height: height!*0.0325,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(children: [
                  Text(
                    ('الحالة الاجتماعية').i18n(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height! * 0.01,
                  ),
                  Container(
                    width: width! * 0.4,
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: true,
                      value: selectalaka,
                      hint: Text(
                        'الحالة الاجتماعية'.i18n(),
                        style: TextStyle(
                            fontSize: 14, color: Colors.lightBlue),
                      ),
                      items: alaka
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item.i18n(),
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.lightBlue),
                        ),
                      ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          selectalaka = value.toString();
                        });
                      },
                      onSaved: (value) {},
                      buttonStyleData: const ButtonStyleData(
                        height: 60,
                        padding: EdgeInsets.only(left: 20, right: 10),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.lightBlue,
                        ),
                        iconSize: 30,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.all(Radius.circular(15),),boxShadow: [
                      BoxShadow(
                        color: Colors.purpleAccent,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ]),
                  ),
                ]),
                SizedBox(
                  width: width! * 0.04,
                ),
                Column(
                  children: [
                    Text(
                      'الجنس'.i18n(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height! * 0.01,
                    ),
                    Container(
                      width: width! * 0.4,
                      child: DropdownButtonFormField2(
                        decoration: InputDecoration(
                          //Add isDense true and zero Padding.
                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          //Add more decoration as you want here
                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                        ),
                        isExpanded: true,
                        value: selectednaw3,
                        hint: Text(
                          'الجنس'.i18n(),
                          style: TextStyle(
                              fontSize: 14, color: Colors.lightBlue),
                        ),
                        items: nw3
                            .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item.i18n(),
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.lightBlue),
                          ),
                        ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select gender.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          //Do something when changing the item if you want.
                          setState(() {
                            selectednaw3 = value.toString();
                          });
                        },
                        onSaved: (value) {},
                        buttonStyleData: const ButtonStyleData(
                          height: 60,
                          padding:
                          EdgeInsets.only(left: 20, right: 10),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.lightBlue,
                          ),
                          iconSize: 30,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(15)),boxShadow: [
                        BoxShadow(
                          color: Colors.purpleAccent,
                          offset: const Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ]),
                    )
                  ],
                )
              ],
            ),

            SizedBox(height: height!*0.0625,),
            ElevatedButton(
                onPressed: () async {
                  if(name.text.isNotEmpty) {
                    loading(context);
                    core.name = name.text.replaceAll("/", "");
                    core.jns = selectednaw3;
                    core.hale = selectalaka;
                    core.omer = _currentValue.toString();
                    await DBProvider().updateadmindb(
                        1,
                        core.point.toString(),
                        selectalaka,
                        _currentValue.toString(),
                        selectednaw3,
                        "",
                        "",
                        "",
                        name.text.toString());
                    await firebase().updatedb();
                    Navigator.pop(context);
                    Navigator.pop(context);

                    await DBProvider().getdb(0);
                  }else{
                    showToast("تاكد من ملئ الاسم".i18n(),context: context,animation:StyledToastAnimation.scale,borderRadius: BorderRadius.all(Radius.circular(20)));
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.check_circle,
                      size: 25,
                      color: Colors.purpleAccent,
                    ),
                    SizedBox(
                      width: width! * .045,
                    ),
                    Text(
                      "حفظ".i18n(),
                      style:
                      TextStyle(color: Colors.lightBlue, fontSize: 24),
                    )
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(130, 52),
                  // padding: EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: Colors.white,elevation: 10,shadowColor: Colors.purpleAccent
                  ,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                )),
            SizedBox(height: height!*0.02,),
            core.ad.banner,
          ],)

      ),onWillPop: ()async => core.jns!=null,),
    );
  }
  final List<String> alaka = [
    "لاتوجد علاقة", "متزوج/ة", "مطلق/ة", "ارمل/ة", "توجد علاقة"
  ],
      nw3 = ['ذكر', 'انثى'];

  String? selectalaka = 'لاتوجد علاقة', selectednaw3 = 'ذكر';

  void loginui(BuildContext context){showDialog(
      context: context,barrierDismissible: false,
      builder: (BuildContext contexts) {
        return  Material(child: WillPopScope(
            child: Container(
              height: height!,
              width: width!,
              padding: EdgeInsets.only(
                  top: height! * 0.25,
                  bottom: height! * 0.25,
                  left: width! * 0.07,
                  right: width! * 0.07),
              color: Colors.black12,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purpleAccent,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ]),
                padding: EdgeInsets.all(height! * 0.02),
                child: Column(children: [
                  Text(
                    "عليك تسجيل الدخول".i18n(),
                    style: TextStyle(fontSize: 27),
                  ),
                  SizedBox(height: height!*0.0425,),

                  ElevatedButton(
                      onPressed: () async {
                        // FirebaseAuth.instance.signOut();
                        // print(FirebaseAuth.instance.currentUser!.uid);
                        //firebase().authinit(context);
                        //firebase().googlesignin(context);
                        firebase().guestsignin(context);
                        //firebase().guesttogoogle(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.coffee_rounded,
                            size: 30,
                            color: Colors.purpleAccent,
                          ),
                          SizedBox(
                            width: width! * .035,
                          ),
                          Text(
                            "ضيف".i18n(),
                            style: TextStyle(
                                color: Colors.lightBlue, fontSize: 26),
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(120, 52),elevation:5 ,shadowColor: Colors.purpleAccent,
                        // padding: EdgeInsets.symmetric(horizontal: 16),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      )),

                  SizedBox(height: height!*0.0225,),
                  Text(
                    "او".i18n(),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: height!*0.0225,),
                  ElevatedButton(
                      onPressed: () async {
                        // FirebaseAuth.instance.signOut();
                        // print(FirebaseAuth.instance.currentUser!.uid);
                        //firebase().authinit(context);
                        loading(context);
                        if( await firebase().googlesignin(context)!=null){
                        }
                        Navigator.pop(context);
                        //firebase().guestsignin(context);
                        //firebase().guesttogoogle(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.gpp_good_sharp,
                            size: 30,
                            color: Colors.purpleAccent,
                          ),
                          SizedBox(
                            width: width! * .035,
                          ),
                          Text(
                            "جوجل".i18n(),
                            style: TextStyle(
                                color: Colors.lightBlue, fontSize: 26),
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(120, 52),elevation:5 ,shadowColor: Colors.purpleAccent,
                        // padding: EdgeInsets.symmetric(horizontal: 16),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      )),
                  SizedBox(height: height!*0.0325,),

                  Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                          text: "عبر تسجيل الدخول فانت توافق على ".i18n(),style: TextStyle(fontSize: 17,),
                          children: [
                            TextSpan(
                              text: "سياسة  الخصوصية".i18n(),style: TextStyle(fontSize: 17,color:Colors.lightBlue),recognizer: TapGestureRecognizer()..onTap = () => core.launchUrl("https://spidermbz.blogspot.com/2021/06/privacy-policy-for-www.html"),),

                            TextSpan(
                              text: " و ".i18n(),style: TextStyle(fontSize: 17,), ),

                            TextSpan(
                              text: "شروط الاستخدام".i18n(),style: TextStyle(fontSize: 17,color:Colors.lightBlue),recognizer: TapGestureRecognizer()..onTap = () => core.launchUrl("https://spidermbz.blogspot.com/2022/02/blog-post.html"), ),


                          ]
                      )
                  ),
                ]),
              ),
            ),
            onWillPop: () async => false),type: MaterialType.transparency,);
      });}
  void loading(BuildContext context){showDialog(
      context: context,barrierDismissible: false,
      builder: (BuildContext contexts) {
        return  Material(child: WillPopScope(
            child: Container(
              height: height!,
              width: width!,
              padding: EdgeInsets.only(
                  top: height! * 0.35,
                  bottom: height! * 0.35,
                  left: width! * 0.30,
                  right: width! * 0.30),
              color: Colors.black12,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purpleAccent,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ]),
                padding: EdgeInsets.all(height! * 0.02),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                    children: [


                      CircularProgressIndicator(color: Colors.purpleAccent,),
                      SizedBox(height: height!*0.0425,),

                      Text(
                        "جار التحميل".i18n(),
                        style: TextStyle(fontSize: 19,),textAlign: TextAlign.center,
                      ),
                    ]),
              ),
            ),
            onWillPop: () async => false),type: MaterialType.transparency,);
      });}

}



class HomeScreen extends StatefulWidget{
  homeScreen createState() => homeScreen();
}
class homeScreen extends State<HomeScreen> {


  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');
    final buffer = byteData.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath =
        tempPath + '/file_01.tmp'; // file_01.tmp is dump file, can be anything
    return File(filePath)
        .writeAsBytes(buffer.asUint8List(byteData.offsetInBytes,
        byteData.lengthInBytes));
  }
  @override
  Widget build(BuildContext context) {
    // Navigation.selindex=0;

    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;
    double h = 50;
    double w = 50;
    return Scaffold(
      // bottomNavigationBar: /*NavigationTest()*/Navigation(),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            elevation: 0,
            hoverElevation: 0,
            onPressed: ()async {
              await LaunchApp.openApp(
                  androidPackageName: 'com.spidermbz.chamel',
                  openStore: true);
    }
            ,
            child: ClipRRect(
                child: Image(
                    image: AssetImage('assets/images/shamel.png'),
                    width: width! * 0.1),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            backgroundColor: appTheme.primaryColor.withOpacity(.5),
          ),

          SizedBox(height: height!*0.02,),
          FloatingActionButton(
            heroTag: "btn2",
            elevation: 0,
            hoverElevation: 0,
            onPressed: () {

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("مشاركة التطبيق".i18n()),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                onPrimary: Colors.white,
                              ),
                              child: Icon(Icons.facebook_rounded,color:Colors.white),
                              onPressed: () async {
                                final abn=await SocialShare.checkInstalledAppsForShare();
                                if(abn?["facebook"]==true){
                                  //SocialShare.shareFacebookStory(appId: "1546971825502376",attributionURL: "https://play.google.com/store/apps/details?id=com.spidermbz.dream");
                                  await FlutterShareMe().shareToFacebook(msg:"فسر حلمك بسرعة ودقة مع مفسر الاحلام".i18n(),url: "https://play.google.com/store/apps/details?id=com.spidermbz.dream" );

                                };
                              },
                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: SizedBox(
                            height: h,
                            width: w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                onPrimary: Colors.white,
                              ),
                              child:  Icon(Icons.messenger_outline_rounded,color:Colors.white),
                              onPressed: () async {
                                final abn=await SocialShare.checkInstalledAppsForShare();
                                if(abn?["facebook"]==true){
                                  //   SocialShare.shareInstagramStory(appId: "1546971825502376",imagePath: (await getImageFileFromAssets("images/mfsrlogo.png")).path,attributionURL: "https://play.google.com/store/apps/details?id=com.spidermbz.dream" );
                                  await FlutterShareMe().shareToMessenger(msg:"فسر حلمك بسرعة ودقة مع مفسر الاحلام".i18n(),url: "https://play.google.com/store/apps/details?id=com.spidermbz.dream" );
                                };
                              },
                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: SizedBox(
                            height: h,
                            width: w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                onPrimary: Colors.white,
                              ),
                              child: Image.asset('assets/images/telegram.png'),
                              onPressed: () async {
                                final abn=await SocialShare.checkInstalledAppsForShare();
                                if(abn?["telegram"]==true){
                                  SocialShare.shareTelegram("فسر حلمك بسرعة ودقة مع مفسر الاحلام".i18n()+"\n"+"https://play.google.com/store/apps/details?id=com.spidermbz.dream",);
                                };
                              },
                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: SizedBox(
                            height: h,
                            width: w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                onPrimary: Colors.white,
                              ),
                              child: Image.asset('assets/images/whatsapp.png'),
                              onPressed: () async {
                                final abn=await SocialShare.checkInstalledAppsForShare();
                                if(abn?["whatsapp"]==true){
                                  SocialShare.shareWhatsapp("فسر حلمك بسرعة ودقة مع مفسر الاحلام".i18n()+"\n"+"https://play.google.com/store/apps/details?id=com.spidermbz.dream",);
                                };
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );


            },
            child: Icon(Icons.info_outline),
            backgroundColor: appTheme.primaryColor.withOpacity(.5),
          )
        ],
      ),

      body: ValueListenableBuilder(valueListenable: core.abc, builder: (BuildContext context,value,child){

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[


              HomeTop(), Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // SizedBox(
                        //   width: width! * 0.05,
                        // ),
                        Text(
                          "الاحلام الحديثة".i18n(),
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Spacer(),
                        TextButton(child: Text("رؤية الجميع".i18n(), style: viewallstyle),onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>ahlm_feed(lst: 0)));
                        },)
                      ],
                    ),
                  ),
                  core.ad.banner,
                  Container(
                    height: height! * .15 ,
                    padding: EdgeInsets.all(5),
                    //height: height! * .25 < 300 ? height! * .25 : 300,
                    // child:
                    // ConstrainedBox(
                    //   constraints: BoxConstraints(maxHeight: 170, minHeight: height! * .13),
                    child: ValueListenableBuilder(valueListenable: core.abc,builder: (BuildContext context,into,child){return ListView.separated(
                        separatorBuilder: (context, index) =>SizedBox(width: width!*0.02,),
                        itemBuilder: (context, index) {



                          //#region voice_other


                          //static const theSource = AudioSource.microphone;
                          bool playing = false;

                          String _voicefilepath = '/data/user/0/com.spidermbz.dream/DreamVoice/',
                              currentvoice = '';
                          FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();

                          bool _mPlayerIsInited = false;

                          bool _mplaybackReady = false;



                          void voice() {
                            ///init
                            _mPlayer!.openPlayer().then((value) {
                              setState(() {
                                _mPlayerIsInited = true;
                              });
                            });


                            //////
                          }



                          void play() {
                            assert(_mPlayerIsInited &&
                                _mplaybackReady &&

                                _mPlayer!.isStopped);
                            _mPlayer!
                                .startPlayer(
                                fromURI: _voicefilepath + currentvoice,
                                //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
                                whenFinished: () {
                                  setState(() {
                                    playing = false;
                                    cont.reset();
                                  });
                                })
                                .then((value) {
                              setState(() {
                                playing = true;
                              });
                            });
                          }

                          void stopPlayer() {
                            _mPlayer!.stopPlayer().then((value) {
                              setState(() {
                                playing = false;
                              });
                            });
                          }
//#endregion

                          return (core.holm!=null&&core.holm!.length>0)? Container(
                              decoration: BoxDecoration(gradient:LinearGradient(colors: [
                                appTheme.primaryColor,
                                appTheme.secondaryHeaderColor
                              ]) ,borderRadius: BorderRadius.all(Radius.circular(10))),
                              width: width!*0.5,
                              padding: EdgeInsets.all(4),
                              child:
                              InkWell(child: Container(
                                decoration: BoxDecoration(color:Colors.white  ,borderRadius: BorderRadius.all(Radius.circular(8))),
                                padding: EdgeInsets.only(left: 4,right: 4,top:4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Text("الحالة : ".i18n()+(core.holm![index]["status"]=="fnch"?"تم تفسيره".i18n():core.holm![index]["status"]=="sent"?"قيد التفسير".i18n():"مقروء".i18n()),
                                      style:TextStyle(
                                          color: (core.holm![index]["status"]=="fnch"?Colors.blueAccent:core.holm![index]["status"]=="sent"?Colors.red:Colors.black)

                                      ),
                                    ),
                                    SizedBox(height: height!*0.01,),
                                    Expanded(
                                      flex: 1,
                                      child: Text(core.holm![index]["holm"],style: TextStyle(fontSize: 16,
                                          color: (core.holm![index]["status"]=="fnch"?Colors.blueAccent:core.holm![index]["status"]=="sent"?Colors.red:Colors.black)
                                      ),overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,maxLines: 3),
                                    ),
                                  ],
                                ),
                              ) ,
                                onTap: () async {
                                 int lst=0;
                                  String time=lst==0?core.holm![index]["time"]:core.feed![index]["time"],
                                      holmm=lst==0?"الحلم:  \n".i18n()+core.holm![index]["holm"]:"\nالملاحظة:  ".i18n()+core.feed![index]["feedmessage"],
                                      tfser=lst==0?"التفسير:  \n".i18n()+(core.holm![index]["tfser"]=="N/A"?"الحلم قيد التفسير".i18n():core.holm![index]["tfser"]):"الرد:  \n".i18n()+(core.feed![index]["rad"]=="N/A"?"الملاحظة قيد المراجعة".i18n():core.feed![index]["rad"]);
                                  holmm.contains("dream_aud")?(currentvoice=core.holm![index]["holm"]):currentvoice="";
                                  try{
                                  time=  DateFormat("yyyy/MM/dd  hh:mm:ss a").format(  DateTime.fromMillisecondsSinceEpoch(int.parse(time)));
                                  }catch(e){
                                    time=lst==0?core.holm![index]["time"]:core.feed![index]["time"];
                                  }
                                 core.ad.loadAd();
                                  showDialog(context: context , builder:(BuildContext context){

                                    if( holmm.contains("dream_aud")){
                                      _mplaybackReady=true;
                                      voice();
                                    }
                                    return Card(shadowColor: Colors.purpleAccent,elevation: 5,child: SingleChildScrollView(child: Column(

                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            width: width!,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.purpleAccent,
                                                    offset: const Offset(
                                                      5.0,
                                                      5.0,
                                                    ),
                                                    blurRadius: 10.0,
                                                    spreadRadius: 2.0,
                                                  ), //BoxShadow
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    offset: const Offset(0.0, 0.0),
                                                    blurRadius: 0.0,
                                                    spreadRadius: 0.0,
                                                  ), //BoxShadow
                                                ]),
                                            padding: EdgeInsets.all(height! * 0.02),
                                            child: Text(time,style: TextStyle(fontSize: 18),textAlign: TextAlign.center),
                                          ),
                                          SizedBox(height: height!*0.01,),
                                          core.ad.banner,
                                          SizedBox(height: height!*0.01,),
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            width: width!,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.purpleAccent,
                                                    offset: const Offset(
                                                      5.0,
                                                      5.0,
                                                    ),
                                                    blurRadius: 10.0,
                                                    spreadRadius: 2.0,
                                                  ), //BoxShadow
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    offset: const Offset(0.0, 0.0),
                                                    blurRadius: 0.0,
                                                    spreadRadius: 0.0,
                                                  ), //BoxShadow
                                                ]),
                                            padding: EdgeInsets.all(height! * 0.02),
                                            child: !holmm.contains("dream_aud")? Text(holmm,style: TextStyle(fontSize: 18),textAlign: TextAlign.center):
                                            InkWell(
                                              child: CircularCountDownTimer(
                                                duration: 60,
                                                initialDuration: 0,
                                                controller: cont,
                                                width: width! * 0.4,
                                                height: width! * 0.4,
                                                ringColor: Colors.grey[300]!,
                                                ringGradient: null,
                                                fillColor: Colors.blueAccent[100]!,
                                                fillGradient: null,
                                                backgroundColor: Colors.purple[400],
                                                backgroundGradient: null,
                                                strokeWidth: 12.0,
                                                strokeCap: StrokeCap.round,
                                                textStyle: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                                textFormat: CountdownTextFormat.S,
                                                isReverse: false,
                                                isReverseAnimation: false,
                                                isTimerTextShown: true,
                                                autoStart: false,
                                                onStart: () {},
                                                onComplete: () {

                                                },
                                                onChange: (String timeStamp) {},
                                                timeFormatterFunction:
                                                    (defaultFormatterFunction, duration) {
                                                  if (duration.inSeconds == 0) {
                                                    if (currentvoice.isNotEmpty)
                                                      return 'اضغط للاستماع'.i18n();
                                                    else
                                                      return 'اضغط للتسجيل'.i18n();
                                                  } else if (duration.inSeconds == 60) {
                                                    if (currentvoice.isNotEmpty)
                                                      return 'اضغط للاستماع'.i18n();
                                                    else
                                                      return 'اضغط للتسجيل'.i18n();
                                                  } else {
                                                    // return Function.apply(defaultFormatterFunction, [duration]);
                                                    return 'اضغط للايقاف'.i18n();
                                                  }
                                                },
                                              ),
                                              onTap: () {
                                                if (currentvoice.isNotEmpty ) {
                                                  playing ? stopPlayer() : play();
                                                }
                                                if (cont.getTime() != '0')
                                                  cont.reset();
                                                else
                                                  cont.start();
                                              },
                                            ),

                                          ),
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            width: width!,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.purpleAccent,
                                                    offset: const Offset(
                                                      5.0,
                                                      5.0,
                                                    ),
                                                    blurRadius: 10.0,
                                                    spreadRadius: 2.0,
                                                  ), //BoxShadow
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    offset: const Offset(0.0, 0.0),
                                                    blurRadius: 0.0,
                                                    spreadRadius: 0.0,
                                                  ), //BoxShadow
                                                ]),
                                            padding: EdgeInsets.all(height! * 0.02),
                                            child:  Text(tfser,style: TextStyle(fontSize: 18),textAlign: TextAlign.center),
                                          ),


                                        ])),);
                                  } );

                                  if(lst==0){
                                    if(core.holm![index]["status"]=="fnch") {
                                      Map hlm = Map.of(core.holm![index]);
                                      hlm['status'] = 'read';
                                      try {
                                        await DBProvider().updateahlamdb(
                                            hlm['nb'], hlm["holm"],
                                            hlm['tfser'], hlm["mode"],
                                            hlm["status"],
                                            hlm["time"]);
                                        await DBProvider().getdb(1);
                                      } catch (E) {
                                        print(E);
                                      }
                                    }
                                  }
                                  else{
                                    if(core.feed![index]["status"]=="fnch"){
                                      Map hlm= Map.of(core.feed![index]);
                                      hlm['status']='read';
                                      await DBProvider().updatefeeddb(
                                          hlm['nb'], hlm["feedmessage"],
                                          hlm['rad'],  hlm["status"],
                                          hlm["time"]);
                                      await DBProvider().getdb(2);
                                    }}
                                  setState(() {

                                  });
                                },)

                          ):Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("لاتوجد احلام حديثة".i18n())
                            ],

                          );},
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0.0),
                        itemCount:(core.holm!=null&&core.holm!.length>0)?(core.holm!.length>10?10: core.holm!.length):1,
                        scrollDirection: Axis.horizontal);}),
                  ),
                ],
              )],
          ),
        );
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {


    });
  }
}
var selectedloc = 0;
int mode = -1;
class HomeTop extends StatefulWidget {
  @override
  _HomeTop createState() => _HomeTop();
}
TextEditingController c = TextEditingController(),cmo= TextEditingController();
CountDownController cont = CountDownController();

void loading(BuildContext context){showDialog(
    context: context,barrierDismissible: false,
    builder: (BuildContext contexts) {
      return  Material(child: WillPopScope(
          child: Container(
            height: height!,
            width: width!,
            padding: EdgeInsets.only(
                top: height! * 0.35,
                bottom: height! * 0.35,
                left: width! * 0.30,
                right: width! * 0.30),
            color: Colors.black12,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purpleAccent,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ]),
              padding: EdgeInsets.all(height! * 0.02),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                  children: [


                    CircularProgressIndicator(color: Colors.purpleAccent,),
                    SizedBox(height: height!*0.0425,),

                    Text(
                      "جار التحميل".i18n(),
                      style: TextStyle(fontSize: 19,),textAlign: TextAlign.center,
                    ),
                  ]),
            ),
          ),
          onWillPop: () async => false),type: MaterialType.transparency,);
    });}
class _HomeTop extends State<HomeTop> {
  var isFlightselected = true;

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: Clipper08(),
          child: Container(
            // height: height! * .65 < 450 ? height! * .65 : 500, //400
            //color: Colors.tealAccent,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/back.jpg"),fit: BoxFit.cover,opacity:0.5 ),
                gradient: LinearGradient(colors: [
                  appTheme.primaryColor,
                  appTheme.secondaryHeaderColor
                ])),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30, right: 13, left: 13),
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.support_agent_rounded),
                            onPressed: () {

                              showDialog(context: context, builder: (BuildContext context){return AlertDialog(elevation: 5,title: Text("ارسل ملاحظتك؟".i18n() ),actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ahlm_feed(lst: 1)));
                                }, child: Text("الملاحظات المرسلة ".i18n(),style: TextStyle(fontSize: 19),)),
                                TextButton(onPressed: () async {
                                  try {
                                    String msgfeed = cmo.text.replaceAll(
                                        "/", "");
                                    if (msgfeed.length > 0) {
                                      loading(context);
                                      await firebase().sendholm(
                                          msgfeed, -1, "");
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      await DBProvider().getdb(2);
                                      cmo.clear();
                                      core.ad.loadAd();
                                      showDialog(context: context,
                                          builder: (BuildContext context) {
                                            return Center(child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius
                                                      .all(
                                                      Radius.circular(30)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors
                                                          .purpleAccent,
                                                      offset: const Offset(
                                                        5.0,
                                                        5.0,
                                                      ),
                                                      blurRadius: 10.0,
                                                      spreadRadius: 2.0,
                                                    ), //BoxShadow
                                                    BoxShadow(
                                                      color: Colors.white,
                                                      offset: const Offset(
                                                          0.0, 0.0),
                                                      blurRadius: 0.0,
                                                      spreadRadius: 0.0,
                                                    ), //BoxShadow
                                                  ]),
                                              padding: EdgeInsets.only(top: 20,
                                                  bottom: 20,
                                                  right: 20,
                                                  left: 20),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text("ملاحظة".i18n(),
                                                      style: TextStyle(
                                                          fontSize: 29),
                                                      textAlign: TextAlign
                                                          .center),
                                                  SizedBox(height: 40,),
                                                  Text(
                                                      "تمت العملية بنجاح . والان نرجو منك الانتظار نسرسل لك اشعارا عند الانتهاء "
                                                          .i18n(),
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                      textAlign: TextAlign
                                                          .center),
                                                  SizedBox(height: 30,),
                                                  Row(mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                        }, child: Row(
                                                        mainAxisSize: MainAxisSize
                                                            .min,
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.check,
                                                            size: 30,
                                                            color: Colors
                                                                .purpleAccent,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "موافق".i18n(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .lightBlue,
                                                                fontSize: 26),
                                                          )
                                                        ],
                                                      ),),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5,),
                                                ],
                                              ),

                                            ),);
                                          });
                                    } else
                                      showToast("ارسل ملاحظتك؟".i18n(),
                                          context: context,
                                          animation: StyledToastAnimation.scale,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)));
                                  }catch(E){}
                                }, child: Text("ارسال".i18n(),style: TextStyle(fontSize: 19),)),
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("الغاء".i18n(),style: TextStyle(fontSize: 19),)),

                              ],
                                content:Container(
                                  width: width,
                                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                                  child: Material(
                                    elevation: 5.0,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                    child: TextField(
                                      controller: cmo,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                      ),
                                      cursorColor: appTheme.primaryColor,
                                      maxLength: 600,
                                      maxLines: 10,
                                      minLines: 1,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'اكتب ملاحظتك هنا....'.i18n(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 32, vertical: 13),
                                      ),
                                    ),
                                  ),
                                ),

                              );});


                            },
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: width! * 0.02,
                          ),
                          Text(
                            'ملاحظة'.i18n(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          final _state = _sideMenuKey.currentState;
                          if (_state!.isOpened)
                            _state.closeSideMenu(); // close side menu
                          else
                            _state.openSideMenu();//
                        },
                        color: Colors.white,iconSize: 30,
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                    child: Image(
                        image: AssetImage('assets/images/mfsrlogo.png'),
                        width: width! * 0.3),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                SizedBox(height: height! * 0.0275),

                Text(
                  mode == -1
                      ? 'الوقت المتبقي لاخذ الرصيد المجاني  '
                      .i18n()
                      : mode == 0
                      ? 'رسالة نصية'.i18n()
                      : 'مقطع صوتي'.i18n(),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                if(mode==-1)
                  CountdownTimer(
                    endTime: core.bokra,textStyle:TextStyle(
                    fontSize: 23.0,
                    color: Colors.white,
                  ) ,onEnd: (){
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      //// showDialog(context: context, builder: (BuildContext c){return Container(color: Colors.red,);});

                    });
                    print("finishhhhhhhhhh");

                  },endWidget: Container(),
                  ),
                SizedBox(height: height! * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: width! * 0.0425,
                    ),
                    if (mode != -1)
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              mode = -1;
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "عودة".i18n(),
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 16),
                              )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(70, 40),
                            // padding: EdgeInsets.symmetric(horizontal: 16),
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            ),
                          )),
                    Spacer(),
                    Text(
                      'رصيدك الحالي : '.i18n()+core.point.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(
                      width: width! * 0.0125,
                    ),
                  ],
                ),
                SizedBox(height: height! * 0.0275),
                mode == -1
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(children: [
                      Text(
                        'اختر المفسر'.i18n(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height! * 0.01,
                      ),
                      Container(
                        width: width! * 0.4,
                        child: DropdownButtonFormField2(
                          decoration: InputDecoration(
                            //Add isDense true and zero Padding.
                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            //Add more decoration as you want here
                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                          ),
                          isExpanded: true,
                          value: selectemofaser,
                          hint: Text(
                            'اختر المفسر'.i18n(),
                            style: TextStyle(
                                fontSize: 14, color: Colors.lightBlue),
                          ),
                          items: mofaser
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item.i18n(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.lightBlue),
                            ),
                          ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select gender.';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              selectemofaser = value.toString();
                            });
                          },
                          onSaved: (value) {},
                          buttonStyleData: const ButtonStyleData(
                            height: 60,
                            padding: EdgeInsets.only(left: 20, right: 10),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.lightBlue,
                            ),
                            iconSize: 30,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(15))),
                      ),
                    ]),
                    SizedBox(
                      width: width! * 0.04,
                    ),
                    Column(
                      children: [
                        Text(
                          'اختر نوع الحلم'.i18n(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height! * 0.01,
                        ),
                        Container(
                          width: width! * 0.4,
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              //Add isDense true and zero Padding.
                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              //Add more decoration as you want here
                              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                            ),
                            isExpanded: true,
                            value: selectednaw3,
                            hint: Text(
                              'اختر نوع الحلم'.i18n(),
                              style: TextStyle(
                                  fontSize: 14, color: Colors.lightBlue),
                            ),
                            items: nw3
                                .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item.i18n(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.lightBlue),
                              ),
                            ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select gender.';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              //Do something when changing the item if you want.
                              setState(() {
                                selectednaw3 = value.toString();
                              });
                            },
                            onSaved: (value) {},
                            buttonStyleData: const ButtonStyleData(
                              height: 60,
                              padding:
                              EdgeInsets.only(left: 20, right: 10),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.lightBlue,
                              ),
                              iconSize: 30,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                        )
                      ],
                    )
                  ],
                )
                    : mode == 0
                    ? Container(
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius:
                    BorderRadius.all(Radius.circular(30)),
                    child: TextField(
                      controller: c,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      cursorColor: appTheme.primaryColor,
                      maxLength: 600,
                      maxLines: 10,
                      minLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'اكتب حلمك هنا....'.i18n(),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 32, vertical: 13),
                      ),
                    ),
                  ),
                )
                    : InkWell(
                  child: CircularCountDownTimer(
                    duration: 60,
                    initialDuration: 0,
                    controller: cont,
                    width: width! * 0.4,
                    height: width! * 0.4,
                    ringColor: Colors.grey[300]!,
                    ringGradient: null,
                    fillColor: Colors.blueAccent[100]!,
                    fillGradient: null,
                    backgroundColor: Colors.purple[400],
                    backgroundGradient: null,
                    strokeWidth: 12.0,
                    strokeCap: StrokeCap.round,
                    textStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textFormat: CountdownTextFormat.S,
                    isReverse: false,
                    isReverseAnimation: false,
                    isTimerTextShown: true,
                    autoStart: false,
                    onStart: () {},
                    onComplete: () {
                      if (recording) stopRecorder();
                    },
                    onChange: (String timeStamp) {},
                    timeFormatterFunction:
                        (defaultFormatterFunction, duration) {
                      if (duration.inSeconds == 0) {
                        if (currentvoice.isNotEmpty)
                          return 'اضغط للاستماع'.i18n();
                        else
                          return 'اضغط للتسجيل'.i18n();
                      } else if (duration.inSeconds == 60) {
                        if (currentvoice.isNotEmpty)
                          return 'اضغط للاستماع'.i18n();
                        else
                          return 'اضغط للتسجيل'.i18n();
                      } else {
                        // return Function.apply(defaultFormatterFunction, [duration]);
                        return 'اضغط للايقاف'.i18n();
                      }
                    },
                  ),
                  onTap: () {
                    if (currentvoice.isNotEmpty && !recording) {
                      playing ? stopPlayer() : play();
                    } else {
                      recording ? stopRecorder() : record();
                    }
                    if (cont.getTime() != '0')
                      cont.reset();
                    else
                      cont.start();
                  },
                ),
                if (mode == 1 &&
                    currentvoice.isNotEmpty &&
                    !recording &&
                    !playing) ...[
                  SizedBox(
                    height: height! * 0.01,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await File(_voicefilepath + currentvoice)
                            .delete()
                            .then((value) {
                          setState(() {
                            currentvoice = '';
                          });
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.restore_from_trash_rounded,
                            size: 20,
                            color: Colors.purpleAccent,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(50, 30),
                        // padding: EdgeInsets.symmetric(horizontal: 16),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      )),
                ],
                if (selectednaw3 != null &&
                    selectemofaser != null &&
                    mode == -1) ...{
                  SizedBox(
                    height: height! * 0.025,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                        selectednaw3 == nw3[1]
                            ? 'ارسل حلمك بمقطع صوتي يرجى التحدث باللغة العربية الفصحى . سيتم خصم 7 نقاط'
                            .i18n()
                            : selectednaw3 == nw3[0]
                            ? 'اكتب حلمك برسالة نصية يرجى التحدث باللغة العربية الفصحى . سيتم خصم 5 نقاط'
                            .i18n()
                            : 'سيتم خصم 29 نقطة للتحدث الى المفسر مباشرة (لا تخرج قبل انهاء المحادثة فكل مرة تحتاج الدخول فيها سيتم خصم 29 نقطة)'
                            .i18n(),
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        textAlign: TextAlign.center),
                  ),
                },
                SizedBox(
                  height: height! * 0.03,
                ),
                ElevatedButton(
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());


                      // FirebaseAuth.instance.signOut();
                      // print(FirebaseAuth.instance.currentUser!.uid);
                      //firebase().authinit(context);
                      //firebase().googlesignin(context);
                      //firebase().guestsignin(context);
                      //firebase().guesttogoogle(context)
                      switch(mode){
                        case -1:
                          if (selectednaw3 == nw3[0]){
                            loading(context);
                            if(await firebase().checkbalance()>=5){
                              Navigator.pop(context);
                              setState(() {
                                mode = 0;
                              });
                              showDialog(context: context, builder: (BuildContext context){

                                return Center(child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.purpleAccent,
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: const Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        ), //BoxShadow
                                      ]),
                                  padding: EdgeInsets.only(top: 20,bottom: 20,right: 20,left: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("ملاحظة".i18n(),style: TextStyle(fontSize: 29),textAlign: TextAlign.center),
                                      SizedBox(height: 40,),
                                      Text("نظرا للوضع في لبنان(كهرباء.شبكة) نأسف لتأخير تفسير الاحلام المرسلة من الساعة( ".i18n()+DateFormat("hh:mm").format(DateTime.utc(2000,11,11,21,00).toLocal()).toString() +" الى الساعة ".i18n()+ DateFormat("hh:mm").format(DateTime.utc(2000,11,11,06,00).toLocal()).toString()+" صباحا ".i18n()+" ) الى ما بعد ذلك الوقت (مؤقتا) . نشكر تفهمكم".i18n(),style: TextStyle(fontSize: 25),textAlign: TextAlign.center),
                                      SizedBox(height: 30,),
                                      Row(mainAxisAlignment:
                                      MainAxisAlignment.center,
                                        children: [
                                          TextButton(onPressed: () async {
                                            Navigator.pop(context);

                                          }, child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Icon(
                                                Icons.check,
                                                size: 30,
                                                color: Colors.purpleAccent,
                                              ),
                                              SizedBox(
                                                width:10,
                                              ),
                                              Text(
                                                "موافق".i18n(),
                                                style: TextStyle(
                                                    color: Colors.lightBlue, fontSize: 26),
                                              )
                                            ],
                                          ),),
                                        ],
                                      ),
                                      SizedBox(height:5,),
                                    ],
                                  ),

                                ),);
                              });
                            }
                            else{
                              Navigator.pop(context);
                              showDialog(context: context, builder: (BuildContext context){

                                return Center(child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.purpleAccent,
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: const Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        ), //BoxShadow
                                      ]),
                                  padding: EdgeInsets.only(top: 40,bottom: 40,right: 20,left: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("للاسف ليس لديك رصيد كاف".i18n(),style: TextStyle(fontSize: 29),textAlign: TextAlign.center),
                                      SizedBox(height: 15,),
                                      Text("انت بحاجة الى 5 نقاط للمتابعة".i18n(),style: TextStyle(fontSize: 25),textAlign: TextAlign.center),
                                      SizedBox(height: 30,),
                                      Row(mainAxisAlignment:
                                      MainAxisAlignment.center,
                                        children: [
                                          TextButton(onPressed: () async {
                                            Navigator.pop(context);
                                            core.sel.value=2;
                                          }, child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Icon(
                                                Icons.check,
                                                size: 30,
                                                color: Colors.purpleAccent,
                                              ),
                                              SizedBox(
                                                width:10,
                                              ),
                                              Text(
                                                "موافق".i18n(),
                                                style: TextStyle(
                                                    color: Colors.lightBlue, fontSize: 26),
                                              )
                                            ],
                                          ),),
                                        ],
                                      ),
                                      SizedBox(height:5,),
                                    ],
                                  ),

                                ),);
                              });}
                          }
                          else if (selectednaw3 == nw3[1]){
                            if(core.lnn=="ar"){
                            loading(context);
                            if(await firebase().checkbalance()>=7){
                              Navigator.pop(context);
                              setState(() {
                                mode = 1;
                                voice();

                              });
                            }
                            else {
                              Navigator.pop(context);
                              showDialog(context: context, builder: (BuildContext context){

                                return Center(child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.purpleAccent,
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: const Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        ), //BoxShadow
                                      ]),
                                  padding: EdgeInsets.only(top: 40,bottom: 40,right: 20,left: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("للاسف ليس لديك رصيد كاف".i18n(),style: TextStyle(fontSize: 29),textAlign: TextAlign.center),
                                      SizedBox(height: 15,),
                                      Text("انت بحاجة الى 7 نقاط للمتابعة".i18n(),style: TextStyle(fontSize: 25),textAlign: TextAlign.center),
                                      SizedBox(height: 30,),
                                      Row(mainAxisAlignment:
                                      MainAxisAlignment.center,
                                        children: [
                                          TextButton(onPressed: () async {
                                            Navigator.pop(context);
                                            core.sel.value=2;
                                          }, child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Icon(
                                                Icons.check,
                                                size: 30,
                                                color: Colors.purpleAccent,
                                              ),
                                              SizedBox(
                                                width:10,
                                              ),
                                              Text(
                                                "موافق".i18n(),
                                                style: TextStyle(
                                                    color: Colors.lightBlue, fontSize: 26),
                                              )
                                            ],
                                          ),),
                                        ],
                                      ),
                                      SizedBox(height:5,),
                                    ],
                                  ),

                                ),);
                              });
                            }
                            }else{
                              showDialog(context: context, builder: (BuildContext context){return AlertDialog(elevation: 5,title: Text("هذه الخاصية غير متاحة ببلدك حاليا".i18n() ),actions: [
                                TextButton(onPressed: () async {
                                 Navigator.pop(context);

                                }, child: Text("متابعة".i18n(),style: TextStyle(fontSize: 19),)),

                              ],);});
                            }
                          }
                          else{

                         if(core.lnn=="ar"){
                            if(core.privatechat){
                              loading(context);
                              if(await firebase().checkbalance()>=29){
                                Navigator.pop(context);

                                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>WishList(private: true,mofser: selectemofaser!,)));
                                core.ad.loadAd();
                              }
                              else{
                                Navigator.pop(context);
                                showDialog(context: context, builder: (BuildContext context){

                                  return Center(child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.purpleAccent,
                                            offset: const Offset(
                                              5.0,
                                              5.0,
                                            ),
                                            blurRadius: 10.0,
                                            spreadRadius: 2.0,
                                          ), //BoxShadow
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: const Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            spreadRadius: 0.0,
                                          ), //BoxShadow
                                        ]),
                                    padding: EdgeInsets.only(top: 40,bottom: 40,right: 20,left: 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("للاسف ليس لديك رصيد كاف".i18n(),style: TextStyle(fontSize: 29),textAlign: TextAlign.center),
                                        SizedBox(height: 15,),
                                        Text("انت بحاجة الى 29 نقاط للمتابعة".i18n(),style: TextStyle(fontSize: 25),textAlign: TextAlign.center),
                                        SizedBox(height: 30,),
                                        Row(mainAxisAlignment:
                                        MainAxisAlignment.center,
                                          children: [
                                            TextButton(onPressed: () async {
                                              Navigator.pop(context);
                                              core.sel.value=2;
                                            }, child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.check,
                                                  size: 30,
                                                  color: Colors.purpleAccent,
                                                ),
                                                SizedBox(
                                                  width:10,
                                                ),
                                                Text(
                                                  "موافق".i18n(),
                                                  style: TextStyle(
                                                      color: Colors.lightBlue, fontSize: 26),
                                                )
                                              ],
                                            ),),
                                          ],
                                        ),
                                        SizedBox(height:5,),
                                      ],
                                    ),

                                  ),);
                                });
                              }}
                            else{
                              showDialog(context: context, builder: (BuildContext context){

                                return Center(child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.purpleAccent,
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: const Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        ), //BoxShadow
                                      ]),
                                  padding: EdgeInsets.only(top: 40,bottom: 40,right: 20,left: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("ملاحظة".i18n(),style: TextStyle(fontSize: 29),textAlign: TextAlign.center),
                                      SizedBox(height: 15,),
                                      Text("الدردشة غير متاحة الا بعد وقت 4 utc وذلك تجنبا للتاخير في الرد. نشكر تفهمكم".i18n(),style: TextStyle(fontSize: 25),textAlign: TextAlign.center),
                                      SizedBox(height: 30,),
                                      Row(mainAxisAlignment:
                                      MainAxisAlignment.center,
                                        children: [
                                          TextButton(onPressed: () async {
                                            Navigator.pop(context);

                                          }, child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Icon(
                                                Icons.check,
                                                size: 30,
                                                color: Colors.purpleAccent,
                                              ),
                                              SizedBox(
                                                width:10,
                                              ),
                                              Text(
                                                "موافق".i18n(),
                                                style: TextStyle(
                                                    color: Colors.lightBlue, fontSize: 26),
                                              )
                                            ],
                                          ),),
                                        ],
                                      ),
                                      SizedBox(height:5,),
                                    ],
                                  ),

                                ),);
                              });
                            }
                              }

                         else{showDialog(context: context, builder: (BuildContext context){return AlertDialog(elevation: 5,title: Text("هذه الخاصية غير متاحة ببلدك حاليا".i18n() ),actions: [
                             TextButton(onPressed: () async {
                           Navigator.pop(context);

                         }, child: Text("متابعة".i18n(),style: TextStyle(fontSize: 19),)),

                         ],);});
                         }



                          }

                          break;
                        case 0:

                          String msg= c.text.replaceAll("/","");
                          if(msg.length>0) {

                            try {
                              loading(context);
                              await firebase().sendholm(
                                  msg, 0, selectemofaser!);
                              Navigator.pop(context);
                              await DBProvider().getdb(1);
                              c.clear();
                              mode=-1;
                              core.abc.value+=1;
                              core.ad.loadAd();
                              showDialog(context: context, builder: (BuildContext context){

                                return Center(child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.purpleAccent,
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: const Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        ), //BoxShadow
                                      ]),
                                  padding: EdgeInsets.only(top: 20,bottom: 20,right: 20,left: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("ملاحظة".i18n(),style: TextStyle(fontSize: 29),textAlign: TextAlign.center),
                                      SizedBox(height: 40,),
                                      Text("تمت العملية بنجاح . والان نرجو منك الانتظار  بضع الوقت لنقوم بتفسيره (ساعة واحدة بحد اقصى خارج اوقات التأخير) نسرسل لك اشعارا عند الانتهاء ".i18n(),style: TextStyle(fontSize: 25),textAlign: TextAlign.center),
                                      SizedBox(height: 30,),
                                      Row(mainAxisAlignment:
                                      MainAxisAlignment.center,
                                        children: [
                                          TextButton(onPressed: () async {
                                            Navigator.pop(context);

                                          }, child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Icon(
                                                Icons.check,
                                                size: 30,
                                                color: Colors.purpleAccent,
                                              ),
                                              SizedBox(
                                                width:10,
                                              ),
                                              Text(
                                                "موافق".i18n(),
                                                style: TextStyle(
                                                    color: Colors.lightBlue, fontSize: 26),
                                              )
                                            ],
                                          ),),
                                        ],
                                      ),
                                      SizedBox(height:5,),
                                    ],
                                  ),

                                ),);
                              });
                            }
                            catch(e){}



                          }
                          else {
                            showToast("عليك كتابة الحلم اولا".i18n(),context: context,animation:StyledToastAnimation.scale,borderRadius: BorderRadius.all(Radius.circular(20)));

                          }



                          break;
                        case 1:

                          if(currentvoice.length>4) {
                            loading(context);
                            if(playing){
                              stopPlayer();
                              playing=false;}
                            if(recording)stopRecorder();
                            _mplaybackReady=false;
                            await firebase().sendholm(currentvoice, 1,selectemofaser!);
                            currentvoice="";
                            await DBProvider().getdb(1);
                            mode=-1;
                            core.abc.value+=1;
                            Navigator.pop(context);
                            core.ad.loadAd();
                            showDialog(context: context, builder: (BuildContext context){

                              return Center(child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.purpleAccent,
                                        offset: const Offset(
                                          5.0,
                                          5.0,
                                        ),
                                        blurRadius: 10.0,
                                        spreadRadius: 2.0,
                                      ), //BoxShadow
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: const Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ), //BoxShadow
                                    ]),
                                padding: EdgeInsets.only(top: 20,bottom: 20,right: 20,left: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("ملاحظة".i18n(),style: TextStyle(fontSize: 29),textAlign: TextAlign.center),
                                    SizedBox(height: 40,),
                                    Text("تمت العملية بنجاح . والان نرجو منك الانتظار  بضع الوقت لنقوم بتفسيره (ساعة واحدة بحد اقصى خارج اوقات التأخير) نسرسل لك اشعارا عند الانتهاء ".i18n(),style: TextStyle(fontSize: 25),textAlign: TextAlign.center),
                                    SizedBox(height: 30,),
                                    Row(mainAxisAlignment:
                                    MainAxisAlignment.center,
                                      children: [
                                        TextButton(onPressed: () async {
                                          Navigator.pop(context);

                                        }, child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(
                                              Icons.check,
                                              size: 30,
                                              color: Colors.purpleAccent,
                                            ),
                                            SizedBox(
                                              width:10,
                                            ),
                                            Text(
                                              "موافق".i18n(),
                                              style: TextStyle(
                                                  color: Colors.lightBlue, fontSize: 26),
                                            )
                                          ],
                                        ),),
                                      ],
                                    ),
                                    SizedBox(height:5,),
                                  ],
                                ),

                              ),);
                            });
                          }
                          else {
                            showToast("عليك تسجيل المقطع الصوتي اولا".i18n(),context: context,animation:StyledToastAnimation.scale,borderRadius: BorderRadius.all(Radius.circular(20)));

                          }
                          break;


                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.flight_takeoff,
                          size: 20,
                          color: Colors.purpleAccent,
                        ),
                        SizedBox(
                          width: width! * .025,
                        ),
                        Text(
                          mode == -1 ? "متابعة".i18n() : "ارسال".i18n(),
                          style:
                          TextStyle(color: Colors.lightBlue, fontSize: 16),
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 42),
                      // padding: EdgeInsets.symmetric(horizontal: 16),
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    )),
                SizedBox(
                  height: height! * 0.055,
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }


  final List<String> mofaser = [
    'عشوائي',
    'عبير',
    'مهى',
    'امير',
    'ماجد',
  ],
      nw3 = ['رسالة نصية', 'مقطع صوتي', 'التحدث الى المفسر مباشرة'];

  String? selectemofaser = 'عشوائي', selectednaw3 = 'رسالة نصية';

//#region voice_other


  //static const theSource = AudioSource.microphone;
  bool recording = false, playing = false;
  Codec _codec = Codec.aacMP4;
  String _voicefilepath = '/data/user/0/com.spidermbz.dream/DreamVoice/',
      currentvoice = '';
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;

  Future<void> openTheRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    await _mRecorder!.openRecorder();

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
      AVAudioSessionCategoryOptions.allowBluetooth |
      AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
      AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    _mRecorderIsInited = true;
  }

  void voice() {
    ///init
    _mPlayer!.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
    //////
  }

  void record() {
    currentvoice =
    "${DateTime.now().millisecondsSinceEpoch.toString()}dream_aud.mp4";
    _mRecorder!
        .startRecorder(
      toFile: _voicefilepath + currentvoice,
      codec: _codec,
    )
        .then((value) {
      setState(() {
        recording = true;
      });
    });
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      setState(() {
        //var url = value;
        recording = false;
        _mplaybackReady = true;
      });
    });
  }

  void play() {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder!.isStopped &&
        _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
        fromURI: _voicefilepath + currentvoice,
        //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
        whenFinished: () {
          setState(() {
            playing = false;
            cont.reset();
          });
        })
        .then((value) {
      setState(() {
        playing = true;
      });
    });
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
      setState(() {
        playing = false;
      });
    });
  }
//#endregion


  @override
  void dispose() {
    _mPlayer!.closePlayer();
    _mPlayer = null;

    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.dispose();
  }
}

class Clipper08 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);
    // ignore: non_constant_identifier_names
    var End = Offset(size.width / 2, size.height - 30.0);
    // ignore: non_constant_identifier_names
    var Control = Offset(size.width / 4, size.height - 50.0);

    path.quadraticBezierTo(Control.dx, Control.dy, End.dx, End.dy);
    // ignore: non_constant_identifier_names
    var End2 = Offset(size.width, size.height - 80.0);
    // ignore: non_constant_identifier_names
    var Control2 = Offset(size.width * .75, size.height - 10.0);

    path.quadraticBezierTo(Control2.dx, Control2.dy, End2.dx, End2.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

var viewallstyle =
TextStyle(fontSize: 14, color: appTheme.primaryColor //Colors.teal
);








//////////////////////pages///////////////////////////




class ahlm_feed extends StatefulWidget {
  ahlm_feed({required this.lst} );
  int lst=0;
  _ahlm_feed createState() => _ahlm_feed(lst);

}

class _ahlm_feed extends State<ahlm_feed> {


//#region voice_other


  //static const theSource = AudioSource.microphone;
  bool playing = false;

  String _voicefilepath = '/data/user/0/com.spidermbz.dream/DreamVoice/',
      currentvoice = '';
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();

  bool _mPlayerIsInited = false;

  bool _mplaybackReady = false;



  void voice() {
    ///init
    _mPlayer!.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });


    //////
  }



  void play() {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&

        _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
        fromURI: _voicefilepath + currentvoice,
        //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
        whenFinished: () {
          setState(() {
            playing = false;
            cont.reset();
          });
        })
        .then((value) {
      setState(() {
        playing = true;
      });
    });
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
      setState(() {
        playing = false;
      });
    });
  }
//#endregion


  @override
  void dispose() {
    _mPlayer!.closePlayer();
    _mPlayer = null;


    super.dispose();
  }




  _ahlm_feed(int lst){
    this.lst=lst;
  }

  int lst=0;





  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  ScrollController xntr=ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  WillPopScope(child: Column(children: [
        ClipPath(
          clipper: Clipper08(),
          child: Container(
            // height: height! * .65 < 450 ? height! * .65 : 500, //400
            //color: Colors.tealAccent,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  appTheme.primaryColor,
                  appTheme.secondaryHeaderColor
                ])),
            child:Column(
              children: [  Padding(
                padding: EdgeInsets.only(top: 50, right: 13, left: 13),
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(lst==0?"الاحلام المفسرة".i18n():"الملاحظات".i18n(),style: TextStyle(color: Colors.white,fontSize: 26),)]),
              ),

                SizedBox(height: height! * 0.0675),
              ],
            ),
          ),
        ),
        SizedBox(height: height!*0.01,),
        core.ad.banner,
        SizedBox(height: height!*0.01,),
        Expanded(child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(height: 4),
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(right: 5,left: 5),
          itemCount: lst==0?core.holm!.length:core.feed!.length,
          controller: xntr,
          itemBuilder: (context, index) {
            return Container(
                decoration: BoxDecoration(gradient:LinearGradient(colors: [
                  appTheme.primaryColor,
                  appTheme.secondaryHeaderColor
                ]) ,borderRadius: BorderRadius.all(Radius.circular(20))),
                height: height!*0.08,
                padding: EdgeInsets.all(7),
                child:
                InkWell(child: Container(
                  decoration: BoxDecoration(color:Colors.white  ,borderRadius: BorderRadius.all(Radius.circular(17))),
                  padding: EdgeInsets.only(left: 4,right: 4),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){
                        showDialog(context: context, builder: (BuildContext context1){return AlertDialog(elevation: 5,title: Text("سيتم حذفه نهائيا ولا يمكنك استرجاعه".i18n() ),actions: [
                          TextButton(onPressed: () async {
                            Navigator.pop(context1);
                            loading(context);
                            lst==0? await DBProvider().deleteahlamdb(int.parse(core.holm![index]['nb'].toString())):await DBProvider().deletefeeddb(int.parse(core.holm![index]['nb'].toString()));
                            lst==0? await DBProvider().getdb(1):DBProvider().getdb(2);
                            Navigator.pop(context);
                            setState(() {

                            });
                          }, child: Text("متابعة".i18n(),style: TextStyle(fontSize: 19),)),
                          TextButton(onPressed: (){
                            Navigator.pop(context1);
                          }, child: Text("الغاء".i18n(),style: TextStyle(fontSize: 19),)),
                        ],);});

                      }, icon:Icon(Icons.delete,color: Colors.red),),
                      Spacer(),
                      Expanded(
                        flex: 9,
                        child: Text(lst==0?core.holm![index]["holm"]:core.feed![index]["feedmessage"],style: TextStyle(fontSize: 20,
                            color:lst==0? (core.holm![index]["status"]=="fnch"?Colors.blueAccent:core.holm![index]["status"]=="sent"?Colors.red:Colors.black)
                                :(core.feed![index]["status"]=="fnch"?Colors.blueAccent:core.feed![index]["status"]=="sent"?Colors.red:Colors.black)
                        ),overflow: TextOverflow.ellipsis,maxLines: 1,textAlign: TextAlign.center,),
                      ),
                      Spacer(),
                      lst==0?  (core.holm![index]["status"]=="fnch"?Text("(جديد)".i18n(),style:TextStyle(color:Colors.red,fontSize: 20)):Container()): (core.feed![index]["status"]=="fnch"?Text("(جديد)".i18n(),style:TextStyle(color:Colors.red,fontSize: 20)):Container()),
                      Spacer(),
                    ],
                  ),
                ) ,
                  onTap: () async {

                  String time=lst==0?core.holm![index]["time"]:core.feed![index]["time"],
                      holmm=lst==0?"الحلم:  \n".i18n()+core.holm![index]["holm"]:"\nالملاحظة:  ".i18n()+core.feed![index]["feedmessage"],
                      tfser=lst==0?"التفسير:  \n".i18n()+(core.holm![index]["tfser"]=="N/A"?"الحلم قيد التفسير".i18n():core.holm![index]["tfser"]):"الرد:  \n".i18n()+(core.feed![index]["rad"]=="N/A"?"الملاحظة قيد المراجعة".i18n():core.feed![index]["rad"]);
                  holmm.contains("dream_aud")?(currentvoice=core.holm![index]["holm"]):currentvoice="";
                  try{
                  time=  DateFormat("yyyy/MM/dd  hh:mm:ss a").format(  DateTime.fromMillisecondsSinceEpoch(int.parse(time)));
                  }catch(e){
                    time=lst==0?core.holm![index]["time"]:core.feed![index]["time"];
                  }
                  core.ad.loadAd();
                  showDialog(context: context , builder:(BuildContext context){

                    if( holmm.contains("dream_aud")){
                      _mplaybackReady=true;
                      voice();
                    }
                    return Card(shadowColor: Colors.purpleAccent,elevation: 5,child: SingleChildScrollView(child: Column(

                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            width: width!,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.purpleAccent,
                                    offset: const Offset(
                                      5.0,
                                      5.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                ]),
                            padding: EdgeInsets.all(height! * 0.02),
                            child: Text(time,style: TextStyle(fontSize: 18),textAlign: TextAlign.center),
                          ),
                          SizedBox(height: height!*0.01,),
                          core.ad.banner,
                          SizedBox(height: height!*0.01,),
                          Container(
                            margin: EdgeInsets.all(10),
                            width: width!,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.purpleAccent,
                                    offset: const Offset(
                                      5.0,
                                      5.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                ]),
                            padding: EdgeInsets.all(height! * 0.02),
                            child: !holmm.contains("dream_aud")? Text(holmm,style: TextStyle(fontSize: 18),textAlign: TextAlign.center):
                            InkWell(
                              child: CircularCountDownTimer(
                                duration: 60,
                                initialDuration: 0,
                                controller: cont,
                                width: width! * 0.4,
                                height: width! * 0.4,
                                ringColor: Colors.grey[300]!,
                                ringGradient: null,
                                fillColor: Colors.blueAccent[100]!,
                                fillGradient: null,
                                backgroundColor: Colors.purple[400],
                                backgroundGradient: null,
                                strokeWidth: 12.0,
                                strokeCap: StrokeCap.round,
                                textStyle: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textFormat: CountdownTextFormat.S,
                                isReverse: false,
                                isReverseAnimation: false,
                                isTimerTextShown: true,
                                autoStart: false,
                                onStart: () {},
                                onComplete: () {

                                },
                                onChange: (String timeStamp) {},
                                timeFormatterFunction:
                                    (defaultFormatterFunction, duration) {
                                  if (duration.inSeconds == 0) {
                                    if (currentvoice.isNotEmpty)
                                      return 'اضغط للاستماع'.i18n();
                                    else
                                      return 'اضغط للتسجيل'.i18n();
                                  } else if (duration.inSeconds == 60) {
                                    if (currentvoice.isNotEmpty)
                                      return 'اضغط للاستماع'.i18n();
                                    else
                                      return 'اضغط للتسجيل'.i18n();
                                  } else {
                                    // return Function.apply(defaultFormatterFunction, [duration]);
                                    return 'اضغط للايقاف'.i18n();
                                  }
                                },
                              ),
                              onTap: () {
                                if (currentvoice.isNotEmpty ) {
                                  playing ? stopPlayer() : play();
                                }
                                if (cont.getTime() != '0')
                                  cont.reset();
                                else
                                  cont.start();
                              },
                            ),

                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            width: width!,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.purpleAccent,
                                    offset: const Offset(
                                      5.0,
                                      5.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                ]),
                            padding: EdgeInsets.all(height! * 0.02),
                            child:  Text(tfser,style: TextStyle(fontSize: 18),textAlign: TextAlign.center),
                          ),


                        ])),);
                  } );

                  if(lst==0){
                    if(core.holm![index]["status"]=="fnch") {
                      Map hlm = Map.of(core.holm![index]);
                      hlm['status'] = 'read';
                      try {
                        await DBProvider().updateahlamdb(
                            hlm['nb'], hlm["holm"],
                            hlm['tfser'], hlm["mode"], hlm["status"],
                            hlm["time"]);
                        await DBProvider().getdb(1);
                      } catch (E) {
                        print(E);
                      }
                    }
                  }
                  else{
                    if(core.feed![index]["status"]=="fnch"){
                      Map hlm= Map.of(core.feed![index]);
                      hlm['status']='read';
                      await DBProvider().updatefeeddb(
                          hlm['nb'], hlm["feedmessage"],
                          hlm['rad'],  hlm["status"],
                          hlm["time"]);
                      await DBProvider().getdb(2);
                    }}
                  setState(() {

                  });
                },)

            );
          },),),
        //SizedBox(height: height!*0.0325,),
      ],)

        ,onWillPop: ()async => true,),
    );
  }
  final List<String> alaka = [
    "لاتوجد علاقة", "متزوج/ة", "مطلق/ة", "ارمل/ة", "توجد علاقة"
  ],
      nw3 = ['ذكر', 'انثى'];

  String? selectalaka = 'لاتوجد علاقة', selectednaw3 = 'ذكر';

  void loginui(BuildContext context){showDialog(
      context: context,barrierDismissible: false,
      builder: (BuildContext contexts) {
        return  Material(child: WillPopScope(
            child: Container(
              height: height!,
              width: width!,
              padding: EdgeInsets.only(
                  top: height! * 0.25,
                  bottom: height! * 0.25,
                  left: width! * 0.07,
                  right: width! * 0.07),
              color: Colors.black12,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purpleAccent,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ]),
                padding: EdgeInsets.all(height! * 0.02),
                child: Column(children: [
                  Text(
                    "عليك تسجيل الدخول".i18n(),
                    style: TextStyle(fontSize: 27),
                  ),
                  SizedBox(height: height!*0.0425,),

                  ElevatedButton(
                      onPressed: () async {
                        // FirebaseAuth.instance.signOut();
                        // print(FirebaseAuth.instance.currentUser!.uid);
                        //firebase().authinit(context);
                        //firebase().googlesignin(context);
                        firebase().guestsignin(context);
                        //firebase().guesttogoogle(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.coffee_rounded,
                            size: 30,
                            color: Colors.purpleAccent,
                          ),
                          SizedBox(
                            width: width! * .035,
                          ),
                          Text(
                            "ضيف".i18n(),
                            style: TextStyle(
                                color: Colors.lightBlue, fontSize: 26),
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(120, 52),elevation:5 ,shadowColor: Colors.purpleAccent,
                        // padding: EdgeInsets.symmetric(horizontal: 16),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      )),

                  SizedBox(height: height!*0.0225,),
                  Text(
                    "او".i18n(),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: height!*0.0225,),
                  ElevatedButton(
                      onPressed: () async {
                        // FirebaseAuth.instance.signOut();
                        // print(FirebaseAuth.instance.currentUser!.uid);
                        //firebase().authinit(context);
                        loading(context);
                        if( await firebase().googlesignin(context)!=null){
                        }
                        Navigator.pop(context);
                        //firebase().guestsignin(context);
                        //firebase().guesttogoogle(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.gpp_good_sharp,
                            size: 30,
                            color: Colors.purpleAccent,
                          ),
                          SizedBox(
                            width: width! * .035,
                          ),
                          Text(
                            "جوجل".i18n(),
                            style: TextStyle(
                                color: Colors.lightBlue, fontSize: 26),
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(120, 52),elevation:5 ,shadowColor: Colors.purpleAccent,
                        // padding: EdgeInsets.symmetric(horizontal: 16),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      )),
                  SizedBox(height: height!*0.0325,),

                  Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                          text: "عبر تسجيل الدخول فانت توافق على ".i18n(),style: TextStyle(fontSize: 17,),
                          children: [
                            TextSpan(
                              text: "سياسة  الخصوصية".i18n(),style: TextStyle(fontSize: 17,color:Colors.lightBlue),recognizer: TapGestureRecognizer()..onTap = () => core.launchUrl("https://spidermbz.blogspot.com/2021/06/privacy-policy-for-www.html"),),

                            TextSpan(
                              text: " و ".i18n(),style: TextStyle(fontSize: 17,), ),

                            TextSpan(
                              text: "شروط الاستخدام".i18n(),style: TextStyle(fontSize: 17,color:Colors.lightBlue),recognizer: TapGestureRecognizer()..onTap = () => core.launchUrl("https://spidermbz.blogspot.com/2022/02/blog-post.html"), ),


                          ]
                      )
                  ),
                ]),
              ),
            ),
            onWillPop: () async => false),type: MaterialType.transparency,);
      });}
  void loading(BuildContext context){showDialog(
      context: context,barrierDismissible: false,
      builder: (BuildContext contexts) {
        return  Material(child: WillPopScope(
            child: Container(
              height: height!,
              width: width!,
              padding: EdgeInsets.only(
                  top: height! * 0.35,
                  bottom: height! * 0.35,
                  left: width! * 0.30,
                  right: width! * 0.30),
              color: Colors.black12,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purpleAccent,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ]),
                padding: EdgeInsets.all(height! * 0.02),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                    children: [


                      CircularProgressIndicator(color: Colors.purpleAccent,),
                      SizedBox(height: height!*0.0425,),

                      Text(
                        "جار التحميل".i18n(),
                        style: TextStyle(fontSize: 19,),textAlign: TextAlign.center,
                      ),
                    ]),
              ),
            ),
            onWillPop: () async => false),type: MaterialType.transparency,);
      });}

}
