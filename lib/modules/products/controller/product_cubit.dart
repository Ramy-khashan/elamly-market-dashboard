import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket_dashboard/core/constant/storage_key.dart';
import 'package:elamlymarket_dashboard/modules/products/view/widgets/show_images.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/upload_image_firebase.dart';
import '../../../core/widgets/delete_dialog.dart';
import '../../../main.dart';
import '../../categories/model/category_model.dart';
import '../model/product_model.dart';
import '../view/product_screen.dart';
import '../view/widgets/add_edit_product.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  static ProductCubit get(context) => BlocProvider.of(context);
  List<ProductModel> productsItems = [];
  final formKey = GlobalKey<FormState>();
  final priceController = TextEditingController();
  final onSalePriceController = TextEditingController();
  final quantityController = TextEditingController();
  final titleController = TextEditingController();
  final desccriptionController = TextEditingController();
  bool isLoading = false;
  bool isLoadingAddProduct = false;
  bool isFailed = false;
  late List<ExpandableColumn<dynamic>> headers;
  late List<ExpandableRow> rows;
  bool isOnSalePrice = false;
  chageSale(val) {
    emit(ProductInitial());

    isOnSalePrice = val;
    emit(ChangeSalePriceState());
  }

  Future<void> getProducts() async {
    productsItems = [];
    isLoading = true;
    emit(LoadingProductsState());

    await FirebaseFirestore.instance.collection("products").get().then((value) {
      for (var element in value.docs) {
        productsItems.add(ProductModel.fromJson(element.data()));
      }
    }).whenComplete(() {
      createDataSource();

      isLoading = false;
      emit(GetProductsState());
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      createDataSource();
      isFailed = true;

      isLoading = false;

      emit(FailedGetProductsState());
    });
  }

  void createDataSource() {
    headers = [
      ExpandableColumn<int>(columnTitle: "ID", columnFlex: 1),
      ExpandableColumn<String>(columnTitle: "Title", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Description", columnFlex: 4),
      ExpandableColumn<String>(columnTitle: "Category", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Price", columnFlex: 1),
      ExpandableColumn<String>(columnTitle: "On Sale Price", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Is On Sale", columnFlex: 1),
      ExpandableColumn<String>(columnTitle: "Quantity", columnFlex: 1),
      ExpandableColumn<Widget>(columnTitle: "Created At", columnFlex: 2),
      ExpandableColumn<Widget>(columnTitle: "Created By", columnFlex: 2),
      ExpandableColumn<Widget>(columnTitle: "Image", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Action", columnFlex: 2),
    ];

    rows = productsItems.map<ExpandableRow>((e) {
      return ExpandableRow(cells: [
        ExpandableCell<Widget>(
            columnTitle: "ID",
            value: Center(child: SelectableText(e.id ?? ""))),
        ExpandableCell<Widget>(
            columnTitle: "Title", value: SelectableText(e.title ?? "")),
        ExpandableCell<Widget>(
            columnTitle: "Description",
            value: SelectableText(e.description ?? "")),
        ExpandableCell<Widget>(
            columnTitle: "Category",
            value: SelectableText(e.category.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Price", value: SelectableText("${e.price} L.E")),
        ExpandableCell<Widget>(
            columnTitle: "On Sale Price",
            value: SelectableText("${e.onSalePrice ?? ""} L.E")),
        ExpandableCell<Widget>(
            columnTitle: "Is On Sale",
            value: SelectableText(e.isOnSale.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Quantity",
            value: SelectableText(e.quantity.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Created At",
            value: SelectableText(DateFormat.yMMMMEEEEd()
                .format(DateTime.parse(e.createdAt.toString())))),
        ExpandableCell<Widget>(
            columnTitle: "Created By",
            value: SelectableText(e.createdBy.toString())),
        ExpandableCell<Widget>(
            columnTitle: "Image",
            value: ElevatedButton(
                onPressed: () {
                  showProductImages(images: e.images);
                },
                child: const Text("View images"))
            //  Image.network(
            //   e.image,
            //   fit: BoxFit.fill,
            //   height: 100,
            // )
            ),
        ExpandableCell<Widget>(
            columnTitle: "Action",
            value: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          MarketDashboard.navigatorKey.currentContext!,
                          MaterialPageRoute(
                              builder: (context) => AddEditProductDilaog(
                                  isAddProduct: false, product: e)));
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: MarketDashboard.navigatorKey.currentContext!,
                          builder: (context) => deleteDialog(onDelete: () {
                                deleteDialog(onDelete: () {
                                  deleteProduct(e.id ?? "");
                                });
                              }));
                    },
                    icon: const Icon(Icons.delete),
                  )
                ],
              ),
            )),
      ]);
    }).toList();
  }

  List<String> productImageUrls = [];
//! Add product
  addProduct() async {
    isLoadingAddProduct = true;
    emit(LoadingAddProductState());
    String? userEmail =
        await const FlutterSecureStorage().read(key: StorageKey.email);

    for (var element in pickProductImageItem!) {
      String url = await uploadImage(element);
      productImageUrls.add(url);
    }
    await FirebaseFirestore.instance.collection("products").add({
      "title": titleController.text.trim(),
      "description": desccriptionController.text.trim(),
      "category": selectedCategory!.title ?? "",
      "category_id": selectedCategory!.id ?? "",
      "price": priceController.text.trim(),
      "on_sale_price": onSalePriceController.text.trim(),
      "is_on_sale": isOnSalePrice,
      "quantity": quantityController.text.trim(),
      "images": productImageUrls,
      "created_at": DateTime.now().toString(),
      "created_by": userEmail,
    }).then((value) {
      FirebaseFirestore.instance.collection("products").doc(value.id).update({
        "id": value.id,
      });
      isLoadingAddProduct = false;
      emit(AddProductSuccessState());
      titleController.clear();
      desccriptionController.clear();
      quantityController.clear();
      priceController.clear();
      onSalePriceController.clear();
      selectedCategory = null;
      isOnSalePrice = false;
      pickProductImageItem = [];
      Navigator.pushReplacement(
          MarketDashboard.navigatorKey.currentContext!,
          MaterialPageRoute(
            builder: (context) => const ProductScreen(),
          ));
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      isLoadingAddProduct = false;
      emit(FailedAddProductState());
      AwesomeDialog(
          context: MarketDashboard.navigatorKey.currentContext!,
          desc: error.toString(),
          title: "Failed to add product");
    });
  }

  //! Get Categories
  List<CategoryModel> categoriesItems = [];
  CategoryModel? selectedCategory;
  Future getCategories() async {
    isLoading = true;
    categoriesItems = [];
    emit(LoadingCategoriesState());

    await FirebaseFirestore.instance.collection("category").get().then((value) {
      for (var element in value.docs) {
        categoriesItems.add(CategoryModel.fromJson(element.data()));
      }
      emit(GetCategoriesState());
    }).onError((error, stackTrace) {
      categoriesItems = [];

      emit(FailedGetCategoriesState());
    });
  }

  selectCategory(CategoryModel? value) {
    emit(InitSelectCategoryState());

    selectedCategory = value;
    emit(SelectCategoryState());
  }

  //! Produc Images
  final ImagePicker picker = ImagePicker();

  List<Uint8List>? pickProductImageItem = [];
  pickProductImage() async {
    List<XFile>? image = await picker.pickMultiImage();
    for (var element in image) {
      Uint8List imgUnit8 = await element.readAsBytes();

      pickProductImageItem!.add(imgUnit8);
    }

    emit(GetProductImageState());
  }

  deleteImage({required int index}) {
    pickProductImageItem!.removeAt(index);
    emit(DeleteImageState());
  }

  //! Edit Product

  editProduct({required String productID}) async {
    isLoadingAddProduct = true;
    emit(LoadingAddProductState());

    for (var element in pickProductImageItem!) {
      String url = await uploadImage(element);
      productImageUrls.add(url);
    }
    await FirebaseFirestore.instance
        .collection("products")
        .doc(productID)
        .update({
      "title": titleController.text.trim(),
      "description": desccriptionController.text.trim(),
      "category": selectedCategory!.title ?? "",
      "category_id": selectedCategory!.id ?? "",
      "price": priceController.text.trim(),
      "on_sale_price": onSalePriceController.text.trim(),
      "is_on_sale": isOnSalePrice,
      "quantity": quantityController.text.trim(),
      "images": productImageUrls,
    }).then((value) {
      isLoadingAddProduct = false;
      emit(AddProductSuccessState());

      Navigator.pushReplacement(
          MarketDashboard.navigatorKey.currentContext!,
          MaterialPageRoute(
            builder: (context) => const ProductScreen(),
          ));
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      isLoadingAddProduct = false;
      emit(FailedAddProductState());
      AwesomeDialog(
          context: MarketDashboard.navigatorKey.currentContext!,
          desc: error.toString(),
          title: "Failed to update product");
    });
  }

  setProductValue({required bool isAddProduct, ProductModel? product}) async {
    await getCategories();
    productImageUrls = [];
    if (!isAddProduct) {
      titleController.text = product!.title ?? "";
      desccriptionController.text = product.description ?? "";
      selectedCategory = categoriesItems
          .firstWhere((element) => element.id == product.categoryId);
      priceController.text = product.price.toString();
      onSalePriceController.text = product.onSalePrice ?? "";
      isOnSalePrice = product.isOnSale!;
      quantityController.text = product.quantity.toString();
      productImageUrls = product.images ?? [];
    }
  }

  //! Delete product
  deleteProduct(String id) async {
    await FirebaseFirestore.instance.collection("products").doc(id).delete();
    Navigator.pushReplacement(MarketDashboard.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => const ProductScreen()));
  }

  //! deletExsistImage
  deleteExistsImage({required int index}) {
    emit(StartRemoveImageState());

    productImageUrls.removeAt(index);
    emit(RemoveImageState());
  }
}
