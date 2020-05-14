import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:freshvegetable/model/sign_up_request.dart';
import 'package:freshvegetable/model/sign_up_response.dart';
import 'package:http/http.dart'as http;
Future<SignUpResponse> sendRequest(SignUpRequest signUpRequest) async {
  final http.Response response = await http.post(
    'https://narayaninfotech.000webhostapp.com/fresh_vegetable/freshLoginInsert.php',
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: signUpRequest.toJson(),
  );
  debugPrint('sendRequest: ${response?.body}');
  return SignUpResponse.fromJson(json.decode(response.body));
}

