import 'package:flutter/material.dart';
import 'package:personal_village/utility/router.dart';
import 'package:personal_village/values/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String initialAppRoute = "";

  @override
  void initState() {
    super.initState();
    //TODO: Check if user has logged in for first time. Show Onboarding widget if first time
    initialAppRoute = homeRoute;
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Add theme here
    return MaterialApp(
      initialRoute: initialAppRoute,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
    );
  }
}
