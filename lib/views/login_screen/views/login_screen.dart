import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main_screen/views/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
        ),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (String? value) {
                      const String expression = "[a-zA-Z0-9+._%-+]{1,256}"
                          "\\@"
                          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"
                          "("
                          "\\."
                          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}"
                          ")+";
                      final RegExp regExp = RegExp(expression);
                      return !regExp.hasMatch(value!)
                          ? "Please, input valid email!"
                          : null;
                    },
                    decoration: const InputDecoration(
                      label: Text('Email'),
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: true,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please, fill password field!';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      label: Text('Password'),
                      filled: true,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 46),
                  ),
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (context.mounted) {
                        await Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()),
                            (route) => false);
                      }
                    } on FirebaseAuthException catch (e) {
                      if (kDebugMode) {
                        print('e: $e.code');
                      }
                      if (e.code == 'user-not-found') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('No user found for that email.'.tr),
                          duration: const Duration(milliseconds: 1000),
                        ));
                      } else if (e.code == 'wrong-password') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                              Text('Wrong password provided for that user.'),
                          duration: Duration(milliseconds: 1000),
                        ));
                      }
                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Fill out the entire form'),
                        duration: Duration(milliseconds: 1000),
                      ));
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
