import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:localization/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import '../core.dart' as core;
import 'firebase.dart';
import 'main.dart';
import 'package:in_app_purchase/in_app_purchase.dart';


class Deals extends StatefulWidget {

  Deals( this.exit);
  bool exit;
  deals createState() => deals(exit);


}

class deals extends State<Deals> {
 bool exit;
deals(this.exit);
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
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users");
  free(int nb) async {

    final snapshot = await ref.child('${core.uid}/point').get();
    if (snapshot.exists) {
      await ref.child('${core.uid}').update({
        "point":((snapshot.value) as int)+ nb

      });
      core.point=((snapshot.value) as int) +nb;

      firebase().updatedblocally();
    }
  }

  StreamSubscription<List<PurchaseDetails>>? _subscription;

  @override
  void initState() {
    final Stream purchaseUpdated =
        InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription?.cancel();
    }, onError: (error) {
      // handle error here.
    }) as StreamSubscription<List<PurchaseDetails>>?;
    WidgetsBinding.instance.addPostFrameCallback((_) { tst();});

    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // _showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // _handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {


          switch(purchaseDetails.productID){
            case "pack1":
              await free(30);
              break;
            case "pack2":
              await free(85);
              break;
            case "pack3":
              await free(10);
              break;
            case "pack4":
              await free(50);
              break;
            case "remove_ads":
              core.rmv=true;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool("rmv", true);
              firebase().updatedblocally();
              break;
          }



        }
        else if(purchaseDetails.status == PurchaseStatus.restored){
          if(purchaseDetails.productID.contains("ads")){
            core.rmv=true;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool("rmv", true);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance
              .completePurchase(purchaseDetails);
        }
      }
    });
  }
  List<ProductDetails> products=<ProductDetails>[];

  Future<void> tst() async {
    loading(context);

    final bool available = await InAppPurchase.instance.isAvailable();
    if (available) {
      // The store cannot be reached or accessed. Update the UI accordingly.
      InAppPurchase.instance.restorePurchases();
      const Set<String> _kIds = <String>{
        'pack1',
        'pack2',
        'pack3',
        'pack4',
        'remove_ads'
      };
      final ProductDetailsResponse response =
      await InAppPurchase.instance.queryProductDetails(_kIds);
      if (!response.notFoundIDs.isNotEmpty) {
        Navigator.pop(context);
        products = response.productDetails;
        print(products.length);
        setState(() {

        });
        /* final PurchaseParam purchaseParam = PurchaseParam(
            productDetails: products[0]);
        // if (_isConsumable(products[0].)) {
        InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
        // } else {
        //  InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
        // }
// From here the purchase flow will be handled by the underlying store.
// Updates will be delivered to the `InAppPurchase.instance.purchaseStream`.

       */
      }
    }
    else {
      Navigator.pop(context);
    }
  }


  void purchase(ProductDetails product){

    if(!product.id.contains("ads")) {
      final PurchaseParam purchaseParam = PurchaseParam(
          productDetails: product);
      // if (_isConsumable(products[0].)) {
      InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
    }
    else noadspurchase(product);
  }
  void noadspurchase(ProductDetails product){
    final PurchaseParam purchaseParam = PurchaseParam(
        productDetails: product);
    // if (_isConsumable(products[0].)) {
    InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
  }

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
                    children: [Text("المتجر".i18n(),style: TextStyle(color: Colors.white,fontSize: 26),)]),
              ),

                SizedBox(height: height! * 0.0675),
              ],
            ),
          ),
        ),
        Expanded(child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(height: 4),
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(right: 5,left: 5),
          itemCount: products.length+1,

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

                      if(index>0)...[
                        Expanded(
                          flex: 9,
                          child: Text(products[index-1].title.toString().replaceAll("(مفسر الاحلام)","").i18n(),style: TextStyle(fontSize: 16,),textAlign: TextAlign.center,),
                        ),
                        //Spacer(),
                        Expanded(
                          flex: 9,
                          child: Text(products[index-1].price.toString(),style: TextStyle(fontSize: 20,),overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                        ),]
                      else...[

                        Expanded(
                          flex: 9,
                          child: Text("الحصول على 5 نقاط عبر مشاهدة اعلان".i18n(),style: TextStyle(fontSize: 16,),textAlign: TextAlign.center,),
                        ),
                      ]
                    ],
                  ),
                ) ,onTap: () async {
                  if(index>0)
                    purchase(products[index-1]);
                  else{
                    loading(context);
                    if(core.ggl) {
                      RewardedInterstitialAd.load(
                        adUnitId: core.reward,
                        request: const AdRequest(),
                        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
                          // Called when an ad is successfully received.
                          onAdLoaded: (ad) {
                            debugPrint('$ad loaded.');
                            // Keep a reference to the ad so you can show it later.
                            Navigator.pop(context);
                            ad.show(onUserEarnedReward: (AdWithoutView ad,
                                RewardItem rewardItem) async {
                              final snapshot = await ref.child(
                                  '${core.uid}/point').get();
                              if (snapshot.exists) {
                                await ref.child('${core.uid}').update({
                                  "point": ((snapshot.value) as int) + 5
                                });
                                core.point = ((snapshot.value) as int) + 5;

                                firebase().updatedblocally();
                              }
                            });
                          },
                          // Called when an ad request failed.
                          onAdFailedToLoad: (LoadAdError error) {
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
                            onComplete: (placementId)async {
                              final snapshot = await ref.child(
                                  '${core.uid}/point').get();
                              if (snapshot.exists) {
                                await ref.child('${core.uid}').update({
                                  "point": ((snapshot.value) as int) + 5
                                });
                                core.point = ((snapshot.value) as int) + 5;

                                firebase().updatedblocally();
                              }
                            },
                            onFailed: (placementId, error, message) => print('Video Ad $placementId failed: $error $message'),
                          );},
                        onFailed: (placementId, error, message) =>  Navigator.of(context).pop(),
                      );
                    }
                  }

                },)

            );
          },),),
        SizedBox(height: height!*0.01,),
        core.ad.banner,
        SizedBox(height: height!*0.01,),
        //SizedBox(height: height!*0.0325,),
      ],)

        ,onWillPop: ()async {
        if(!exit){
        core.sel.value=0;
        return false;}
        else return true;
        },),
    );
  }
}
