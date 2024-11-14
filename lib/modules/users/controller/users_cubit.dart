import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket_dashboard/main.dart';
import 'package:elamlymarket_dashboard/modules/users/view/users_screen.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/camil_case_method.dart';
import '../../../core/widgets/image_viewer.dart';
import '../model/user_model.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());
  static UsersCubit get(context) => BlocProvider.of(context);

  late List<ExpandableColumn<dynamic>> headers;
  late List<ExpandableRow> rows;
  bool isLoading = false;
  List<UsersModel> users = [];
  getUsers() async {
    isLoading = true;
    emit(LoadingUsersState());

    FirebaseFirestore.instance.collection("users").get().then((value) {
      for (var element in value.docs) {
        UsersModel user = UsersModel.fromJson(element.data());
        user.userID = element.id;
        users.add(user);
      }
      createDataSource();
      isLoading = false;
      emit(UsersLoadedState());
    }).onError((error, stackTrace) {
      AwesomeDialog(
              context: MarketDashboard.navigatorKey.currentContext!,
              title: "Failed to get users",
              desc: error.toString())
          .show();
      isLoading = false;

      emit(UsersLoadErrorState());
    });
  }

  void createDataSource() {
    headers = [
      ExpandableColumn<int>(columnTitle: "ID", columnFlex: 2),
      ExpandableColumn<Widget>(columnTitle: "Name", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Email", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Auth ID", columnFlex: 5),
      ExpandableColumn<String>(columnTitle: "Phone", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Image", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Token", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Register At", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Verification Code", columnFlex: 4),
      ExpandableColumn<String>(columnTitle: "Is Verified", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Is Active", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Active/De-Active", columnFlex: 2),
    ];

    rows = users.map<ExpandableRow>((e) {
      return ExpandableRow(cells: [
        ExpandableCell<Widget>(
            columnTitle: "ID",
            value: Center(child: SelectableText(e.userID.toString()))),
        ExpandableCell<Widget>(
            columnTitle: "Name", value: SelectableText(e.fullname.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Email", value: SelectableText(e.email.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Auth ID", value: SelectableText(e.authId.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Phone", value: SelectableText(e.phone.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Image",
            value: InkWell(
              onTap: () {
                showDialog(
                    context: MarketDashboard.navigatorKey.currentContext!,
                    builder: (context) => ImageViewer( image: e.image));
              },
              child: Image.network(
                e.image.toString(),
                width: 50,
                height: 50,
              ),
            )),
        ExpandableCell<Widget>(
            columnTitle: "Token", value: SelectableText(e.token.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Register At",
            value: Text(DateFormat("dd-EEEE MM, yyyy HH:mm a")
                .format(DateTime.parse(e.registerTime.toString())))),
        ExpandableCell<Widget>(
            columnTitle: "Verification Code",
            value: SelectableText(e.verificactionCode.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Is Verified",
            value: SelectableText(camilCaseMethod(e.isVerified.toString()),
                style: TextStyle(
                    color: e.isVerified! ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold))),
        ExpandableCell<Widget>(
            columnTitle: "Is Active",
            value: SelectableText(
              camilCaseMethod(e.isActive.toString()),
              style: TextStyle(
                  color: e.isActive! ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold),
            )),
        ExpandableCell<Widget>(
            columnTitle: "Action",
            value: ElevatedButton(
              child: Text(e.isActive! ? "De-Active" : "Active"),
              onPressed: () {
                activeToggle(userID: e.userID, isActive: e.isActive);
              },
            )),
      ]);
    }).toList();
  }

  activeToggle({String? userID, bool? isActive}) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .update({"isActive": !isActive!}).then((value) {
      Navigator.pushReplacement(MarketDashboard.navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => const UsersScreen()));
    }).onError((error, stackTrace) {
      AwesomeDialog(
              context: MarketDashboard.navigatorKey.currentContext!,
              title: "Failed to update user",
              desc: error.toString())
          .show();
    });
  }
}
