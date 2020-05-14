import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:freshvegetable/model/forgot_password_email_request.dart';
import 'package:freshvegetable/model/forgot_password_email_response.dart';
import 'package:freshvegetable/model/forgot_reset_password_request.dart';
import 'package:freshvegetable/model/forgot_reset_password_response.dart';
import 'package:freshvegetable/model/sign_in_request.dart';
import 'package:freshvegetable/model/sign_in_response.dart';
import 'package:http/http.dart'as http;
Future<ForgotPasswordResetResponse> resetPasswordRequest(ForgotPasswordResetRequest forgotPasswordResetRequest) async {
  final http.Response response = await http.post(
    'https://narayaninfotech.000webhostapp.com/fresh_vegetable/resetPassword.php',
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: forgotPasswordResetRequest.toJson(),
  );
  debugPrint('sendEmailRequest: ${response?.body}');
  return ForgotPasswordResetResponse.fromJson(json.decode(response.body));
}