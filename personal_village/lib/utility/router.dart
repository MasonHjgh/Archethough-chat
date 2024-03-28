import 'package:flutter/material.dart';
import 'package:personal_village/chat/view/chatpage.dart';
import 'package:personal_village/dashboard/dashboard.dart';
import 'package:personal_village/login/login.dart';
import 'package:personal_village/login/view/forgot_password.dart';
import 'package:personal_village/onboarding/view.dart';
import 'package:personal_village/ui/fallback_screen.dart';
import 'package:personal_village/values/routes.dart';

Route generateRoute(RouteSettings settings) {
  print(settings.name);
  switch (settings.name) {
    // case splashRoute:
    //   final args =
    //       (settings.arguments ?? <String, dynamic>{}) as Map<String, dynamic>;
    //   final token = args["userToken"] ?? "";
    //   return MaterialPageRoute(builder: (context) => SplashPage(token));
    case onboardingRoute:
      return MaterialPageRoute(builder: (context) => Onboarding());
    case dashboardRoute:
      return MaterialPageRoute(builder: (context) => DashboardView());

    case loginRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case forgotPasswordRoute:
      return MaterialPageRoute(builder: (context) => ForgotPasswordView());

    case ChatScreen:
      return MaterialPageRoute(
          builder: (context) => ChatScreen(recipientName: 'John'));

    default:
      return MaterialPageRoute(builder: (context) => FallbackScreen());
  }
}
