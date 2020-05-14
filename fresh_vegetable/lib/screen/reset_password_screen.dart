import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freshvegetable/model/forgot_reset_password_request.dart';
import 'package:freshvegetable/model/forgot_reset_password_response.dart';
import 'package:freshvegetable/model/sign_in_request.dart';
import 'package:freshvegetable/network/change_reset_password_provider.dart';
import 'package:freshvegetable/values/colors.dart';
import 'package:freshvegetable/values/network_check.dart';
import 'package:freshvegetable/values/shared_preference_util.dart';
import 'package:freshvegetable/values/utils.dart';
import 'package:freshvegetable/values/validators.dart';

import '../routes.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}


class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  bool isLoading=false;
  TextEditingController newPasswordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: <Widget>[
              Positioned.fill(child: Container(

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
                            'Reset Password',
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
                            controller: newPasswordController,
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
                              labelText: 'New Password',
                              labelStyle: TextStyle(
                                fontSize: 16.0,
                                color: AppColors.secondaryText,
                              ),
                              hintText: 'New Password',
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
                            controller: confirmPasswordController,
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
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                fontSize: 16.0,
                                color: AppColors.secondaryText,
                              ),
                              hintText: 'Confirm Password',
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
                              if (!Validators.isValidPassword(
                                  newPasswordController.text)) {
                                toast("Password Must Be 8 Characters Long");
                              } else if (!Validators.isValidConfirmPassword(
                                  newPasswordController.text,confirmPasswordController.text)) {
                                toast("Password Does Not Match");
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
                                  'Change Password',
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
              Positioned(child: isLoading ? Container(width:double.infinity,height: double.infinity,alignment: Alignment.center,child: CircularProgressIndicator()) : Container()),
            ]
        )

    );
  }
  checkResponse(BuildContext context) async{

    String email=await SharedPreferenceUtil.getString('forgotEmail');
    setState(() {
      isLoading=true;
    });

    ForgotPasswordResetResponse result = await resetPasswordRequest(ForgotPasswordResetRequest(
        email: email,
        password: newPasswordController.text));
    setState(() {
      isLoading = false;
    });
    if (result != null) {
      if (result.result == "Password not reset") {
        print(result.result);
        toast("Password Not Reset");
      } else{
        Navigator.of(context)
            .pushReplacementNamed(Routes.signInScreenRoute);
      }
    } else {
      toast("Internal server error");
    }


  }
}
