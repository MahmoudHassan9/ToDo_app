import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/utils/app_dialogs.dart';
import 'package:todo_app/core/utils/constants.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/data/models/user_model.dart';
import 'package:todo_app/routing/app_routes.dart';

abstract class MyFireBaseServices {
  static late UserDM userModel;

  static CollectionReference usersCollection =
      FirebaseFirestore.instance.collection(UserDM.collectionName);

  static Future<void> register(
    context, {
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      AppDialogs.showDialogWaiting(context);
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      userModel = UserDM(
        email: email,
        uid: credential.user!.uid,
        name: name,
        phoneNumber: phoneNumber,
      );

      DocumentReference usersDocuments = usersCollection.doc(userModel.uid);
      usersDocuments.set(userModel.toJson());

      if (context.mounted) {
        AppDialogs.removeDialog(context);
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.login,
        );
        AppDialogs.showMessage(
          context,
          message: 'Registered successfully',
          color: Colors.green,
        );
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    } on FirebaseAuthException catch (e) {
      late String message;
      if (e.code == AppConstants.weakPass) {
        message = 'The password provided is too weak';
      } else if (e.code == AppConstants.emailInUse) {
        message = 'The account already exists for that email';
      } else if (e.code == AppConstants.invalidEmail) {
        message = 'The Email addresse is badly formated';
      } else {
        message = e.toString();
      }

      if (context.mounted) {
        AppDialogs.removeDialog(context);
        AppDialogs.showMessage(
          context,
          message: message,
          color: Colors.red,
        );
      }
    } catch (e) {
      if (context.mounted) {
        AppDialogs.removeDialog(context);

        AppDialogs.showMessage(
          context,
          message: e.toString(),
          color: Colors.red,
        );
      }
    }
  }

  static Future<void> login(
    context, {
    required String email,
    required String password,
  }) async {
    try {
      AppDialogs.showDialogWaiting(context);

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      DocumentSnapshot userDoucumentSnapshot = await FirebaseFirestore.instance
          .collection(UserDM.collectionName)
          .doc(credential.user!.uid)
          .get();

      Map<String, dynamic> userJson =
          userDoucumentSnapshot.data() as Map<String, dynamic>;
      userModel = UserDM.fromJson(userJson);

      print(userModel.uid);
      if (context.mounted) AppDialogs.removeDialog(context);

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
        AppDialogs.showMessage(
          context,
          message: 'Login successfully',
          color: Colors.green,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        if (context.mounted) {
          AppDialogs.removeDialog(context);
          AppDialogs.showMessage(
            context,
            message: 'email or password is incorrect \n'
                'try again',
            color: Colors.red,
          );
        }
      } else {
        if (context.mounted) {
          AppDialogs.removeDialog(context);
          AppDialogs.showMessage(
            context,
            message: e.code.toString(),
            color: Colors.red,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        AppDialogs.removeDialog(context);
        AppDialogs.showMessage(
          context,
          message: e.toString(),
          color: Colors.red,
        );
      }
    }
  }

  static CollectionReference todosCollection = FirebaseFirestore.instance
      .collection(UserDM.collectionName)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(TodoDM.collectionName);

  static Future<void> deleteTodo({required String id}) async {
    DocumentReference documentReference = todosCollection.doc(id);
    await documentReference.delete();
  }
}
