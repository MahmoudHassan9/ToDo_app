import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/extensions/validate_ex.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_dialogs.dart';
import 'package:todo_app/core/utils/constants.dart';
import 'package:todo_app/core/utils/light_app_styles.dart';
import 'package:todo_app/data/firebase_services.dart';
import 'package:todo_app/data/models/user_model.dart';
import 'package:todo_app/presentation/screens/auth/register/register.dart';
import 'package:todo_app/presentation/screens/auth/widgets/title_and_text_form_field.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/widgets/custom_button.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/widgets/custom_text_form_field.dart';
import 'package:todo_app/providers/settings_tab_provider.dart';
import 'package:todo_app/routing/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController fullNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Provider.of<SettingsTabProvider>(context).currentTheme ==
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
                    'TODO App',
                    style: LightAppStyles.appBar.copyWith(
                      fontSize: 35.sp,
                      color: AppColors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  TitleAndTextFormField(
                    fullNameController: fullNameController,
                    title: 'Full Name',
                    hint: 'Enter your full name',
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'name is required';
                      }
                      return null;
                    },
                  ),
                  TitleAndTextFormField(
                    fullNameController: phoneNumberController,
                    title: 'Phone Number',
                    hint: 'Enter your Number',
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'phone number is required';
                      }
                      return null;
                    },
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
                    title: 'Password',
                    hint: 'Enter your password',
                    isObscure: true,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'password is required';
                      }
                      return null;
                    },
                  ),
                  TitleAndTextFormField(
                    fullNameController: confirmPasswordController,
                    title: 'Confirm Password',
                    hint: 'Confirm password',
                    isObscure: true,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'confirm password is required';
                      } else if (passwordController.text != input) {
                        return "password doesn't match";
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
                      text: 'Register',
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) return;
                        await MyFireBaseServices.register(
                          context,
                          email: emailController.text,
                          password: passwordController.text,
                          name: fullNameController.text,
                          phoneNumber: phoneNumberController.text,
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        'Do you have an account ?',
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
                            AppRoutes.login,
                          );
                        },
                        child: Text(
                          'Login',
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

// Future<void> register() async {
//   if (!formKey.currentState!.validate()) return;
//   try {
//     AppDialogs.showDialogWaiting(context);
//     UserCredential credential =
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: emailController.text,
//       password: passwordController.text,
//     );
//
//     UserDM model = UserDM(
//       email: emailController.text,
//       uid: credential.user!.uid,
//       name: fullNameController.text,
//       phoneNumber: phoneNumberController.text,
//     );
//     CollectionReference usersCollection =
//         FirebaseFirestore.instance.collection(UserDM.collectionName);
//     DocumentReference usersDocuments = usersCollection.doc(model.uid);
//     usersDocuments.set(model.toJson());
//
//     if (mounted) AppDialogs.removeDialog(context);
//
//     if (mounted) {
//       AppDialogs.showMessage(
//         context,
//         message: 'Registered successfully',
//         color: Colors.green,
//       );
//     }
//   } on FirebaseAuthException catch (e) {
//     late String message;
//     if (mounted) AppDialogs.removeDialog(context);
//     if (e.code == AppConstants.weakPass) {
//       message = 'The password provided is too weak';
//     } else if (e.code == AppConstants.emailInUse) {
//       message = 'The account already exists for that email';
//     }
//
//     if (mounted) {
//       AppDialogs.showMessage(
//         context,
//         message: message,
//         color: Colors.red,
//       );
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
