import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket_dashboard/main.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/report_model.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());
  static ReportCubit get(context) => BlocProvider.of(context);
  List<ReportsModel> reportstems = [];

  late List<ExpandableColumn<dynamic>> headers;
  late List<ExpandableRow> rows;

  bool isLoading = false;
  Future getReports() async {
    isLoading = true;
    emit(LoadingGetReportsState());

    FirebaseFirestore.instance.collection("reports").get().then((value) {
      for (var element in value.docs) {
        ReportsModel report = ReportsModel.fromJson(element.data());
        report.id = element.id;
        reportstems.add(report);
      }
      createDataSource();
      isLoading = false;
      emit(GetReportsState());
    }).onError((error, stackTrace) {
      showDialog(
          context: MarketDashboard.navigatorKey.currentContext!,
          builder: (context) => AlertDialog(
                title: const Text(
                  "Failed",
                  style: TextStyle(fontSize: 23),
                ),
                content: SelectableText(error.toString()),
              ));
      isLoading = false;
      emit(FailedGetReportsState());
    });
  }

  void createDataSource() {
    headers = [
      ExpandableColumn<int>(columnTitle: "ID", columnFlex: 2),
      ExpandableColumn<Widget>(columnTitle: "Name", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Reporter Email", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Report Message", columnFlex: 5),
      ExpandableColumn<String>(columnTitle: "Reporter Phone", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Full Name", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Phone", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "User ID", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Action", columnFlex: 2),
    ];

    rows = reportstems.map<ExpandableRow>((e) {
      return ExpandableRow(cells: [
        ExpandableCell<Widget>(
            columnTitle: "ID",
            value: Center(child: SelectableText(e.id.toString()))),
        ExpandableCell<Widget>(
            columnTitle: "Name",
            value: SelectableText(e.reportName.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Reporter Email",
            value: SelectableText(e.email.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Report Message",
            value: SelectableText(e.report.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Reporter Phone",
            value: SelectableText(e.reportPhone.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Full Name",
            value: SelectableText(e.fullName.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Phone", value: SelectableText(e.phone.toString())),
        ExpandableCell<Widget>(
            columnTitle: "User ID", value: SelectableText(e.userId.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Action",
            value: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      copyPhone(e.reportPhone.toString());
                    },
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.call),
                    onPressed: () {
                      call(e.reportPhone.toString());
                    },
                  ),
                ],
              ),
            )),
      ]);
    }).toList();
  }

  copyPhone(String phone) {}
  call(String phone) {}
}
