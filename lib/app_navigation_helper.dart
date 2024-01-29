library app_navigation_helper;
import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
String activeScreen="";
void push(Widget route) {

  Navigator.push(
    navKey.currentContext!,
    MaterialPageRoute(
      builder: (context) => route,
      settings: RouteSettings(name: route.toString()), // Set the route name
    ),
  );

}

Future<dynamic> pushAndReturn(Widget route) async {

  dynamic result = await Navigator.push(
      navKey.currentContext!,
      MaterialPageRoute(
        builder: (context) => route,
        settings: RouteSettings(name: route.toString()),
      ));

  return result;
}

void pushReplacement(Widget route) {
  Navigator.pushReplacement(
    navKey.currentContext!,
    MaterialPageRoute(
        builder: (context) => route,
        settings: RouteSettings(name: route.toString())),
  );
}

void pushOnTop(Widget route) {
  Navigator.pushAndRemoveUntil(
      navKey.currentContext!,
      MaterialPageRoute(
          builder: (context) => route,
          settings: RouteSettings(name: route.toString())),
      (route) => false);
}

void pop() {
  Navigator.pop(navKey.currentContext!);
}
