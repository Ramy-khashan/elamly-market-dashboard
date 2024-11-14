part of 'report_cubit.dart';

@immutable
sealed class ReportState {}

final class ReportInitial extends ReportState {}
final class LoadingGetReportsState extends ReportState {}
final class GetReportsState extends ReportState {}
final class FailedGetReportsState extends ReportState {}
