import 'package:flutter/material.dart';

import 'package:freshvegetable/values/colors.dart';

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        color: AppColors.ternaryBackground,
      ),
      child: Center(
        child: Text('Not Found Screen'),
      ),
    );
  }
}
