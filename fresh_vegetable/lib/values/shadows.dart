/*
*  shadows.dart
*  fresh_vegetable
*
*  Created by Dhimant Desai.
*  Copyright © 2018 Narayaninfotech. All rights reserved.
    */

import 'package:flutter/rendering.dart';

class Shadows {
  static const BoxShadow primaryShadow = BoxShadow(
    color: Color.fromARGB(26, 0, 0, 0),
    offset: Offset(0, 10),
    blurRadius: 20,
  );
  static const BoxShadow secondaryShadow = BoxShadow(
    color: Color.fromARGB(13, 0, 0, 0),
    offset: Offset(0, 5),
    blurRadius: 30,
  );
}
