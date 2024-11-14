import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket_dashboard/modules/admins/model/admin_model.dart';
import 'package:elamlymarket_dashboard/modules/admins/view/admins_screen.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../view/widgets/add_edit_admin.dart';

part 'admins_state.dart';

class AdminsCubit extends Cubit<AdminsState> {
  AdminsCubit() : super(AdminsInitial());
  static AdminsCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late List<ExpandableColumn<dynamic>> headers;
  late List<ExpandableRow> rows;
  bool isLoading = false;
  List<AdminModel> admins = [];
  String? selectedRole;
  final formKey = GlobalKey<FormState>();
  getAdmins() async {
    isLoading = true;
    admins = [];
    emit(LoadinAdminState());

    FirebaseFirestore.instance.collection("admin").get().then((value) {
      for (var element in value.docs) {
        admins.add(AdminModel.fromJson(element.data()));
      }
      createDataSource();
      isLoading = false;
      emit(AdminLoadedState());
    }).onError((error, stackTrace) {
      AwesomeDialog(
              context: MarketDashboard.navigatorKey.currentContext!,
              title: "Failed to get admins",
              desc: error.toString())
          .show();
      isLoading = false;

      emit(AdminLoadErrorState());
    });
  }

  void createDataSource() {
    headers = [
      ExpandableColumn<int>(columnTitle: "ID", columnFlex: 2),
      ExpandableColumn<Widget>(columnTitle: "Name", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Email", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Role", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Edit", columnFlex: 3),
    ];

    rows = admins.map<ExpandableRow>((e) {
      return ExpandableRow(cells: [
        ExpandableCell<Widget>(
            columnTitle: "ID",
            value: Center(child: SelectableText(e.id.toString()))),
        ExpandableCell<Widget>(
            columnTitle: "Name", value: SelectableText(e.name.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Email", value: SelectableText(e.email.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Role", value: SelectableText(e.role.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Edit",
            value: ElevatedButton(
              child: const Text("Edit"),
              onPressed: () {
                showDialog(
                    context: MarketDashboard.navigatorKey.currentContext!,
                    builder: (context) => AddEditAdmin(
                          admin: e,
                          isAddProduct: false,
                        ));
              },
            )),
      ]);
    }).toList();
  }

  List<String> roles = ["admin", "data entry", "support"];
  bool isLoadingupdate = false;
  addAdmin() {
    isLoadingupdate = true;
    emit(LoadingUpdateState());
    FirebaseFirestore.instance.collection("admin").add({
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "role": selectedRole,
    }).then((value) {
      FirebaseFirestore.instance.collection("admin").doc(value.id).update({
        "id": value.id,
      });
      isLoadingupdate = false;
      emit(UpdateAdminState());

      Navigator.pushReplacement(MarketDashboard.navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => const AdminsScreen()));
    }).onError((error, stackTrace) {
      isLoadingupdate = false;
      emit(FailedUpdateAdminState());

      AwesomeDialog(
              context: MarketDashboard.navigatorKey.currentContext!,
              title: "Failed to add admin",
              desc: error.toString())
          .show();
    });
  }

  selectRole(String? val) {
    emit(AdminsInitial());
    selectedRole = val;
    emit(RoleSelectedState());
  }

  setEditValue({AdminModel? admin, required bool isEditAdmin}) {
    resetToEmpty();
    if (isEditAdmin) {
      emit(AdminsInitial());
      nameController.text = admin!.name ?? "";
      emailController.text = admin.email ?? "";
      selectedRole = admin.role;
      emit(SetAdminInfoState());
    }
    // Navigator.pushReplacement(MarketDashboard.navigatorKey.currentContext!,
    // MaterialPageRoute(builder: (context) => const AdminsScreen()));
  }

  editAdmin({AdminModel? admin}) {
    FirebaseFirestore.instance.collection("admin").doc(admin!.id).update({
      "name": nameController.text,
      "email": emailController.text,
      "role": selectedRole,
      "token":""
    }).then((value) {
      Navigator.pushReplacement(MarketDashboard.navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => const AdminsScreen()));
    }).onError((error, stackTrace) {
      AwesomeDialog(
              context: MarketDashboard.navigatorKey.currentContext!,
              title: "Failed to edit admin",
              desc: error.toString())
          .show();
    });
  }

  resetToEmpty() {
    emit(AdminsInitial());

    nameController.clear();
    emailController.clear();
    passwordController.clear();
    selectedRole = null;
    emit(ResetValueToEmptyState());
  }
}
