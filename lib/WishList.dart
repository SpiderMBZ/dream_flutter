import 'dart:async';
import 'dart:math';

import 'package:dream/firebase.dart';
import 'package:dream/main.dart';
import 'package:elegant_notification/widgets/toast_content.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:mobile_chat_ui/custom_widgets/chat_input.dart';
import 'package:mobile_chat_ui/mobile_chat_ui.dart';
import 'package:mobile_chat_ui/models/chat_theme.dart';
import 'package:mobile_chat_ui/models/messages/message.dart';
import 'package:mobile_chat_ui/models/messages/types.dart';
import 'package:mobile_chat_ui/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core.dart' as core;

class WishList extends StatefulWidget {
  WishList({Key? key,required bool this.private,required String this.mofser}) : super(key: key);
  bool private;
  String mofser;
  _WishList createState() => _WishList(private,mofser);
}

ScrollController _scrollController=ScrollController();
ValueNotifier< int> msg =ValueNotifier(0);



class _WishList extends State< WishList>{

// Obtain shared preferences.
  SharedPreferences? prefs ;
  List<String>? blocked;


  User a=User(name: core.name, id: core.uid!=null?core.uid!:Random().nextInt(12765432).toString());


  StreamSubscription<DatabaseEvent>? datalist;
  BuildContext? _context;
  List<Message> messages =<Message>[]/* [
  TimeStampMessage(displayTime: "Today"),
  TextMessage(
      author: a,onTap: (){


  },
      time: "12:00 PM",
      text:
      "Hello house, we shall be having a brief meeting in this group tonight by 8:00pm UTC."),
  TextMessage(
      author: User(name: "vbwasdasfdsadasdasd", id: "asdsadasdw2"),
      time: "12:00 PM",
      text:
      "Hello house, we shall be having a brief meeting in this group tonight by 8:00pm UTC."),

  ActionMessage(
      author: User(name: "avbwasdasfdsadasdasd", id: "asdsadasdw2"),
      time: "now",
      text: "Victor Aniedi joined the group chat via group invite link"),
  ImageMessage(
      author:User(name: "avb3", id: "asdsadasd3"),
      time: "12:00 PM",
      imageUrl:
      "https://images.unsplash.com/photo-1493612276216-ee3925520721?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
      caption:
      "Mollit tempor ea quis laborum ipsum velit ea elit sunt nisi. Ipsum amet commodo sint magna velit in sint eu ipsum reprehenderit in incididunt sint fugiat. Consectetur sit laborum commodo cupidatat. Velit aliquip minim officia consequat. Nisi eu Lorem proident incididunt."),
  DocumentMessage(
    author: User(name: "avb4", id: "asdsadasd4"),
    time: "12:28 PM",
    documentFormat: "DOCX",
    documentSize: "32 kb",
    documentName: "Brief Project Real Estate Landing Page",
  ),
]*/;

  double? height,width;

