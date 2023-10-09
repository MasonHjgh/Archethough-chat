import 'package:flutter/material.dart';
import 'package:personal_village/screens/fallback_screen.dart';
import 'package:personal_village/screens/home.dart';
import 'package:personal_village/screens/login.dart';
import 'package:personal_village/values/routes.dart';

Route generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeRoute:
      return MaterialPageRoute(builder: (context) => Home());

    case loginRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());

    default:
      return MaterialPageRoute(builder: (context) => FallbackScreen());
  }
}
