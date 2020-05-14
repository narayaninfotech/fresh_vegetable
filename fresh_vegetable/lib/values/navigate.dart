import 'package:flutter/material.dart';

void goToPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (BuildContext context) => page),
  );
}

void navigate(BuildContext context, String route, {dynamic params}) {
  Navigator.of(context).pushNamed(route, arguments: params);
}

void replace(BuildContext context, String route, {dynamic params}) {
  Navigator.pushReplacementNamed(context, route, arguments: params);
}

void replaceRoot(BuildContext context, String route, {dynamic params}) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    route,
    (_) => false,
    arguments: params,
  );
}

void popTo(BuildContext context, String route) {
  Navigator.of(context).popUntil((r) {
    return r.isFirst || r.settings.name == route;
  });
}

void popToRoot(BuildContext context) {
  Navigator.of(context).popUntil((route) {
    return route.isFirst;
  });
}
