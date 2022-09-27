import 'package:flutter/material.dart';
import 'package:one_space/components/button.dart';
import 'package:one_space/modules/authentication/logic/auth_manager.dart';

// ignore: unused_import
import '../../../constants/constants.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  AuthenticationManager authenticationManager = AuthenticationManager();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width > 700)
            Expanded(flex: 3, child: Container(color: Colors.black)),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forgot Password',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Provide your email and we will send you a link to reset your password',
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter a valid email'),
                            validator: (String? value) {
                              return (value!.isEmpty || !value.contains('@'))
                                  ? 'Email is not valid'
                                  : null;
                            },
                          ),
                          const SizedBox(height: 20),
                          OneButton(
                            text: 'Send recovery link',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                authenticationManager.resetPassword(context,
                                    email: emailController.text);
                              }
                            },
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black,
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Go Back'),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
