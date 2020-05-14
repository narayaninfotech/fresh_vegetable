import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:freshvegetable/model/get_images.dart';
import 'package:http/http.dart'as http;
Future<GetImagesData> fetchImagesData() async {
  final response = await http.get('https://narayaninfotech.000webhostapp.com/fresh_vegetable/getImages.php');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body.toString());
    return GetImagesData.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}