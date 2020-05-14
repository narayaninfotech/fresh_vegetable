import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshvegetable/values/colors.dart';
import 'package:freshvegetable/values/network_check.dart';
import 'package:freshvegetable/values/utils.dart';
import 'package:freshvegetable/validator.dart';
import 'package:freshvegetable/values/validators.dart';

import '../routes.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  var otp;
  ForgotPasswordOtpScreen({this.otp});
  @override
  _ForgotPasswordOtpScreenState createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  var otp;
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('received otp: ${widget.otp}');
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
                        'Enter OTP',
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
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        controller: otpController,
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
                          labelText: 'OTP',
                          labelStyle: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.secondaryText,
                          ),
                          hintText: 'OTP',
                          hintStyle: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          hideKeyboard(context);
                          if (!Validators.isValidOtp(otpController.text)) {
                            toast("Please Enter Valid OTP");
                          }
                          else if(!Validators.isMatchingOtp(otpController.text,widget.otp)){
                            toast("OTP Does Not Match");
                          }else {
                            NetworkCheck().check().then((internet) {
                              if (internet != null && internet) {
                                sendEmail(context);
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
                              'Verfiy OTP',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.accentText,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
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
                    ]),
              ),
            ))),
      ),
    ]));
  }

  sendEmail(BuildContext context) async {
//    setState(() {
//      isLoading=true;
//    });
//
//    SignInResponse result = await sendRequest(SignInRequest(
//        email: emailController.text,));
//    setState(() {
//      isLoading = false;
//    });
//    if (result != null) {
//      if (result.result == "Login unsuccessful") {
//        print(result.result);
//        toast("Login Unsuccessful");
//      } else{
//        Navigator.of(context)
//            .pushReplacementNamed(Routes.vegetabeListScreenRoute);
//      }
//    } else {
//      print("Internal server error");
//
//    }

    Navigator.of(context).pushReplacementNamed(Routes.resetPasswordScreenRoute);
  }
}
