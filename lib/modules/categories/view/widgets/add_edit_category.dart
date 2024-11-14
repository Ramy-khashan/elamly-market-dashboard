import 'package:elamlymarket_dashboard/core/constant/app_colors.dart';
import 'package:elamlymarket_dashboard/core/widgets/buttons.dart';
import 'package:elamlymarket_dashboard/core/widgets/loading_item.dart';
import 'package:elamlymarket_dashboard/core/widgets/text_field_shape.dart';
import 'package:elamlymarket_dashboard/modules/categories/controller/category_cubit.dart';
import 'package:elamlymarket_dashboard/modules/categories/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/responsive.dart';

class AddEditCategoryDilaog extends StatelessWidget {
  const AddEditCategoryDilaog(
      {super.key, this.isAddCategory = true, this.category});
  final bool isAddCategory;
  final CategoryModel? category;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: CategoryCubit()
        ..editInfo(title: category!=null?category!.title:"", isAddCategory: false),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          final controller = CategoryCubit.get(context);
          return Container(
              alignment: Alignment.center,
              child: SizedBox(
                height: Responsive.isDesktop(context) ? 600 : 500,
                width: 400,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          isAddCategory
                              ? "Add Category Dilaog"
                              : "Edit Category Dilaog",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Category Image:",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Card(
                              margin: const EdgeInsets.all(5),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: InkWell(
                                onTap: () {
                                  controller.pickAdsMainImage();
                                },
                                child: SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: controller.imgEncoded == null
                                      ? isAddCategory
                                          ? const Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Icon(Icons.add),
                                            )
                                          : category!.image!.isEmpty
                                              ? const Padding(
                                                  padding: EdgeInsets.all(15),
                                                  child: Icon(Icons
                                                      .image_not_supported),
                                                )
                                              : Image.network(category!.image!)
                                      : Image.memory(controller.imgEncoded!),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 300,
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormFieldShape(
                              hint: "Title",
                              controller: controller.categoryTitleController,
                              validate: (val) => null),
                        ),
                        controller.isLoadingAddCategory
                            ? const LoadingItem()
                            : ButtonsWidget(
                                onPressed: () {
                                  isAddCategory
                                      ? controller.addCategory()
                                      : controller.editCategory(
                                          category: category!);
                                },
                                text: isAddCategory
                                    ? "Add Category"
                                    : "Edit Category",
                                icon: isAddCategory ? Icons.add : Icons.edit,
                                backgroundColor: AppColor.primaryColor),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
