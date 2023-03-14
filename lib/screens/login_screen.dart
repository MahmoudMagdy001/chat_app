// ignore_for_file: must_be_immutable, avoid_print, use_build_context_synchronously, non_constant_identifier_names, prefer_const_constructors_in_immutables, unused_local_variable

import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatScreen.id, arguments: email);
          isLoading = false;
        } else if (state is LoginError) {
          showSnakBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      child: ModalProgressHUD(
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
                            BlocProvider.of<AuthCubit>(context)
                                .loginUser(email: email!, password: password!);
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
      ),
    );
  }
}
