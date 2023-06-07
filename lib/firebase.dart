import 'dart:io';

import 'package:dream/Database.dart';
import 'package:dream/WishList.dart';
import 'package:dream/core.dart' as core;
import 'package:dream/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:localization/localization.dart';

class firebase{
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users");


  Future<bool> authinit(BuildContext context) async {

    bool re=false;

    if(auth?.currentUser!=null){


      try {
        await auth!.currentUser!.reload();
        core.uid=await auth.currentUser!.uid;
        re= true;

      }on FirebaseAuthException catch
      (Fire){print("aaaaaaaaaaa ${Fire.message}");
      re= false;
      }


    }
    else re=false;


    auth!.userChanges()
        .listen((User? user) async {
      if (user == null) {
        print('User is currently signed out!');
        core.uid=null;

      } else {

        print('User is signed in!   ${user.isAnonymous}   ${user.providerData}');
        core.uid=user.uid;

      }
    });
    Navigator.pop(context);
    return re;


  }
  Future<UserCredential?> guestsignin(BuildContext context) async {

    UserCredential? userCredential = await FirebaseAuth.instance.signInAnonymously();
    if(userCredential!=null)
      return userCredential;
    else return null;

  }
  Future<UserCredential?> googlesignin(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
    );
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();


      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential ? abc=
      await FirebaseAuth.instance.signInWithCredential(credential);

