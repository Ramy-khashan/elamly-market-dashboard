part of 'users_cubit.dart';

 sealed class UsersState {}

final class UsersInitial extends UsersState {}
final class LoadingUsersState extends UsersState {}
final class UsersLoadedState extends UsersState {}
final class UsersLoadErrorState extends UsersState {}
