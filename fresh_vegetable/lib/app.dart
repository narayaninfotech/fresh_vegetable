import 'package:flutter/material.dart';
import 'package:freshvegetable/routes.dart';
import 'package:freshvegetable/screen/cart_vegetable_list_screen.dart';
import 'package:freshvegetable/screen/change_password_screen.dart';
import 'package:freshvegetable/screen/forgot_password_otp_screen.dart';
import 'package:freshvegetable/screen/forgot_password_screen.dart';
import 'package:freshvegetable/screen/reset_password_screen.dart';
import 'package:freshvegetable/screen/not_found_screen.dart';
import 'package:freshvegetable/screen/sign_up_screen.dart';
import 'package:freshvegetable/screen/sign_in_screen.dart';

import 'package:freshvegetable/screen/splash_screen.dart';
import 'package:freshvegetable/screen/vegetable_list_screen.dart';
import 'package:freshvegetable/values/app_fonts.dart';
import 'package:freshvegetable/values/colors.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, child) {
          return MediaQuery(
            child: child,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        },
        debugShowCheckedModeBanner: false,
        title: 'Fresh Vegetable',
        theme: ThemeData(
          fontFamily: AppFonts.fontFamilyLatoBold,
          primaryColor: AppColors.primaryElement,
          primaryColorDark: AppColors.secondaryElement,
          accentColor: AppColors.accentElement,
        ),
        home: SplashScreen(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case Routes.signInScreenRoute:
              return MaterialPageRoute(builder: (_) => SignInScreen());
              break;
            case Routes.signUpScreenRoute:
              return MaterialPageRoute(builder: (_) => SignUpScreen());
              break;
            case Routes.vegetabeListScreenRoute:
              return MaterialPageRoute(builder: (_) => VegetabeListScreen());
              break;
            case Routes.cartVegetabeListScreenRoute:
              return MaterialPageRoute(builder: (_) => CartVegetabeListScreen());
              break;
            case Routes.forgotPasswordScreenRoute:
              return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
              break;
            case Routes.forgotPasswordOtpScreenRoute:
              return MaterialPageRoute(builder: (_) => ForgotPasswordOtpScreen());
              break;
            case Routes.resetPasswordScreenRoute:
              return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
              break;
            case Routes.changePasswordScreenRoute:
              return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
              break;
            default:
              return MaterialPageRoute(builder: (_) => SplashScreen());
              break;
          }
        },
        routes: <String, WidgetBuilder>{
          Routes.splashScreenRoute: (BuildContext context) => SplashScreen(),
          Routes.signInScreenRoute: (BuildContext context) => SignInScreen(),
          Routes.signUpScreenRoute: (BuildContext context) => SignUpScreen(),
          Routes.vegetabeListScreenRoute: (BuildContext context) => VegetabeListScreen(),
          Routes.cartVegetabeListScreenRoute: (BuildContext context) => CartVegetabeListScreen(),
        },
        onUnknownRoute: (RouteSettings setting) {
          //return new MaterialPageRoute(builder: (context) => SplashScreen());
          return new MaterialPageRoute(builder: (context) => NotFoundScreen());
        });
  }
}
