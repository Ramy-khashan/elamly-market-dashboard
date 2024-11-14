part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}
final class SetInfoState extends CategoryState {}
final class DeleteCategoryState extends CategoryState {}
final class StartDeleteCategoryState extends CategoryState {}
final class LoadingCategoriesState extends CategoryState {}
final class GetCategoriesState extends CategoryState {}
final class FailedGetCategoriesState extends CategoryState {}
final class LoadingAddCategoryState extends CategoryState {}
final class AddCategorySuccessState extends CategoryState {}
final class FailedAddCategoryState extends CategoryState {}
final class GetMainImageState extends CategoryState {}
