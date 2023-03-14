// ignore_for_file: must_be_immutable, avoid_print, use_build_context_synchronously, non_constant_identifier_names, prefer_const_constructors_in_immutables, unused_local_variable

import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants/colors.dart';
import '../helper/snack_bar.dart';
import '../widgets/button.dart';
import '../widgets/custom_text_Form_filed.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'loginScreen';

  GlobalKey<FormState> formkey = GlobalKey();

  String? email, password;

  bool isLoading = false;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(
                      'images/learn.png',
                      color: Colors.white,
                      width: 250,
                    ),
                    const Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 100),
                    const Row(
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextFormField(
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please entre your e-mail';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        email = value;
                      },
                      labelText: 'E-Mail',
                    ),
                    const SizedBox(height: 10.0),
                    CustomTextFormField(
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please entre your password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        password = value;
                      },
                      labelText: 'Password',
                    ),
                    const SizedBox(height: 20.0),
                    CustomButton(
                      text: 'LOGIN',
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          isLoading = true;

                          try {
                            await loginUser();
                            Navigator.pushReplacementNamed(
                              context,
                              ChatScreen.id,
                              arguments: email,
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showSnakBar(
                                  context, 'No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              showSnakBar(
                                  context, 'Wrong password for that user.');
                            }
                          } catch (e) {
                            print(e);
                            showSnakBar(context, 'There was an error.');
                          }
                          isLoading = false;
                        } else {}
                      },
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, SignupScreen.id);
                          },
                          child: const Text(
                            '  Register',
                            style: TextStyle(
                              color: Color(
                                0xffC7EDE6,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
