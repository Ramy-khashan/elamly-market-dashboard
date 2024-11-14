part of 'deliveries_cubit.dart';

sealed class DeliveriesState {}

final class DeliveriesInitial extends DeliveriesState {}

final class LoadinDeliveriesState extends DeliveriesState {}

final class DeliveriesLoadedState extends DeliveriesState {}

final class DeliveriesLoadErrorState extends DeliveriesState {}

final class GetMainImageState extends DeliveriesState {}

final class ChangeActiveState extends DeliveriesState {}

final class LoadingAddingDeliveryState extends DeliveriesState {}

final class AddingDeliveryState extends DeliveriesState {}

final class FailedcAddingDeliveryState extends DeliveriesState {}
final class EditDeliveryState extends DeliveriesState {}
