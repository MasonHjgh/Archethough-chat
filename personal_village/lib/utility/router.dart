import 'package:flutter/material.dart';
import 'package:personal_village/dashboard/dashboard.dart';
import 'package:personal_village/login/login.dart';
import 'package:personal_village/login/view/chatpage.dart';
import 'package:personal_village/login/view/forgot_password.dart';
import 'package:personal_village/screens/fallback_screen.dart';
import 'package:personal_village/splash/splash.dart';
import 'package:personal_village/values/routes.dart';


Route generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashRoute:
      return MaterialPageRoute(builder: (context) => SplashPage());
    case dashboardRoute:
      return MaterialPageRoute(builder: (context) => DashboardView());

    case loginRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case forgotPasswordRoute:
      return MaterialPageRoute(builder: (context) => ForgotPasswordView());

    case  ChatScreen:
      return MaterialPageRoute(builder: (context) => ChatScreen(recipientName: 'John') );



    default:
      return MaterialPageRoute(builder: (context) => FallbackScreen());
  }
}
