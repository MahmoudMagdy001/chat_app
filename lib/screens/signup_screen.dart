// ignore_for_file: must_be_immutable, avoid_print, use_build_context_synchronously, non_constant_identifier_names, prefer_const_constructors_in_immutables, unused_local_variable

import 'package:chat_app/screens/cubits/signup_cubit/signup_cubit.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants/colors.dart';
import '../helper/snack_bar.dart';
import '../widgets/button.dart';
import '../widgets/custom_text_Form_filed.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  static String id = 'signupScreen';
  GlobalKey<FormState> formkey = GlobalKey();

  String? email;

  String? password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          isLoading = true;
        } else if (state is SignupSuccess) {
          Navigator.pushNamed(context, LoginScreen.id);
          isLoading = false;
        } else if (state is SignupError) {
          showSnakBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
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
                        const Row(
                          children: [
                            Text(
                              'SIGNUP',
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
                          text: 'SIGNUP',
                          onTap: () async {
                            if (formkey.currentState!.validate()) {
                              BlocProvider.of<SignupCubit>(context).signupUser(
                                  email: email!, password: password!);
                            } else {}
                          },
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                '  Login',
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
      },
    );
  }

  Future<void> SignupUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
