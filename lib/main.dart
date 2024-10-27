import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/settings_tab_provider.dart';
import 'package:todo_app/routing/app_router.dart';
import 'package:todo_app/routing/app_routes.dart';

import 'my_app/my_app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => SettingsTabProvider()
        ..getTheme()
        ..getLanguage(),
      child: const MyApp(),
    ),
  );
}
