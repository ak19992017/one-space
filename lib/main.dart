// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:one_space/constants/constants.dart';
import 'package:one_space/firebase_options.dart';
import 'package:one_space/modules/authentication/screens/signin.dart';
import 'package:one_space/modules/authentication/screens/verify.dart';
import 'package:one_space/modules/task-master/screens/task_home.dart';
import 'package:provider/provider.dart';

import 'constants/friend_provider.dart';
import 'constants/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FriendProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'One Space',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.selectedThemeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: AppColors.getMaterialColorFromColor(
            themeProvider.selectedPrimaryColor),
        primaryColor: themeProvider.selectedPrimaryColor,
        fontFamily: "Poppins",
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
          ),
          height: 35,
          padding: const EdgeInsets.all(10.0),
          textStyle: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: AppColors.getMaterialColorFromColor(
            themeProvider.selectedPrimaryColor),
        primaryColor: themeProvider.selectedPrimaryColor,
        fontFamily: "Poppins",
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: 35,
          padding: const EdgeInsets.all(10.0),
          textStyle: const TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
      home: const AuthScreenFlow(),
    );
  }
}

class AuthScreenFlow extends StatelessWidget {
  const AuthScreenFlow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        } else if (snapshot.hasData) {
          return const VerifyEmailScreen();
        } else {
          return const SignInScreen();
        }
      },
    );
  }
}
