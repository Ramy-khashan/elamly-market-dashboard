part of 'home_cubit.dart';


sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class GetAllDataState extends HomeState {}
final class StartGetDataState extends HomeState {}
