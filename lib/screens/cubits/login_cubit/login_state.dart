// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  String errorMessage;
  LoginError({required this.errorMessage});
}
