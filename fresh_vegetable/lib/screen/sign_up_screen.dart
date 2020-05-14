import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshvegetable/model/sign_up_request.dart';
import 'package:freshvegetable/model/sign_up_response.dart';
import 'package:freshvegetable/network/sign_up_provider.dart';
import 'package:freshvegetable/routes.dart';
import 'package:freshvegetable/values/colors.dart';
import 'package:freshvegetable/values/network_check.dart';
import 'package:freshvegetable/values/utils.dart';
import 'package:freshvegetable/values/validators.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fullnameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool isOtpVerify = false;
  int otp=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: isOtpVerify ? Container() : Container(
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
                          'Create Account',
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.accentElement,
                          ),
                        ),
                        SizedBox(height: 40),
                        TextField(
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.secondaryText,
                          ),
                          controller: fullnameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.secondaryText,
                                width: 1.0,
                              ),
                            ),
                            prefix: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, top: 8.0),
                              child: Icon(
                                Icons.account_circle,
                                size: 16,
                                color: AppColors.secondaryText,
                              ),
                            ),
                            labelText: 'Full Name',
                            labelStyle: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.secondaryText,
                            ),
                            hintText: 'Full Name',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
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
                              padding:
                                  const EdgeInsets.only(right: 8.0, top: 8.0),
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
                              padding:
                                  const EdgeInsets.only(right: 8.0, top: 8.0),
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
                        SizedBox(height: 40),
                        InkWell(
                          onTap: () {
                            hideKeyboard(context);
                            if (!Validators.isValidFullName(
                                fullnameController.text)) {
                              toast("Please Enter Fullname");
                            } else if (!Validators.isValidEmail(
                                emailController.text)) {
                              toast("Please Enter Valid Email");
                            } else if (!Validators.isValidPassword(
                                passwordController.text)) {
                              toast("Password Must Be 8 Characters Long");
                            } else {
                              otp = 10;
                              isOtpVerify = true;
//                              NetworkCheck().check().then((internet) {
//                                if (internet != null && internet) {
//                                  checkResponse(context);
//                                } else {
//                                  toast(
//                                      'Please Check Your Internet Connection And Try Again');
//                                }
//                              });
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
                                'CREATE ACCOUNT',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.accentText,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.secondaryText,
                            ),
                          ),
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
        ],
      ),
    );
  }

  checkResponse(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    SignUpResponse result = await sendRequest(SignUpRequest(
        fullname: fullnameController.text,
        email: emailController.text,
        password: passwordController.text));
    setState(() {
      isLoading = false;
    });
    if (result != null) {
      if (result.result == "Email already registered") {
        print(result.result);
        toast("Email Already Registered");
      } else if (result.result == "Account created") {
        Navigator.of(context)
            .pushReplacementNamed(Routes.signInScreenRoute);
      } else {
        print("Account not created");
        toast("Account Not Created");
      }
    } else {
      print("Internal server error");
    }
  }
}
