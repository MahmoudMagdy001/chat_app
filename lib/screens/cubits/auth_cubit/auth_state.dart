part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}


class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginError extends AuthState {
  String errorMessage;
  LoginError({required this.errorMessage});
}
class SignupLoading extends AuthState {}

class SignupSuccess extends AuthState {}

class SignupError extends AuthState {
  String errorMessage;
  SignupError({required this.errorMessage});
}

