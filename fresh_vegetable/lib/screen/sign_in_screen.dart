import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshvegetable/model/get_images.dart';
import 'package:freshvegetable/model/sign_in_response.dart';
import 'package:freshvegetable/network/images_data_provider.dart';
import 'package:freshvegetable/network/sign_in_provider.dart';
import 'package:freshvegetable/routes.dart';
import 'package:freshvegetable/values/colors.dart';
import 'package:freshvegetable/model/sign_in_request.dart';
import 'package:freshvegetable/values/network_check.dart';
import 'package:freshvegetable/values/shared_preference_util.dart';
import 'package:freshvegetable/values/utils.dart';
import 'package:freshvegetable/values/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Positioned.fill(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: AppColors.ternaryBackground,
          ),
          child: Center(
            child: SizedBox(
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.accentElement,
                      ),
                    ),
                    SizedBox(height: 80),
                    TextField(
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.secondaryText,
                      ),
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.secondaryText,
                            width: 1.0,
                          ),
                        ),
                        prefix: Padding(
                          padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                          child: Icon(
                            Icons.email,
                            size: 16,
                            color: AppColors.secondaryText,
                          ),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.secondaryText,
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      obscureText: true,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.secondaryText,
                      ),
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.secondaryText,
                            width: 1.0,
                          ),
                        ),
                        prefix: Padding(
                          padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                          child: Icon(
                            Icons.lock,
                            size: 16,
                            color: AppColors.secondaryText,
                          ),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.secondaryText,
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(Routes.forgotPasswordScreenRoute);
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    InkWell(
                      onTap: () {
                        hideKeyboard(context);
                        if (!Validators.isValidEmail(emailController.text)) {
                          toast("Please Enter Valid Email");
                        } else if (!Validators.isValidPassword(
                            passwordController.text)) {
                          toast("Password Must Be 8 Characters Long");
                        } else {
                          NetworkCheck().check().then((internet) {
                            if (internet != null && internet) {
                              checkResponse(context);
                            } else {
                              toast(
                                  'Please Check Your Internet Connection And Try Again');
                            }
                          });
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 60,
                          color: AppColors.accentElement,
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.accentText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(Routes.signUpScreenRoute);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'CREATE ACCOUNT',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
          child: isLoading
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
              : Container()),
    ]));
  }

  checkResponse(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    SignInResponse result = await sendRequest(SignInRequest(
        email: emailController.text, password: passwordController.text));
    setState(() {
      isLoading = false;
    });
    if (result != null) {
      if (result.result == "Login unsuccessful") {
        print(result.result);
        toast("Login Unsuccessful");
      } else {
       SharedPreferenceUtil.setString('email', emailController.text);
       SharedPreferenceUtil.setBool('isLogin', true);
        Navigator.of(context)
            .pushReplacementNamed(Routes.vegetabeListScreenRoute);
      }
    } else {
      print("Internal server error");
    }
  }
}
