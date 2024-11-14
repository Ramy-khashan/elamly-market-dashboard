part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class LoadingAddProductState extends ProductState {}

final class FailedAddProductState extends ProductState {}

final class AddProductSuccessState extends ProductState {}

final class LoadingProductsState extends ProductState {}

final class GetProductsState extends ProductState {}

final class FailedGetProductsState extends ProductState {}

final class LoadingCategoriesState extends ProductState {}

final class GetCategoriesState extends ProductState {}

final class FailedGetCategoriesState extends ProductState {}

final class InitSelectCategoryState extends ProductState {}

final class SelectCategoryState extends ProductState {}

final class GetProductImageState extends ProductState {}

final class DeleteImageState extends ProductState {}

final class ChangeSalePriceState extends ProductState {}

final class StartRemoveImageState extends ProductState {}

final class RemoveImageState extends ProductState {}
