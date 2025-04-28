part of 'auth_cubit.dart';


abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class PasswordVisibilityState extends AuthStates {}

class PasswordHiddenState extends AuthStates {}

class AuthLoaingState extends AuthStates {}

class AuthSuccessState extends AuthStates {}

class AuthErrorState extends AuthStates {
  final String errMessage;

  AuthErrorState({required this.errMessage});
}