      return abc;
    } catch (error) {

      print(error);
    }

  }
  Future<UserCredential?> guesttogoogle(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      try {
        return await FirebaseAuth.instance.currentUser
            ?.linkWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "provider-already-linked":
            print("The provider has already been linked to the user.");
            break;
          case "invalid-credential":
            print("The provider's credential is not valid.");
            break;
          case "credential-already-in-use":
            print("The account corresponding to the credential already exists, "
                "or is already linked to a Firebase User.");
            break;
        // See the API reference for the full list of error codes.
          default:
            print("Unknown error.");
        }
      }




    } catch (error) {
      print(error);
    }

  }



  Future<void> getdatabasesinit(BuildContext context) async {
    final sp101=await ref.child("a@dmin").get();
    if(sp101.exists){
      if(sp101.child("zchat").exists) {
        if (sp101
            .child("zchat")
            .value
            .toString()
            .contains("yes"))
          core.privatechat = true;
        else if (sp101
            .child("zchat")
            .value
            .toString()
            .contains("no")) core.privatechat = false;
      }
      if(sp101.child("av2").exists){
        core.ggl=sp101.child("av2").value as bool;

      }
    }
    final sp102=await ref.child("privatechat/${core.uid}").get();
    if(sp102.exists){
      showDialog(context: core.navState.currentContext!, builder: (_)=>Material(child: Center(child: Container(
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
            Text("المحادثة الخاصة لا تزال مفتوحة يمكنك الدخول لن يتم خصم اي نقاط".i18n(),style: TextStyle(fontSize: 26),),
            SizedBox(height: 15,),
            Row(mainAxisAlignment:
            MainAxisAlignment.center,
              children: [




                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.of(core.navState.currentContext!).push(MaterialPageRoute(builder: (context)=>WishList(private: true, mofser: "  ")));
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


    }
    if(core.dbvl!=null){
      try {
        core.dbvl!.cancel();
      }catch(E){}
      core.dbvl=null;
    }
   core.dbvl= ref.child('${auth!.currentUser?.uid}').onValue.listen((event) async {
      if(event.snapshot.exists)
      for (final element in event.snapshot.children) {
        switch(element.key){
          case "name":
            core.name=element.value.toString();
            break;
          case "point":
            core.point=element.value as int;

            break;
          case "messages":
            final spmsg=await ref.child("${core.uid}/messages").get();
            spmsg.children.forEach((element2) async {
              try {
                print(core.holm!);
                Map hlm = Map(); int ele=0;
                core.holm!.forEach((elementcore) async {

                  if(elementcore['nb']==int.parse(element2.key.toString())){

                    hlm=Map.of(elementcore);
                    ele=core.holm!.indexWhere((elemento) => elemento["nb"]==elementcore['nb']);
                    hlm['tfser']=element2.value.toString();
                    hlm['status']='fnch';
                    await DBProvider().updateahlamdb(
                        int.parse(element2.key.toString()), hlm["holm"],
                        element2.value.toString(), hlm["mode"], hlm["status"],
                        hlm["time"]);
                    await ref.child("${core.uid.toString()}/messages/${element2.key.toString()}").remove();
                  }
                });



              }catch(e){
                print(e);
              }
            });

            await DBProvider().getdb(1);
            showDialog(context: core.navState.currentContext!, builder: (_)=>Material(child: Center(child: Container(
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
                  Text("لقد تم تفسير حلمك".i18n(),style: TextStyle(fontSize: 31),),
                  SizedBox(height: 15,),
                  Row(mainAxisAlignment:
                  MainAxisAlignment.center,
                    children: [




                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                        Navigator.of(core.navState.currentContext!).push(MaterialPageRoute(builder: (context)=>ahlm_feed(lst: 0)));
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


            break;
          case "messages_feed":
            final spmsg=await ref.child("${core.uid}/messages_feed").get();
            spmsg.children.forEach((element2) async {
              try {
                Map hlm = Map(); int ele=0;
                core.feed!.forEach((elementcore) async {
                  if(elementcore['nb']==int.parse(element2.key.toString())){
                    hlm=Map.of(elementcore);
                    ele=core.feed!.indexWhere((elemento) => elemento["nb"]==elementcore['nb']);
                    hlm['rad']=element2.value.toString();
                    hlm['status']='fnch';
                    await DBProvider().updatefeeddb(
                        int.parse(element2.key.toString()), hlm["feedmessage"],
                        element2.value.toString(), hlm["status"],
                        hlm["time"]);
                    await ref.child("${core.uid.toString()}/messages_feed/${element2.key.toString()}").remove();
                  }
                });


              }catch(e){
                print(e);
              }
            });


            await DBProvider().getdb(2);
            showDialog(context: core.navState.currentContext!, builder: (_)=>Material(child: Center(child: Container(
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
                  Text("لقد تم الرد على ملاحظتك".i18n(),style: TextStyle(fontSize: 31),),
                  SizedBox(height: 15,),
                  Row(mainAxisAlignment:
                  MainAxisAlignment.center,
                    children: [




                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                        Navigator.of(core.navState.currentContext!).push(MaterialPageRoute(builder: (context)=>ahlm_feed(lst: 1)));
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
            break;
      }
      }
      updatedblocally();
      await DBProvider().getdb(0);
    }, onError: (error) {
      // Error.
    });


    final snapshot = await ref.child('${auth!.currentUser?.uid}').get();
    if (snapshot.exists) {

      if(snapshot.child("point").exists){
        await DBProvider().updateadmindb(1, core.point.toString(), core.hale,core.omer, core.jns,'','','0',core.name);

      }
      if(core.name==null||(core.name!=null&&core.name!.length<1)){

      }

    } else {

      if(core.point!=null){
        await ref.update({
          "${core.uid}/point":core.point,
          "${core.uid}/name":core.name,
          "${core.uid}/uid":core.deviceid,
        });
      }




    }
    updatedblocally();
    await DBProvider().getdb(0);
  }
  Future<void> updatedblocally() async {
    await DBProvider().updateadmindb(1, core.point.toString(), core.hale,core.omer, core.jns,'','','0',core.name);
  }


  free() async {
    final snapshot = await ref.child('${auth!.currentUser?.uid}/point').get();
    if (snapshot.exists) {
      await ref.child('${auth!.currentUser?.uid}').update({
        "point":((snapshot.value) as int) +5

      });
      core.point=((snapshot.value) as int) +5;
      core.LocalNotificationService.shedul();
      updatedblocally();
    }
  }


  Future<int> checkbalance() async {
    final snapshot = await ref.child('${auth!.currentUser?.uid}/point').get();
    if (snapshot.exists) {

      core.point=((snapshot.value) as int) ;
      await updatedblocally();
      return ((snapshot.value) as int);
    }
    return 0;
  }


  Future<void> updatedb() async {
    await ref.child('${auth!.currentUser?.uid}').update(
        {
          "name":core.name,
          "uid":core.deviceid,
        }
    );
    await updatedblocally();
  }


  sendholm(String msg,int mode,String mfsr) async {
    core.mfr=<String>[];

    final mfs=await ref.child("a@dmin/zmofaser").get();
    mfs.children.forEach((element) {
      core.mfr.add(element.value.toString());
    });

    switch(mode) {
      case 0:

        await DBProvider().getdb(1);
        int nb=1;
        try {
          nb = int.parse(core.holm!.first['nb'].toString()) + 1;
        }catch(E){}
        final snapshot = await ref.child('${auth!.currentUser?.uid}/point').get();
        if (snapshot.exists) {
          await ref.child('${auth!.currentUser?.uid}').update({
            "point": ((snapshot.value) as int) - 5
          });
          core.point = ((snapshot.value) as int) - 5;

        }
        final sp2=await ref.child("admin/-1").get();

        await ref.child("admin").update({
          "-1":((sp2.value)as int)+1,
        });
        await ref.child("admin/${sp2.value.toString()}").update({
          "id":core.uid,
          "nb":nb,
          "msg":msg+"\n ver: 65",
          "jns":core.jns,
          "hale":core.hale,
          "omer":core.omer.toString(),
          "nme":"${core.name} [${DateTime.now().millisecondsSinceEpoch}]${core.contrycode}_${core.lnn} (=> ${mfsr} <=) "
        });
        await DBProvider().insertahlamdb(nb, msg, "N/A", mode, "sent", DateTime.now().millisecondsSinceEpoch.toString());
        await ref.child("leadboard").update({
          "${core.uid}":1,
        });
        await DBProvider().getdb(1);
        core.LocalNotificationService.sendnotf("حلم جديد".i18n(),"انقر للفتح".i18n());
        await updatedblocally();
        break;
      case 1:
        final storage =await  FirebaseStorage.instance.ref("voices");
        Uri file= await Uri.file("/data/user/0/com.spidermbz.dream/DreamVoice/${msg}");
        final riversRef =await storage.child(file.pathSegments.last);
        await riversRef.putFile( await File("/data/user/0/com.spidermbz.dream/DreamVoice/${msg}"));

        await DBProvider().getdb(1);
        int nb=1;
        try {
          nb = int.parse(core.holm!.first['nb'].toString()) + 1;
        }catch(E){}
        final snapshot = await ref.child('${auth!.currentUser?.uid}/point').get();
        if (snapshot.exists) {
          await ref.child('${auth!.currentUser?.uid}').update({
            "point": ((snapshot.value) as int) - 7
          });
          core.point = ((snapshot.value) as int) - 7;

        }
        final sp2=await ref.child("admin/-1").get();

        await ref.child("admin").update({
          "-1":((sp2.value)as int)+1,
        });
        await ref.child("admin/${sp2.value.toString()}").update({
          "id":core.uid,
          "nb":nb,
          "msg":msg,
          "jns":core.jns,
          "hale":core.hale,
          "omer":core.omer.toString(),
          "nme":"${core.name} [${DateTime.now().millisecondsSinceEpoch}]${core.contrycode}_${core.lnn} (=> ${mfsr} <=) "
        });
        await DBProvider().insertahlamdb(nb, msg, "N/A", mode, "sent", DateTime.now().millisecondsSinceEpoch.toString());
        await ref.child("leadboard").update({
          "${core.uid}":1,
        });
        await DBProvider().getdb(1);
        core.LocalNotificationService.sendnotf("حلم جديد".i18n(),"انقر للفتح".i18n());
        await updatedblocally();
        break;
      case -1:


        await DBProvider().getdb(2);

        int nb=1;
        try {
          nb = int.parse(core.feed!.first['nb'].toString()) + 1;
        }catch(E){}

        final sp2=await ref.child("admin/-1").get();

        await ref.child("admin").update({
          "-1":((sp2.value)as int)+1,
        });
        await ref.child("admin/${sp2.value.toString()}").update({
          "id":core.uid,
          "nb":nb,
          "msg":msg+"\n ver: 65",
          "jns":"-1",
          "hale":"-1",
          "omer":"-1",
          "nme":"${core.name} [${DateTime.now().millisecondsSinceEpoch}]${core.contrycode}_${core.lnn}"
        });
        await DBProvider().insertfeeddb(nb, msg, "N/A", "sent", DateTime.now().millisecondsSinceEpoch.toString());
        await ref.child("leadboard").update({
          "${core.uid}":1,
        });
        await DBProvider().getdb(2);
        core.LocalNotificationService.sendnotf("feed".i18n(),"انقر للفتح".i18n());
        await updatedblocally();


        break;

    }
  }

}