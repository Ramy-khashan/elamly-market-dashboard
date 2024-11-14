import 'package:elamlymarket_dashboard/core/utils/validate.dart';
import 'package:elamlymarket_dashboard/core/widgets/text_field_shape.dart';
import 'package:elamlymarket_dashboard/modules/deliveries/controller/deliveries_cubit.dart';
import 'package:elamlymarket_dashboard/modules/deliveries/view/deliveries_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/loading_item.dart';
import '../../model/delivery_model.dart';

class AddEditDeliveriesDialog extends StatelessWidget {
  const AddEditDeliveriesDialog(
      {super.key, this.isAdding = true, this.delivery});
  final bool isAdding;
  final DeliveryModel? delivery;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeliveriesCubit()
        ..setDeliveryInfo(delivery: delivery , isAdding: isAdding),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isAdding ? "Add Deliveries" : 'Edit Deliveries'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DeliveriesScreen()));
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: BlocBuilder<DeliveriesCubit, DeliveriesState>(
          builder: (context, state) {
            final controller = DeliveriesCubit.get(context);
            return Form(
              key: controller.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormFieldShape(
                      withPadding: true,
                      controller: controller.nameController,
                      validate: (val) => Validate.notEmpty(val),
                      hint: "Delivery Full-Name",
                    ),
                    TextFormFieldShape(
                      withPadding: true,
                      controller: controller.emailController,
                      validate: (val) => Validate.validateEmail(val),
                      hint: "Delivery Email",
                    ),
                    TextFormFieldShape(
                      withPadding: true,
                      controller: controller.phoneNumber1Controller,
                      validate: (val) => Validate.validateEgyptPhoneNumber(val),
                      hint: "Delivery Phone 1",
                    ),
                    TextFormFieldShape(
                      withPadding: true,
                      controller: controller.phoneNumber2Controller,
                      validate: (val) => val.toString().isEmpty
                          ? null
                          : Validate.validateEgyptPhoneNumber(val),
                      hint: "Delivery Phone 2",
                    ),
                    TextFormFieldShape(
                      withPadding: true,
                      controller: controller.ageController,
                      validate: (val) => Validate.notEmpty(val),
                      hint: "Delivery Age",
                    ),
                    if (isAdding)
                      TextFormFieldShape(
                        withPadding: true,
                        controller: controller.passwordController,
                        validate: (val) => Validate.validatePassword(val),
                        hint: "Delivery Password",
                      ),
                    CheckboxListTile(
                      value: controller.isActive,
                      onChanged: (bool? val) {
                        controller.chageActive(val);
                      },
                      title: const Text("Delivery account activated"),
                    ),
                    if (isAdding)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Delivery personal image"),
                            Card(
                              margin: const EdgeInsets.all(5),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: InkWell(
                                onTap: () {
                                  controller.getPersonalImage();
                                },
                                child: SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: controller.personalImage == null
                                      ? isAdding
                                          ? const Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Icon(Icons.add),
                                            )
                                          :
                                          //  category!.image!.isEmpty
                                          "".isEmpty
                                              ? const Padding(
                                                  padding: EdgeInsets.all(15),
                                                  child: Icon(Icons
                                                      .image_not_supported),
                                                )
                                              : Image.network(
                                                  "category!.image!")
                                      : Image.memory(controller.personalImage!),
                                ),
                              ),
                            ),
                            const Divider(),
                            const Text("Delivery National ID"),
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("front image"),
                                        Card(
                                          margin: const EdgeInsets.all(5),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: InkWell(
                                            onTap: () {
                                              controller
                                                  .getNationalIdFrontImage();
                                            },
                                            child: SizedBox(
                                              height: 150,
                                              width: 150,
                                              child: controller
                                                          .nationalIdFront ==
                                                      null
                                                  ? isAdding
                                                      ? const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  15),
                                                          child:
                                                              Icon(Icons.add),
                                                        )
                                                      :
                                                      //  category!.image!.isEmpty
                                                      "".isEmpty
                                                          ? const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(15),
                                                              child: Icon(Icons
                                                                  .image_not_supported),
                                                            )
                                                          : Image.network(
                                                              "category!.image!")
                                                  : Image.memory(controller
                                                      .nationalIdFront!),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Back image"),
                                        Card(
                                          margin: const EdgeInsets.all(5),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: InkWell(
                                            onTap: () {
                                              controller
                                                  .getNationalIdBackImage();
                                            },
                                            child: SizedBox(
                                              height: 150,
                                              width: 150,
                                              child: controller
                                                          .nationalIdBack ==
                                                      null
                                                  ? isAdding
                                                      ? const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  15),
                                                          child:
                                                              Icon(Icons.add),
                                                        )
                                                      :
                                                      //  category!.image!.isEmpty
                                                      "".isEmpty
                                                          ? const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(15),
                                                              child: Icon(Icons
                                                                  .image_not_supported),
                                                            )
                                                          : Image.network(
                                                              "category!.image!")
                                                  : Image.memory(controller
                                                      .nationalIdBack!),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: controller.isLoadingUpadte
                          ? const LoadingItem()
                          : ButtonsWidget(
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  isAdding
                                      ? controller.addDeliveries()
                                      : controller.editDeliveries(deliveryID: delivery!.deliveryId??"");
                                }
                              },
                              text: isAdding ? "Add Delivery" : "Edit Delivery",
                              icon: isAdding ? Icons.add : Icons.edit,
                              backgroundColor: AppColor.primaryColor),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
