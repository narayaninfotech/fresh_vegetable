import 'dart:convert';
import 'package:freshvegetable/model/order_request.dart';
import 'package:freshvegetable/model/order_response.dart';
import 'package:freshvegetable/screen/vegetable_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:freshvegetable/model/cart_data_request.dart';
import 'package:freshvegetable/model/cart_data_response.dart';
import 'package:http/http.dart'as http;
Future<CartDataResponse> sendCartDataRequest(CartDataRequest cartDataRequest) async {
  String username = 'rzp_test_7NoKIfUhJH8XhK';
  String password = 'vH8wuyflc238CPk2A9OWANVf';
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  print(basicAuth);

  debugPrint('cartDataRequest: ${cartDataRequest.toJson()}');
  final http.Response response = await http.post(
    'https://narayaninfotech.000webhostapp.com/fresh_vegetable/cartDataInsert.php',
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'authorization': basicAuth
    },
    body:cartDataRequest.toJson(),
  );
  debugPrint('sendCartDataRequest: ${response?.body}');
  return CartDataResponse.fromJson(json.decode(response.body));
}

Future<OrderResponse> createOrder(OrderRequest orderRequest) async {
  debugPrint('orderRequest: ${orderRequest.toJson()}');
  final http.Response response = await http.post(
    'https://api.razorpay.com/v1/orders',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization':'Basic cnpwX3Rlc3RfN05vS0lmVWhKSDhYaEs6dkg4d3V5ZmxjMjM4Q1BrMkE5T1dBTlZm',

    },
    body:json.encode(orderRequest.toJson()),
  );
  debugPrint('orderResponse: ${response?.body}');
  return OrderResponse.fromJson(json.decode(response.body));
}