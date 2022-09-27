// ignore_for_file: unused_import, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:one_space/constants/constants.dart';
import 'package:one_space/modules/authentication/screens/verify.dart';

import '../screens/signin.dart';

class AuthenticationManager {
  void registerLogic(context,
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      showDialogMsg(context,
          title: "Register success",
          message: " ${FirebaseAuth.instance.currentUser}");

      Future.delayed(
        const Duration(seconds: 5),
        (() {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const SignInScreen())));
        }),
      );
    } on FirebaseAuthException catch (e) {
      showDialogMsg(context, title: 'Fail', message: e.code);
    } catch (e) {
      showDialogMsg(context, title: 'Fail', message: e.toString());
    }
  }

  Future signInLogic(context,
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print("SignIn success ${FirebaseAuth.instance.currentUser}");

      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => const VerifyEmailScreen())));
    } on FirebaseAuthException catch (e) {
      showDialogMsg(context, title: 'Fail', message: e.code);
    } catch (e) {
      showDialogMsg(context, title: 'Fail', message: e.toString());
    }
  }

  void signOutLogic(context) async {
    try {
      FirebaseAuth.instance.signOut();
      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => const SignInScreen())));
    } catch (e) {
      showDialogMsg(context, title: 'Fail', message: e.toString());
    }
  }

  void resetPassword(context, {required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialogMsg(context,
          title: 'Forget Password', message: "Reset link sent");
      Future.delayed(
        const Duration(seconds: 5),
        (() {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const SignInScreen())));
        }),
      );
    } catch (e) {
      showDialogMsg(context, title: 'Fail', message: e.toString());
    }
  }
}
