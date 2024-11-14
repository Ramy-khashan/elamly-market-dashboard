import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket_dashboard/main.dart';
import 'package:elamlymarket_dashboard/modules/categories/view/category_screen.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/upload_image_firebase.dart';
import '../../../core/widgets/toast_app.dart';
import '../model/category_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial()) {
    getCategories();
  }
  static CategoryCubit get(context) => BlocProvider.of(context);
  bool isLoading = false;
  bool isLoadingAddCategory = false;
  bool isFailed = false;
  List<CategoryModel> categoriesItems = [];
  TextEditingController categoryTitleController = TextEditingController();
  late List<ExpandableColumn<dynamic>> headers;
  late List<ExpandableRow> rows;

  Future getCategories() async {
    isLoading = true;
    emit(LoadingCategoriesState());

    await FirebaseFirestore.instance.collection("category").get().then((value) {
      for (var element in value.docs) {
        categoriesItems.add(CategoryModel.fromJson(element.data()));
      }
    }).whenComplete(() {
      createDataSource();

      isLoading = false;
      emit(GetCategoriesState());
    }).onError((error, stackTrace) {
      createDataSource();
      isFailed = true;

      isLoading = false;

      emit(FailedGetCategoriesState());
    });
  }

  void createDataSource() {
    headers = [
      ExpandableColumn<int>(columnTitle: "ID", columnFlex: 2),
      ExpandableColumn<Widget>(columnTitle: "Image", columnFlex: 4),
      ExpandableColumn<String>(columnTitle: "Title", columnFlex: 3),
    ];

    rows = categoriesItems.map<ExpandableRow>((e) {
      return ExpandableRow(cells: [
        ExpandableCell<Widget>(
            columnTitle: "ID",
            value: Center(child: SelectableText(e.id ?? ""))),
        ExpandableCell<Widget>(
            columnTitle: "Image",
            value: Image.network(
              e.image ?? "",
              fit: BoxFit.fill,
              height: 100,
            )),
        ExpandableCell<Widget>(
            columnTitle: "Title",
            value: SelectableText(e.title ?? "Not Exist")),
      ]);
    }).toList();
  }

  editInfo({String? title, bool? isAddCategory}) {
    if (!isAddCategory!) {
      categoryTitleController.text = title ?? "Not Exist";
      emit(SetInfoState());
    }
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

  addCategory() async {
    isLoadingAddCategory = true;
    emit(LoadingAddCategoryState());

    String adImage = await getAnduploadImage();
    if (adImage.isNotEmpty) {
      await FirebaseFirestore.instance.collection("category").add({
        "title": categoryTitleController.text.trim(),
        "image": adImage
      }).then((value) {
        FirebaseFirestore.instance.collection("category").doc(value.id).update({
          "id": value.id,
        });
        isLoadingAddCategory = false;
        emit(AddCategorySuccessState());

        Navigator.pushReplacement(
            MarketDashboard.navigatorKey.currentContext!,
            MaterialPageRoute(
              builder: (context) => const CategoryScreen(),
            ));
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
        isLoadingAddCategory = false;
        emit(FailedAddCategoryState());
        Navigator.pop(MarketDashboard.navigatorKey.currentContext!);
      });
    } else {
      isLoadingAddCategory = false;
      emit(FailedAddCategoryState());
      toastApp(message: "Please re-select image");

      Navigator.pop(MarketDashboard.navigatorKey.currentContext!);
    }
  }

  editCategory({required CategoryModel category}) async {
    isLoadingAddCategory = true;
    emit(LoadingAddCategoryState());
    String adImage = "";
    if (imgEncoded != null) {
       adImage = await getAnduploadImage();
    }
   
      await FirebaseFirestore.instance
          .collection("category")
          .doc(category.id)
          .update({
        "title": categoryTitleController.text.trim(),
        "image": imgEncoded != null ? adImage : category.image
      }).then((value) {
        isLoadingAddCategory = false;
        emit(AddCategorySuccessState());

        Navigator.pushReplacement(
            MarketDashboard.navigatorKey.currentContext!,
            MaterialPageRoute(
              builder: (context) => const CategoryScreen(),
            ));
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
        isLoadingAddCategory = false;
        emit(FailedAddCategoryState());
        Navigator.pop(MarketDashboard.navigatorKey.currentContext!);
      });
    
  }
}
