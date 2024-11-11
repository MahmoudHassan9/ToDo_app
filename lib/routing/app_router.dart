import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/auth/login/login.dart';
import 'package:todo_app/presentation/screens/auth/register/register.dart';

import '../presentation/screens/home/home_screen.dart';
import 'app_routes.dart';

abstract class AppRouter {
  static Route? router(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
    }
    return null;
  }
}
