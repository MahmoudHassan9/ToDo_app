import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_assets.dart';
import 'package:todo_app/providers/settings_tab_provider.dart';
import 'package:todo_app/routing/app_routes.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      if (context.mounted) {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.home,
        );
      }
    });
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Provider.of<SettingsTabProvider>(context).currentTheme ==
                    ThemeMode.light
                ? AppAssets.lightSplash
                : AppAssets.darkSplash,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
