import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/light_app_styles.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/widgets/custom_text_form_field.dart';
import 'package:todo_app/providers/settings_tab_provider.dart';

class TitleAndTextFormField extends StatelessWidget {
  const TitleAndTextFormField({
    super.key,
    required this.fullNameController,
    required this.title,
    required this.hint,
    this.validator,
    this.isObscure = false,
  });

  final TextEditingController fullNameController;
  final String title;
  final String hint;
  final String? Function(String?)? validator;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: LightAppStyles.settingsTabLabel.copyWith(
            color: AppColors.blue,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        CustomTextFormField(
          hintText: hint,
          controller: fullNameController,
          validator: validator,
          obscureText: isObscure,
          filledColor:
          Provider.of<SettingsTabProvider>(context).currentTheme ==
              ThemeMode.dark
              ? AppColors.blackAccent
              : null,
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
