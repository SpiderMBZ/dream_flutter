import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import '../core.dart' as core;


class Notification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(child: Center(child: Text("لا يوجد لديك حساب مفسر".i18n())),onWillPop: () async{
          core.sel.value=0;
          return false;} ,)
    );
  }
}