
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/providers/settings_tab_provider.dart';

import 'my_app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.disableNetwork();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => SettingsTabProvider()
            ..getTheme()
            ..getLanguage(),
        ),

      ],
      child: const MyApp(),
    ),
  );
}
