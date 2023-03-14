import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

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

  Future<void> signupUser(
      {required String email, required String password}) async {
    emit(SignupLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignupError(errorMessage: 'Weak Password'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignupError(errorMessage: 'Email Already used'));
      }
    } catch (e) {
      emit(SignupError(
          errorMessage: 'Something went error please try again later'));
    }
  }
}
