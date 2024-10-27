import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../presentation/screens/home/home_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Route? router(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
    }
    return null;
  }
}
