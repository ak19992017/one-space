// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:one_space/modules/authentication/screens/signin.dart';

import '../../../components/button.dart';

import '../../../constants/constants.dart';
import '../logic/auth_manager.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final AuthenticationManager authenticationManager = AuthenticationManager();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Register',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 25),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter a valid email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) =>
                              (value!.isEmpty || !value.contains('@'))
                                  ? 'Email is not valid'
                                  : null,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter secure password'),
                          validator: (String? value) {
                            return (value!.isEmpty) ? 'Invalid password' : null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: confirmPasswordController,
                          decoration: const InputDecoration(
                            labelText: 'Confirm password',
                            hintText: 'Repeat password',
                          ),
                          validator: (String? value) {
                            return (value!.isEmpty ||
                                    value != passwordController.text)
                                ? 'Password!=Confirm passsword'
                                : null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  OneButton(
                    text: 'Register',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        authenticationManager.registerLogic(
                          context,
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                      }
                    },
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already having an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => SignInScreen())));
                        },
                        child: const Text('Sign In'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
