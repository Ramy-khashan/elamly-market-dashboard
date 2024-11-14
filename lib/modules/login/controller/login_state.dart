part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class TogglePasswordState extends LoginState {}

final class FailedLoginState extends LoginState {}

final class SuccessLoginState extends LoginState {}

final class LoadingLoginState extends LoginState {}
