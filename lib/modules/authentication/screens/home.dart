// ignore_for_file: unused_import

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:one_space/components/theme_pick.dart';
import 'package:one_space/modules/task-master/screens/task_home.dart';
import 'package:provider/provider.dart';

import '../../../components/button.dart';

import '../../../constants/constants.dart';
import '../../../constants/theme_provider.dart';
import '../../chat-master/screens/chat_home.dart';
import '../logic/auth_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthenticationManager authenticationManager = AuthenticationManager();
  final user = FirebaseAuth.instance.currentUser!;
  DateTime timeBackPressed = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    bool value =
        themeProvider.selectedThemeMode == ThemeMode.light ? false : true;

    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          const snackBar = SnackBar(
            elevation: 10,
            content: Text(
              'Press back again to exit',
              style: TextStyle(fontSize: 12, fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),

            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(8),
            // backgroundColor: Theme.of(context).primaryColor,
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return false;
        } else {
          ScaffoldMessenger.of(context).clearSnackBars();
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('One Space'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(EvaIcons.pantone),
                  title: const Text('Task master'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const TaskHomeScreen())));
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(EvaIcons.messageCircleOutline),
                  title: const Text('Chat master'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const ChatHomeScreen())));
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: value
                      ? const Icon(Icons.dark_mode_outlined)
                      : const Icon(Icons.wb_sunny_outlined),
                  title: value
                      ? const Text('Dark mode')
                      : const Text('Light mode'),
                  trailing: Switch.adaptive(
                    value: value,
                    onChanged: (v) {
                      setState(() => value = v);
                      value
                          ? themeProvider.setSelectedThemeMode(ThemeMode.dark)
                          : themeProvider.setSelectedThemeMode(ThemeMode.light);
                    },
                  ),
                  onTap: () {
                    setState(() => value = !value);
                    value
                        ? themeProvider.setSelectedThemeMode(ThemeMode.dark)
                        : themeProvider.setSelectedThemeMode(ThemeMode.light);
                  },
                ),
              ),
              const ThemePicker(),
              const Spacer(),
              Text(user.email.toString()),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('LogOut'),
                  onPressed: () {
                    authenticationManager.signOutLogic(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
