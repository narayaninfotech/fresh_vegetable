import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:freshvegetable/model/forgot_password_email_request.dart';
import 'package:freshvegetable/model/forgot_password_email_response.dart';
import 'package:freshvegetable/model/sign_in_request.dart';
import 'package:freshvegetable/model/sign_in_response.dart';
import 'package:http/http.dart'as http;
Future<ForgotPasswordEmailResponse> sendEmailRequest(ForgotPasswordEmailRequest forgotPasswordEmailRequest) async {
  final http.Response response = await http.post(
    'https://narayaninfotech.000webhostapp.com/fresh_vegetable/changePasswordEmail.php',
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: forgotPasswordEmailRequest.toJson(),
  );
  debugPrint('sendEmailRequest: ${response?.body}');
  return ForgotPasswordEmailResponse.fromJson(json.decode(response.body));
}