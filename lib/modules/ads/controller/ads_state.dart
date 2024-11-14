part of 'ads_cubit.dart';

 sealed class AdsState {}

final class AdsInitial extends AdsState {}
final class SetInfoState extends AdsState {}
final class GetMainImageState extends AdsState {}
final class LoadingAdsState extends AdsState {}
final class GetAdsState extends AdsState {}
final class FailedGetAdsState extends AdsState {}
final class LoadingAddAdState extends AdsState {}
final class AddAdSuccessState extends AdsState {}
final class FailedAddAdState extends AdsState {}
 