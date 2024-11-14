import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/utils/validate.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/loading_item.dart';
import '../../../../core/widgets/text_field_shape.dart';
import '../../controller/admins_cubit.dart';
import '../../model/admin_model.dart';

class AddEditAdmin extends StatelessWidget {
  const AddEditAdmin({
    super.key,
    this.isAddProduct = true,
    this.admin,
  });
  final bool isAddProduct;
  final AdminModel? admin;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminsCubit>.value(
      value: BlocProvider.of<AdminsCubit>(context)
        ..setEditValue(admin: admin, isEditAdmin: !isAddProduct),
      child: BlocBuilder<AdminsCubit, AdminsState>(
        builder: (context, state) {
          final controller = AdminsCubit.get(context);
          return Container(
              alignment: Alignment.center,
              child: SizedBox(
                height: 500,
                width: 400,
                child: Card(
                  child: Form(
                    key: controller.formKey,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              isAddProduct
                                  ? "Add Admin Dilaog"
                                  : "Edit Admin Dilaog",
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SingleChildScrollView(
                                      child: Wrap(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormFieldShape(
                                            hint: "Admin Name",
                                            controller:
                                                controller.nameController,
                                            validate: (val) =>
                                                Validate.notEmpty(val)),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormFieldShape(
                                            hint: "Admin E-Mail",
                                            controller:
                                                controller.emailController,
                                            validate: (val) =>
                                                Validate.validateEmail(val)),
                                      ),
                                      if (isAddProduct)
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormFieldShape(
                                              hint: "Admin Password",
                                              controller:
                                                  controller.passwordController,
                                              validate: (val) =>
                                                  Validate.validatePassword(
                                                      val)),
                                        ),
                                      Container(
                                        margin: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: .8,
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: DropdownButton(
                                          padding: const EdgeInsets.all(7),
                                          elevation: 0,
                                          underline: const SizedBox(),
                                          isExpanded: true,
                                          value: controller.selectedRole,
                                          hint: const Text("Select a Role"),
                                          onChanged: (value) {
                                            controller.selectRole(value);
                                          },
                                          items: [
                                            "admin",
                                            "data entry",
                                            "support"
                                          ].map((String e) {
                                            return DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  )),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ButtonsWidget(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          text: "Cancel",
                                          icon: Icons.close_fullscreen_sharp,
                                          backgroundColor:
                                              AppColor.primaryColor),
                                      controller.isLoadingupdate
                                          ? const LoadingItem()
                                          : ButtonsWidget(
                                              onPressed: () {
                                                if (controller
                                                    .formKey.currentState!
                                                    .validate()) {
                                                  isAddProduct
                                                      ? controller.addAdmin()
                                                      : controller.editAdmin(
                                                          admin: admin);
                                                }
                                              },
                                              text: isAddProduct
                                                  ? "Add Admin"
                                                  : "Edit Admin",
                                              icon: isAddProduct
                                                  ? Icons.add
                                                  : Icons.edit,
                                              backgroundColor:
                                                  AppColor.primaryColor),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
