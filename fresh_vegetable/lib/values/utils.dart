import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'colors.dart';

void hideKeyboard(BuildContext context) {
FocusScope.of(context).requestFocus(FocusNode());
}

void toast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.accentElement,
      textColor: AppColors.accentText,
      fontSize: 16.0
  );
}