  void loading1(BuildContext context){showDialog(
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


  _WishList(this.private,this.mofaser);
  bool private=false;String mofaser="";

  bool exit=false;
  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async{
      width=MediaQuery.of(context).size.width;
      height=MediaQuery.of(context).size.height;

      loading1(context);
      _context=context;
      prefs = await SharedPreferences.getInstance();
      blocked= prefs?.getStringList("blockedusers");
      await databaseget(_context!);

      Navigator.pop(context);
      if(private){
        core.LocalNotificationService.sendnotf("محادثة جديدة", "اضغط هنا للدخول");
        final snapshot = await ref.child('${core.uid}/point').get();
        if (snapshot.exists) {
          await ref.child('${core.uid}').update({
            "point":((snapshot.value) as int) -29

          });
          core.point=((snapshot.value) as int) -29;

          firebase().updatedblocally();
        }
        await sendmsg("${"مرحبا".i18n()} $mofaser \n ${"الجنس".i18n()}: ${core.jns}\n ${"العمر".i18n()}: ${core.omer}");
        messages.add(ActionMessage(author: User(id: "",name: ""), time:"", text:"سوف يدخل المفسر قريبا يرجى الانتظار".i18n(), ));
        (await ref.child("privatechat/${core.uid}")).onValue.listen((event) {
          try {
            if (!event.snapshot.exists&&!exit) Navigator.pop(context);
          }catch(E){}
        });
      }

    });

  }

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
        appBar: AppBar(title: Text(private?"دردشة خاصة".i18n(): "دردشة عامة".i18n()),actions: [
          if(private)
            IconButton(onPressed: (){
              showDialog(context: context, builder: (BuildContext context){return AlertDialog(elevation: 5,title: Text("هل تريد انهاء الدردشة؟".i18n() ),actions: [
                TextButton(onPressed: () async {
                  exit=true;
                  Navigator.pop(context);
                  await ref.child("privatechat/${core.uid}").remove();
                  Future.delayed(Duration(milliseconds: 200,), (){
                    Navigator.pop(core.navState.currentContext!);
                  });


                }, child: Text("متابعة".i18n(),style: TextStyle(fontSize: 19),)),
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("الغاء".i18n(),style: TextStyle(fontSize: 19),)),
              ],);});


            }, icon: Icon(Icons.logout))

        ]),

        body:WillPopScope(child: SafeArea(child:
        Stack(children: [
          ValueListenableBuilder(valueListenable: msg, builder: (BuildContext context,int,child) {
            return Chat(
              scrollController: _scrollController,
              user: a,
              messages: messages,
              showUsername: true,
              theme: DefaultChatTheme(
                userAvatarRadius: 12,
                usernameTextStyle: TextStyle(
                    color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)
                ,
                inwardMessageBackgroundColor: Colors.purple,
              ),
              showUserAvatar: true,
              input: ChatInput(onSend: (mess) {
                sendmsg(mess.text.toString());
              }),
            );
          }),
          Positioned(child:  core.ad.banner,top: 0,right: 0,left: 0,)
        ],),
          top: true,
        ),onWillPop: () async{
          if(!private){
            core.sel.value=0;
            return false;}else return true;} ,)
    );
  }
  Future<void> databaseget(BuildContext context1) async {
    // if(messages.isNotEmpty)messages.clear();

    if(!private)
      datalist==null?datalist= ref.child("chat").onChildAdded.listen((event) {


        if(event.snapshot.children.length>0) {
          final dt = event.snapshot.children.first;

          var st = dt.value.toString().split("/");

          messages.add(TextMessage(
              author: dt.key.toString() == core.uid ? a : (st[3].length <= 1
                  ? User(name: st[0], id: dt.key.toString())
                  : (!st[0].contains("bz") ? User(name: st[0],
                  id: dt.key.toString(),
                  color: Colors.green,
                  isVerified: true) : User(name: st[0],
                  id: dt.key.toString(),
                  color: Colors.red,
                  isVerified: true))),
              time: st[2],
              text:(blocked!=null&&blocked!.contains(dt.key.toString()))? "لقد قمت بحظر هذا المستخدم".i18n():st[1],
              onTap: () {
                if(dt.key.toString()!=core.uid&&st[3].length <= 1)
                  dialog(dt.key.toString());

              }

          ));

          msg.value += 1;





        }
      }):(datalist!.isPaused?datalist!.resume():print("stream  data runnnnnnn"));
    else {

      datalist == null ? datalist = ref
          .child("privatechat/${core.uid}")
          .onChildAdded
          .listen((event) {
        if (event.snapshot.children.length > 0) {
          final dt = event.snapshot.children.first;

          var st = dt.value.toString().split("/");

          messages.add(TextMessage(
              author: dt.key.toString() == core.uid ? a : (st[3].length <= 1
                  ? User(name: st[0], id: dt.key.toString())
                  : (!st[0].contains("bz") ? User(name: st[0],
                  id: dt.key.toString(),
                  color: Colors.green,
                  isVerified: true) : User(name: st[0],
                  id: dt.key.toString(),
                  color: Colors.red,
                  isVerified: true))),
              time: st[2],
              text: st[1],
              onTap: () {

              }

          ));

          msg.value += 1;

        }
      }) : (datalist!.isPaused ? datalist!.resume() : print(
          "stream  data runnnnnnn"));


    }
    if(messages.length>0){
      messages.forEach((element) {
        try{
          TextMessage b=element as TextMessage;
          b.text=(blocked!=null&&blocked!.contains(element.author!.id.toString()))?"لقد قمت بحظر هذا المستخدم".i18n(): b.text;
          try{
            element.onTap=() {
              if(element.author!.id!=core.uid&&!element.author!.isVerified)
                dialog(element.author!.id.toString());

            };
          }catch(E){

          }}catch(E){}
      });
    }
  }
  void dialog(String element){
    showDialog(context: _context!, builder: (BuildContext C) {
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
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("اختر".i18n(),style: TextStyle(fontSize: 31),),
            SizedBox(height: 30,),
            Row(mainAxisAlignment:
            MainAxisAlignment.center,
              children: [
                (blocked!=null&&blocked!.contains(element))?  TextButton(onPressed: () async {

                  try{
                    Navigator.pop(_context!);
                    loading1(_context!);
                    if(blocked!=null)blocked!.remove(element);

                    await prefs!.setStringList("blockedusers", blocked!);

                    datalist!.cancel();
                    datalist=null;
                    messages.clear();
                    blocked= prefs?.getStringList("blockedusers");
                    await databaseget(_context!);

                    Navigator.pop(_context!);
                  }catch(e){
                    print(e.toString());
                  }


                }, child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.undo,
                      size: 30,
                      color: Colors.purpleAccent,
                    ),
                    SizedBox(
                      width:10,
                    ),
                    Text(
                      "الغاء الحظر".i18n(),
                      style: TextStyle(
                          color: Colors.lightBlue, fontSize: 26),
                    )
                  ],
                ),) :TextButton(onPressed: () async {
                  try{
                    Navigator.pop(_context!);
                    loading1(_context!);
                    if(blocked!=null)blocked!.add(element);
                    else blocked=<String>[element];
                    await prefs!.setStringList("blockedusers", blocked!);

                    datalist!.cancel();
                    datalist=null;
                    messages.clear();
                    blocked= prefs?.getStringList("blockedusers");
                    await databaseget(_context!);

                    Navigator.pop(_context!);
                  }catch(e){
                    print(e.toString());
                  }

                }, child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.block,
                      size: 30,
                      color: Colors.purpleAccent,
                    ),
                    SizedBox(
                      width:10,
                    ),
                    Text(
                      "حظر".i18n(),
                      style: TextStyle(
                          color: Colors.lightBlue, fontSize: 26),
                    )
                  ],
                ),),
                SizedBox(width: 30,),

                TextButton(onPressed: (){
                  Navigator.pop(context);
                  showToast("تم ارسال الابلاغ بنجاح".i18n(),context: context,animation:StyledToastAnimation.scale,borderRadius: BorderRadius.all(Radius.circular(20)));


                }, child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.report,
                      size: 30,
                      color: Colors.purpleAccent,
                    ),
                    SizedBox(
                      width:10,
                    ),
                    Text(
                      "ابلاغ".i18n(),
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
  Future<void> sendmsg(String msg) async {
    if(!private) {
      final rt = (await ref.child("chat").get());
      if (rt.children.length > 26) {
        try {
          await ref.child("chat/${rt.children.first.key}").remove();
        } catch (e) {}
      }
      await ref.child("chat").child(ref
          .child("chat")
          .push()
          .key!).update({
        "${core.uid}": "${core.name}/$msg/${ DateFormat('hh:mm').format(
            DateTime.now().toUtc())}/"
      });
    }
    else{
      final rt = (await ref.child("privatechat/${core.uid}").get());
      if (rt.children.length > 26) {
        try {
          await ref.child("chat/${rt.children.first.key}").remove();
        } catch (e) {}
      }
      await ref.child("privatechat/${core.uid}").child(ref
          .child("privatechat/${core.uid}")
          .push()
          .key!).update({
        "${core.uid}": "${core.name}/$msg/${ DateFormat('hh:mm').format(
            DateTime.now().toUtc())}/"
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

  }
}




FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference ref = FirebaseDatabase.instance.ref("users");