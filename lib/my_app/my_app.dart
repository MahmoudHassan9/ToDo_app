import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/settings_tab_provider.dart';

import '../config/theme/app_theme.dart';
import '../routing/app_router.dart';
import '../routing/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsTabProvider settingsTabProvider = Provider.of(context);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MaterialApp(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: settingsTabProvider.currentTheme,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.router,
          initialRoute: AppRoutes.splash,
        );
      },
    );
  }
}
