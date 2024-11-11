import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/light_app_styles.dart';
import 'package:todo_app/providers/settings_tab_provider.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final int maxLines;
  final Color? filledColor;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.maxLines = 1,
    this.filledColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Provider.of<SettingsTabProvider>(context).currentTheme ==
                ThemeMode.light
            ? Colors.black
            : Colors.white,
      ),
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Provider.of<SettingsTabProvider>(context).currentTheme ==
                ThemeMode.light
            ? LightAppStyles.hintText
            : LightAppStyles.hintText.copyWith(
                color: Colors.white,
              ),
        fillColor: filledColor ?? Colors.grey[300],
        filled: true,
        border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
