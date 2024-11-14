import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket_dashboard/modules/ads/view/ad_screen.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/upload_image_firebase.dart';

import '../../../core/widgets/toast_app.dart';
import '../../../main.dart';
import '../model/ads_model.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit() : super(AdsInitial()) {
    getAds();
  }
  bool isLoading = false;
  bool isLoadingAddAds = false;
  bool isFailed = false;
  TextEditingController adTitleController = TextEditingController();
  static AdsCubit get(context) => BlocProvider.of(context);
  List<AdsModel> adsItems = [];

  late List<ExpandableColumn<dynamic>> headers;
  late List<ExpandableRow> rows;

  Future<void> getAds() async {
    adsItems = [];
    isLoading = true;
    emit(LoadingAdsState());

    await FirebaseFirestore.instance.collection("ads").get().then((value) {
      for (var element in value.docs) {
        adsItems.add(AdsModel.fromJson(element.data()));
      }
    }).whenComplete(() {
      createDataSource();

      isLoading = false;
      emit(GetAdsState());
    }).onError((error, stackTrace) {
      createDataSource();
      isFailed = true;

      isLoading = false;

      emit(FailedGetAdsState());
    });
  }

  void createDataSource() {
    headers = [
      ExpandableColumn<int>(columnTitle: "ID", columnFlex: 2),
      ExpandableColumn<Widget>(columnTitle: "Image", columnFlex: 4),
      ExpandableColumn<String>(columnTitle: "Title", columnFlex: 2),
    ];
    rows = adsItems.map<ExpandableRow>((e) {
      return ExpandableRow(cells: [
        ExpandableCell<Widget>(
            columnTitle: "ID", value: Center(child: SelectableText(e.id.toString()))),
        ExpandableCell<Widget>(
            columnTitle: "Image",
            value: Image.network(
              e.image.toString(),
              fit: BoxFit.fill,
              height: 100,
            )),
        ExpandableCell<Widget>(
            columnTitle: "Title", value: SelectableText(e.title.toString())),
      ]);
    }).toList();
  }

  final ImagePicker picker = ImagePicker();

  Uint8List? imgEncoded;
  pickAdsMainImage() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    imgEncoded = await image!.readAsBytes();

    emit(GetMainImageState());
  }

  getAnduploadImage() async {
    if (imgEncoded == null) {
      toastApp(message: "Please Select An Image");

      return "";
    }

    return await uploadImage(imgEncoded);
  }

  addAds() async {
    isLoadingAddAds = true;
    emit(LoadingAddAdState());

    String adImage = await getAnduploadImage();
    if (adImage.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("ads")
          .add({"title": adTitleController.text.trim(), "image": adImage}).then(
              (value) {
        FirebaseFirestore.instance.collection("ads").doc(value.id).update({
          "id": value.id,
        });
        isLoadingAddAds = false;
        emit(AddAdSuccessState());

        Navigator.pushReplacement(
            MarketDashboard.navigatorKey.currentContext!,
            MaterialPageRoute(
              builder: (context) => const AdScreen(),
            ));
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
        isLoadingAddAds = false;
        emit(FailedAddAdState());
        Navigator.pop(MarketDashboard.navigatorKey.currentContext!);
      });
    } else {
      isLoadingAddAds = false;
      emit(FailedAddAdState());
      toastApp(message: "Please re-select image");

      Navigator.pop(MarketDashboard.navigatorKey.currentContext!);
    }
  }
 
 
  deleteAd(int? index) {
    FirebaseFirestore.instance
        .collection("ads")
        .doc(adsItems[index!].id)
        .delete()
        .then((value) {
      toastApp(message: "Deleted Successfully");

      Navigator.pushReplacement(
          MarketDashboard.navigatorKey.currentContext!,
          MaterialPageRoute(
            builder: (context) => const AdScreen(),
          ));
    }).onError((error, stackTrace) {
      toastApp(message: "Failed to delete this ad");

      Navigator.pop(MarketDashboard.navigatorKey.currentContext!);
    });
  }
}
