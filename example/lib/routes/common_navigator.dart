import 'package:flutter/material.dart';

class CommonNavigator {
  static void navigateTo(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void navigateToAndRemoveUntil(BuildContext context, String newRouteName, RoutePredicate predicate, {Object? arguments}) {
    Navigator.pushNamedAndRemoveUntil(context, newRouteName, predicate, arguments: arguments);
  }

  static void navigateToReplacement(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static void popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }

  static void navigateBackWithResult(BuildContext context, Object result) {
    Navigator.pop(context, result);
  }
}
