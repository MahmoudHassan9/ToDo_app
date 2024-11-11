import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/light_app_styles.dart';
import 'package:todo_app/providers/settings_tab_provider.dart';

class BuildSettingWidget extends StatelessWidget {
  const BuildSettingWidget({
    super.key,
    required this.text,
    required this.widget,
  });

  final String text;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 56,
        right: 37,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Provider.of<SettingsTabProvider>(context).currentTheme ==
                ThemeMode.dark
            ? AppColors.blackAccent
            : AppColors.white,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
      child: ListTile(
        title: Text(
          text,
          style: LightAppStyles.settingsTabListTileTitle,
        ),
        trailing: widget,
      ),
    );
  }
}
