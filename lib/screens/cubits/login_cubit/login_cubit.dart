// ignore_for_file: depend_on_referenced_packages, unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginError(errorMessage: 'user not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginError(errorMessage: 'wrong password'));
      }
    } catch (e) {
      emit(LoginError(errorMessage: 'Something went wrong'));
    }
  }
}
