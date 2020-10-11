import 'package:flutter/material.dart';
import 'package:inventory_management/Ui/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Navigation{
  static void navigateToWidget(BuildContext context,Object obj) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => obj,
    ));
  }
 static void logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => Login(),
      ),
      (Route route) => false,
    );
  }
}