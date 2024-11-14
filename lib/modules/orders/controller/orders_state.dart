part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}
final class LoadingGetOrdersState extends OrdersState {}
final class GetOrdersState extends OrdersState {}
final class FailedGetOrdersState extends OrdersState {}
final class LoadingGetUserInfoState extends OrdersState {}
final class GetUserInfoState extends OrdersState {}
final class FailedGetUserInfoState extends OrdersState {}
final class LoadinDeliveriesState extends OrdersState {}
final class DeliveriesLoadedState extends OrdersState {}
final class DeliveriesLoadErrorState extends OrdersState {}
final class SelectedDeliveryState extends OrdersState {}
final class LoadingAssignDeliveryState extends OrdersState {}
final class SuccessAssignDeliveryState extends OrdersState {}
final class FailedAssignDeliveryState extends OrdersState {}
