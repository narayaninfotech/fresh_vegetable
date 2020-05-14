import 'package:flutter/material.dart';
import 'package:freshvegetable/model/forgot_password_email_request.dart';
import 'package:freshvegetable/model/forgot_password_email_response.dart';
import 'package:freshvegetable/network/change_password_email_provider.dart';
import 'package:freshvegetable/screen/forgot_password_otp_screen.dart';
import 'package:freshvegetable/values/colors.dart';
import 'package:freshvegetable/values/network_check.dart';
import 'package:freshvegetable/values/shared_preference_util.dart';
import 'package:freshvegetable/values/utils.dart';
import 'package:freshvegetable/values/validators.dart';
import 'package:otp/otp.dart';

import '../routes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
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
                        'Forgot Password',
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
                      Text(
                        'Enter your email and we will send you a OTP to reset your password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.secondaryText,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      InkWell(
                        onTap: () {
                          hideKeyboard(context);
                          if (!Validators.isValidEmail(emailController.text)) {
                            toast("Please Enter Valid Email");
                          } else {
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
                              'Send Email',
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

  sendEmail(BuildContext context) async {
    var otp = OTP.generateHOTPCodeString("JBSWY3DPEHPK3PXP", 7);
    print('otp: $otp');

    setState(() {
      isLoading=true;
    });

    ForgotPasswordEmailResponse result = await sendEmailRequest(ForgotPasswordEmailRequest(
        email: emailController.text,otp: otp));
    setState(() {
      isLoading = false;
    });
    if (result != null) {
      if (result.result == "Email not sent") {
        print(result.result);
        toast("Email invalid");
      } else{
        SharedPreferenceUtil.setString('forgotEmail',emailController.text );
        Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context){
        return ForgotPasswordOtpScreen(otp: otp);
      })
    );
      }
    } else {
      toast("Internal server error");

    }

  }
}
