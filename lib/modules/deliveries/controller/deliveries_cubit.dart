import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket_dashboard/core/constant/storage_key.dart';
import 'package:elamlymarket_dashboard/modules/deliveries/view/deliveries_screen.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/camil_case_method.dart';
import '../../../core/utils/upload_image_firebase.dart';
import '../../../core/widgets/image_viewer.dart';
import '../../../core/widgets/toast_app.dart';
import '../../../main.dart';
import '../model/delivery_model.dart';
import '../view/widgets/add_edit_deliveries_dialog.dart';

part 'deliveries_state.dart';

class DeliveriesCubit extends Cubit<DeliveriesState> {
  DeliveriesCubit() : super(DeliveriesInitial());
  static DeliveriesCubit get(context) => BlocProvider.of(context);
  bool isLoadingUpadte = false;
  bool isActive = true;
  late List<ExpandableColumn<dynamic>> headers;
  late List<ExpandableRow> rows;
  final formKey = GlobalKey<FormState>();
  List<DeliveryModel> deliveries = [];
  bool isLoading = false;
  getDeliveries() async {
    isLoading = true;
    deliveries = [];
    emit(LoadinDeliveriesState());

    FirebaseFirestore.instance.collection("deliveries").get().then((value) {
      for (var element in value.docs) {
        deliveries.add(DeliveryModel.fromJson(element.data()));
      }
      createDataSource();
      isLoading = false;
      emit(DeliveriesLoadedState());
    }).onError((error, stackTrace) {
      AwesomeDialog(
              context: MarketDashboard.navigatorKey.currentContext!,
              title: "Failed to get deliveries",
              desc: error.toString())
          .show();
      isLoading = false;

      emit(DeliveriesLoadErrorState());
    });
  }

