part of 'admins_cubit.dart';

@immutable
sealed class AdminsState {}

final class AdminsInitial extends AdminsState {}
final class LoadinAdminState extends AdminsState {}
final class AdminLoadedState extends AdminsState {}
final class AdminLoadErrorState extends AdminsState {}
final class RoleSelectedState extends AdminsState {}
final class LoadingUpdateState extends AdminsState {}
final class UpdateAdminState extends AdminsState {}
final class FailedUpdateAdminState extends AdminsState {}
final class SetAdminInfoState extends AdminsState {}
final class ResetValueToEmptyState extends AdminsState {}
