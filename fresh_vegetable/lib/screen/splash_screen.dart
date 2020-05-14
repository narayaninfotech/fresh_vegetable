import 'package:flutter/material.dart';
import 'package:freshvegetable/routes.dart';
import 'package:freshvegetable/screen/sign_in_screen.dart';
import 'package:freshvegetable/screen/vegetable_list_screen.dart';
import 'package:freshvegetable/values/colors.dart';
import 'package:freshvegetable/values/shared_preference_util.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () async {
      bool isLogin = await SharedPreferenceUtil.getBool('isLogin');
      if (isLogin != null && isLogin) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => VegetabeListScreen()),
              (Route<dynamic> route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
              (Route<dynamic> route) => false,
        );
      }
    });
    return Scaffold(
      body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: AppColors.ternaryBackground,
          ),
          child: Container(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/logo.webp",
              fit: BoxFit.none,
              width: 100,
              height: 100,
            ),
          )),
    );
  }
}