  void createDataSource() {
    headers = [
      ExpandableColumn<int>(columnTitle: "ID", columnFlex: 2),
      ExpandableColumn<Widget>(columnTitle: "Name", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Email", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Phone 1", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Phone 2", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Age", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Personal Img", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "ID Front Img", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "ID Back Img", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Created By", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Created At", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Is Active", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Action", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Edit", columnFlex: 3),
    ];

    rows = deliveries.map<ExpandableRow>((e) {
      return ExpandableRow(cells: [
        ExpandableCell<Widget>(
            columnTitle: "ID",
            value: Center(child: SelectableText(e.deliveryId.toString()))),
        ExpandableCell<Widget>(
            columnTitle: "Name", value: SelectableText(e.name.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Email", value: SelectableText(e.email.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Phone 1",
            value: SelectableText(e.phoneNumber1.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Phone 2",
            value: SelectableText(e.phoneNumber2.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Age", value: SelectableText(e.age.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Personal Img",
            value: InkWell(
              onTap: () {
                showDialog(
                    context: MarketDashboard.navigatorKey.currentContext!,
                    builder: (context) => ImageViewer(image: e.personalImage));
              },
              child: Image.network(
                e.personalImage.toString(),
                width: 50,
                height: 50,
              ),
            )),
        ExpandableCell<Widget>(
            columnTitle: "ID Front Img",
            value: InkWell(
              onTap: () {
                showDialog(
                    context: MarketDashboard.navigatorKey.currentContext!,
                    builder: (context) =>
                        ImageViewer(image: e.nationalIdFront));
              },
              child: Image.network(
                e.nationalIdFront.toString(),
                width: 50,
                height: 50,
              ),
            )),
        ExpandableCell<Widget>(
            columnTitle: "ID Back Img",
            value: InkWell(
              onTap: () {
                showDialog(
                    context: MarketDashboard.navigatorKey.currentContext!,
                    builder: (context) => ImageViewer(image: e.nationalIdBack));
              },
              child: Image.network(
                e.nationalIdBack.toString(),
                width: 50,
                height: 50,
              ),
            )),
        ExpandableCell<Widget>(
            columnTitle: "Created By",
            value: SelectableText(e.createdBy.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Created At",
            value: SelectableText(DateFormat("dd-EEEE  MM, yyyy - hh:mm a")
                .format(DateTime.parse(e.createdAt.toString())))),
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
                activeToggle(deliveryID: e.deliveryId, isActive: e.isActive);
              },
            )),
        ExpandableCell<Widget>(
            columnTitle: "Edit",
            value: ElevatedButton(
              child: const Text("Edit"),
              onPressed: () {
                Navigator.pushReplacement(
                    MarketDashboard.navigatorKey.currentContext!,
                    MaterialPageRoute(
                        builder: (context) => AddEditDeliveriesDialog(
                              isAdding: false,
                              delivery: e,
                            )));
                // showDialog(
                //     context: MarketDashboard.navigatorKey.currentContext!,
                //     builder: (context) => AddEditAdmin(
                //           admin: e,
                //           isAddProduct: false,
                //         ));
              },
            )),
      ]);
    }).toList();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneNumber1Controller = TextEditingController();
  TextEditingController phoneNumber2Controller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // TextEditingController nameController =   TextEditingController();
  addDeliveries() async {
    if (personalImage != null &&
        nationalIdBack != null &&
        nationalIdFront != null) {
      isLoadingUpadte = true;
      emit(LoadingAddingDeliveryState());
      String personalImageUrl = await getAnduploadImage(image: personalImage);
      String backImageUrl = await getAnduploadImage(image: nationalIdBack);
      String frontImageUrl = await getAnduploadImage(image: nationalIdFront);
      String? createdBy =
          await const FlutterSecureStorage().read(key: StorageKey.id);

      FirebaseFirestore.instance.collection("deliveries").add({
        "name": nameController.text,
        "email": emailController.text,
        "is_active": isActive,
        "password": passwordController.text,
        "national_id_front": frontImageUrl,
        "national_id_back": backImageUrl,
        "age": ageController.text,
        "phone_number1": phoneNumber1Controller.text,
        "phone_number2": phoneNumber2Controller.text,
        "created_at": DateTime.now().toString(),
        "created_by": createdBy,
        "personal_image": personalImageUrl
      }).then((value) {
        FirebaseFirestore.instance
            .collection("deliveries")
            .doc(value.id)
            .update({"delivery_id": value.id});
        isLoadingUpadte = false;
        emit(AddingDeliveryState());

        Navigator.pushReplacement(MarketDashboard.navigatorKey.currentContext!,
            MaterialPageRoute(builder: (context) => const DeliveriesScreen()));
      }).onError((error, stackTrace) {
        isLoadingUpadte = false;
        emit(FailedcAddingDeliveryState());
        AwesomeDialog(
                context: MarketDashboard.navigatorKey.currentContext!,
                title: "Failed to add delivery",
                desc: error.toString())
            .show();
      });
    } else {
      isLoadingUpadte = false;
      emit(FailedcAddingDeliveryState());

      toastApp(message: "Please Add delivery images");
    }
  }

  chageActive(val) {
    emit(DeliveriesInitial());

    isActive = val;
    emit(ChangeActiveState());
  }

  //! get Images
  final ImagePicker picker = ImagePicker();

  Uint8List? imgEncoded;
  Future<Uint8List?> pickImage() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    imgEncoded = await image!.readAsBytes();
    return imgEncoded;
  }

  getAnduploadImage({Uint8List? image}) async {
    if (image == null) {
      toastApp(message: "Please Select An Image");

      return "";
    }

    return await uploadImage(image);
  }

  Uint8List? personalImage;
  Uint8List? nationalIdFront;
  Uint8List? nationalIdBack;

  getNationalIdFrontImage() async {
    nationalIdFront = await pickImage();
    emit(GetMainImageState());
  }

  getNationalIdBackImage() async {
    nationalIdBack = await pickImage();
    emit(GetMainImageState());
  }

  getPersonalImage() async {
    personalImage = await pickImage();
    emit(GetMainImageState());
  }

  //! Edit Delivery
  setDeliveryInfo({DeliveryModel? delivery, required bool isAdding}) {
    if (!isAdding) {
      nameController.text = delivery!.name ?? "";
      emailController.text = delivery.email ?? "";
      isActive = delivery.isActive!;
      ageController.text = delivery.age!;
      phoneNumber1Controller.text = delivery.phoneNumber1!;
      phoneNumber2Controller.text = delivery.phoneNumber2!;
      // personalImage = await getImage(delivery?.personalImage);
      // nationalIdFront = await getImage(delivery?.nationalIdFront);
      // nationalIdBack = await getImage(delivery?.nationalIdBack);
      emit(EditDeliveryState());
    }
  }

  editDeliveries({required String deliveryID}) {
    isLoadingUpadte = true;
    emit(LoadingAddingDeliveryState());
    FirebaseFirestore.instance.collection("deliveries").doc(deliveryID).update({
      "name": nameController.text,
      "email": emailController.text,
      "is_active": isActive,
      "age": ageController.text,
      "phone_number1": phoneNumber1Controller.text,
      "phone_number2": phoneNumber2Controller.text,
    }).then((value) {
      isLoadingUpadte = false;
      emit(AddingDeliveryState());

      Navigator.pushReplacement(MarketDashboard.navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => const DeliveriesScreen()));
    }).onError((error, stackTrace) {
      isLoadingUpadte = false;
      emit(FailedcAddingDeliveryState());
      AwesomeDialog(
              context: MarketDashboard.navigatorKey.currentContext!,
              title: "Failed to edit delivery",
              desc: error.toString())
          .show();
    });
  }

  //! toggle activate
  activeToggle({String? deliveryID, bool? isActive}) {
    FirebaseFirestore.instance
        .collection("deliveries")
        .doc(deliveryID)
        .update({"is_active": !isActive!}).then((value) {
      Navigator.pushReplacement(MarketDashboard.navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => const DeliveriesScreen()));
    }).onError((error, stackTrace) {
      AwesomeDialog(
              context: MarketDashboard.navigatorKey.currentContext!,
              title: "Failed to update user",
              desc: error.toString())
          .show();
    });
  }
}
