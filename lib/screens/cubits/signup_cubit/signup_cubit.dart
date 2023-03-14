import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

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
