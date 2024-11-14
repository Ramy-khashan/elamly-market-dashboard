import 'package:elamlymarket_dashboard/core/utils/validate.dart';
import 'package:elamlymarket_dashboard/core/widgets/text_field_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/utils/send_notification.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/loading_item.dart';
import '../../../../core/widgets/responsive.dart';
import '../../controller/orders_cubit.dart';

class SendNotificationDialog extends StatelessWidget {
  const SendNotificationDialog({super.key, required this.token});
  final String token;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<OrdersCubit>(context),
        child: BlocBuilder<OrdersCubit, OrdersState>(builder: (context, state) {
          final controller = OrdersCubit.get(context);
          return Container(
              alignment: Alignment.center,
              child: Form(
                key: controller.formKey,
                child: SizedBox(
                    height: Responsive.isDesktop(context) ? 600 : 300,
                    width: 400,
                    child: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Center(
                                  child: Text(
                                    "Send Notification to user",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                TextFormFieldShape(
                                    controller:
                                        controller.notificationTitleController,
                                    hint: "Notification Title",
                                    validate: (val) => Validate.notEmpty(val)),
                                TextFormFieldShape(
                                    controller:
                                        controller.notificationController,
                                    hint: "Notification Massage",
                                    validate: (val) => Validate.notEmpty(val)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ButtonsWidget(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        text: "Cancel",
                                        icon: Icons.close,
                                        backgroundColor: AppColor.primaryColor),
                                    controller.isLoadingCancelDelivery
                                        ? const LoadingItem()
                                        : ButtonsWidget(
                                            onPressed: () async {
                                              // controller.addAds();
                                              if (controller
                                                  .formKey.currentState!
                                                  .validate()) {
                                           
                                                  await sendNotificaction(
                                                      token: token,
                                                      title: controller
                                                          .notificationTitleController
                                                          .text
                                                          .trim(),
                                                      body: controller
                                                          .notificationController
                                                          .text
                                                          .trim());
                                                 
                                              }
                                            },
                                            text: "Send",
                                            icon: Icons.send,
                                            backgroundColor:
                                                AppColor.primaryColor),
                                  ],
                                )
                              ],
                            )))),
              ));
        }));
  }
}
