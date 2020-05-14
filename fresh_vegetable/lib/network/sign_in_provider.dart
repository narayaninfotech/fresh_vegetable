import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:freshvegetable/model/sign_in_request.dart';
import 'package:freshvegetable/model/sign_in_response.dart';
import 'package:http/http.dart'as http;
Future<SignInResponse> sendRequest(SignInRequest signInRequest) async {
  final http.Response response = await http.post(
    'https://narayaninfotech.000webhostapp.com/fresh_vegetable/freshLogin.php',
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: signInRequest.toJson(),
  );
  debugPrint('sendRequest: ${response?.body}');
  return SignInResponse.fromJson(json.decode(response.body));
}

