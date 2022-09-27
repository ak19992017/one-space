// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:one_space/modules/authentication/logic/auth_manager.dart';
import 'package:one_space/modules/authentication/screens/register.dart';

import '../../../components/button.dart';

import 'forget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthenticationManager authenticationManager = AuthenticationManager();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                    'Welcome back',
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
                          decoration: const InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Email is not valid';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          validator: (String? value) {
                            return (value!.isEmpty) ? 'Invalid password' : null;
                          },
                        )
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    ForgetPasswordScreen())));
                      },
                      child: const Text('Forgot Password?')),
                  SizedBox(height: 20),
                  OneButton(
                    text: 'Sign In',
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => isLoading = true);
                        authenticationManager.signInLogic(
                          context,
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        setState(() => isLoading = false);
                      }
                    },
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => RegisterScreen())));
                          },
                          child: const Text('Register'))
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
