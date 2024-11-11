import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/extensions/validate_ex.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_dialogs.dart';
import 'package:todo_app/core/utils/light_app_styles.dart';
import 'package:todo_app/data/firebase_services.dart';
import 'package:todo_app/presentation/screens/auth/register/register.dart';
import 'package:todo_app/presentation/screens/auth/widgets/title_and_text_form_field.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/widgets/custom_button.dart';
import 'package:todo_app/providers/settings_tab_provider.dart';
import 'package:todo_app/routing/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<SettingsTabProvider>(context).currentTheme ==
              ThemeMode.light
          ? AppColors.white
          : AppColors.darkBlue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'TO DO \nList',
                    textAlign: TextAlign.center,
                    style: LightAppStyles.appBar.copyWith(
                      fontSize: 35.sp,
                      color: AppColors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  TitleAndTextFormField(
                    fullNameController: emailController,
                    title: 'E-mail',
                    hint: 'Enter your email',
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'email is required';
                      } else if (!input.validate) {
                        return 'email should be formatted';
                      }
                      return null;
                    },
                  ),
                  TitleAndTextFormField(
                    fullNameController: passwordController,
                    isObscure: true,
                    title: 'Password',
                    hint: 'Enter your password',
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'password is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomButton(
                      text: 'Login',
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) return;
                        await MyFireBaseServices.login(
                          context,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: TextStyle(
                          color: Provider.of<SettingsTabProvider>(context)
                                      .currentTheme ==
                                  ThemeMode.dark
                              ? AppColors.white
                              : null,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.register,
                          );
                        },
                        child: Text(
                          'Register',
                          style: LightAppStyles.settingsTabLabel.copyWith(
                            color: AppColors.blue,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// Future<void> login() async {
//   if (!formKey.currentState!.validate()) return;
//
//   try {
//     AppDialogs.showDialogWaiting(context);
//
//     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: emailController.text,
//       password: passwordController.text,
//     );
//     if (mounted) AppDialogs.removeDialog(context);
//
//     if (mounted) {
//       AppDialogs.showMessage(
//         context,
//         message: 'Login successfully',
//         color: Colors.green,
//       );
//     }
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'invalid-credential') {
//       if (mounted) {
//         AppDialogs.showMessage(
//           context,
//           message: 'email or password is incorrect',
//           color: Colors.red,
//         );
//       }
//     }
//   } catch (e) {
//     if (mounted) {
//       AppDialogs.showMessage(
//         context,
//         message: e.toString(),
//         color: Colors.red,
//       );
//     }
//   }
// }
}
