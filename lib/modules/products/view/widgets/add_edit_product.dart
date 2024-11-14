import 'package:elamlymarket_dashboard/core/constant/app_colors.dart';
import 'package:elamlymarket_dashboard/core/utils/validate.dart';
import 'package:elamlymarket_dashboard/core/widgets/buttons.dart';
import 'package:elamlymarket_dashboard/core/widgets/loading_item.dart';
import 'package:elamlymarket_dashboard/core/widgets/text_field_shape.dart';
import 'package:elamlymarket_dashboard/modules/products/view/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/responsive.dart';
import '../../../categories/model/category_model.dart';
import '../../controller/product_cubit.dart';
import '../../model/product_model.dart';

class AddEditProductDilaog extends StatelessWidget {
  const AddEditProductDilaog({
    super.key,
    this.isAddProduct = true,
    this.product,
  });
  final bool isAddProduct;
  final ProductModel? product;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()
        ..setProductValue(isAddProduct: isAddProduct, product: product),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          final controller = ProductCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                isAddProduct ? "Add Product Dilaog" : "Edit Product Dilaog",
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductScreen()));
                },
              ),
            ),
            body: Container(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 800,
                  width: Responsive.isDesktop(context) ? 1000 : 450,
                  child: Form(
                    key: controller.formKey,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text("Product Image:",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              if (!isAddProduct) const Text("Exist Image"),
                              if (!isAddProduct)
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(
                                      controller.productImageUrls.length,
                                      (index) => Stack(
                                        children: [
                                          Card(
                                            margin: const EdgeInsets.all(5),
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            child: SizedBox(
                                              height: 150,
                                              width: 150,
                                              child: Image.network(controller
                                                  .productImageUrls[index]),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                controller.deleteExistsImage(
                                                    index: index);
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              if (!isAddProduct) const Text("New Image"),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(
                                        controller.pickProductImageItem!.length,
                                        (index) => Stack(
                                          children: [
                                            Card(
                                              margin: const EdgeInsets.all(5),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              child: SizedBox(
                                                height: 150,
                                                width: 150,
                                                child: Image.memory(controller
                                                        .pickProductImageItem![
                                                    index]),
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  controller.deleteImage(
                                                      index: index);
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      margin: const EdgeInsets.all(5),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: InkWell(
                                        onTap: () {
                                          controller.pickProductImage();
                                        },
                                        child: const SizedBox(
                                          height: 150,
                                          width: 150,
                                          child: Padding(
                                            padding: EdgeInsets.all(15),
                                            child: Icon(Icons.add),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                              child: Wrap(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormFieldShape(
                                    hint: "Title",
                                    controller: controller.titleController,
                                    validate: (val) => Validate.notEmpty(val)),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormFieldShape(
                                    maxLine: 3,
                                    hint: "Description",
                                    controller:
                                        controller.desccriptionController,
                                    validate: (val) => Validate.notEmpty(val)),
                              ),
                              Container(
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: .8,
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                                child: DropdownButton(
                                  padding: const EdgeInsets.all(7),
                                  elevation: 0,
                                  underline: const SizedBox(),
                                  isExpanded: true,
                                  value: controller.selectedCategory,
                                  hint: const Text("Select a category"),
                                  onChanged: (value) {
                                    controller.selectCategory(value);
                                  },
                                  items: controller.categoriesItems
                                      .map((CategoryModel e) {
                                    return DropdownMenuItem<CategoryModel>(
                                      value: e,
                                      child: Text(e.title!),
                                    );
                                  }).toList(),
                                ),
                              ),
                              CheckboxListTile(
                                value: controller.isOnSalePrice,
                                onChanged: (bool? val) {
                                  controller.chageSale(val);
                                },
                                title: const Text("Product is on sale"),
                              ),
                              Container(
                                width: 400,
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormFieldShape(
                                    isNumber: true,
                                    hint: "Price",
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,2}')),
                                    ],
                                    controller: controller.priceController,
                                    validate: (val) => Validate.notEmpty(val)),
                              ),
                              Container(
                                width: 400,
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormFieldShape(
                                    isNumber: true,
                                    hint: "On sale price",
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,2}')),
                                    ],
                                    controller:
                                        controller.onSalePriceController,
                                    validate: (val) => Validate.notEmpty(val)),
                              ),
                              Container(
                                width: 400,
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormFieldShape(
                                    isNumber: true,
                                    hint: "Quantity",
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]")),
                                    ],
                                    controller: controller.quantityController,
                                    validate: (val) => Validate.notEmpty(val)),
                              ),
                            ],
                          )),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ButtonsWidget(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  text: "Cancel",
                                  icon: Icons.close_fullscreen_sharp,
                                  backgroundColor: AppColor.primaryColor),
                              controller.isLoadingAddProduct
                                  ? const LoadingItem()
                                  : ButtonsWidget(
                                      onPressed: () {
                                        if (controller.formKey.currentState!
                                            .validate()) {
                                          isAddProduct
                                              ? controller.addProduct()
                                              : controller.editProduct(
                                                  productID: product!.id ?? "");
                                        }
                                      },
                                      text: isAddProduct
                                          ? "Add Product"
                                          : "Edit Product",
                                      icon:
                                          isAddProduct ? Icons.add : Icons.edit,
                                      backgroundColor: AppColor.primaryColor),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
