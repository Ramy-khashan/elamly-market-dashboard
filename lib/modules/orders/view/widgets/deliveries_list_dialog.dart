import 'package:elamlymarket_dashboard/core/widgets/loading_item.dart';
import 'package:elamlymarket_dashboard/core/widgets/toast_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/widgets/buttons.dart';
import '../../controller/orders_cubit.dart';
import '../../model/order_model.dart';

class DeliveriesListDialog extends StatelessWidget {
  DeliveriesListDialog({super.key, required this.order});
  final OrdersModel order;

  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        height: 600,
        width: 400,
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              final controller = OrdersCubit.get(context);
              return controller.isLoadingDeliveries
                  ? const LoadingItem()
                  : controller.deliveries.isEmpty
                      ? const Center(
                          child: Text(
                            "No Deliveries Exist",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 21),
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: Column(
                                children: List.generate(
                                    controller.deliveries.length,
                                    (index) => Card(
                                          child: ListTile(
                                            leading: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(controller
                                                    .deliveries[index]
                                                    .personalImage
                                                    .toString())),
                                            title: Text(controller
                                                .deliveries[index].name
                                                .toString()),
                                            subtitle: Text(controller
                                                .deliveries[index].phoneNumber1
                                                .toString()),
                                            trailing: Radio(
                                              groupValue:
                                                  controller.selectedDelivery,
                                              onChanged: (val) {
                                                controller.setSelectedDelivery(
                                                    val: val, index: index);
                                              },
                                              value: controller
                                                  .deliveries[index].deliveryId,
                                            ),
                                          ),
                                        )),
                              ),
                            ),
                            order.isCancelled! || order.isPaid!
                                ? ButtonsWidget(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    text: "Close",
                                    icon: Icons.close,
                                    backgroundColor: AppColor.primaryColor)
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ButtonsWidget(
                                          onPressed: () {
                                            Navigator.pop(context);

                                            // controller.addAds();
                                          },
                                          text: "Cancel",
                                          icon: Icons.close,
                                          backgroundColor:
                                              AppColor.primaryColor),
                                      controller.isLoadingAssign
                                          ? const LoadingItem()
                                          : ButtonsWidget(
                                              onPressed: () {
                                                if (controller
                                                            .selectedDelivery ==
                                                        null ||
                                                    controller
                                                            .selectedDeliveryModel ==
                                                        null) {
                                                  toastApp(
                                                      message:
                                                          "Select Delivery");
                                                } else {
                                                  controller.assignDelivery(
                                                      order.orderId);
                                                }
                                              },
                                              text: "Assign",
                                              icon: Icons.done,
                                              backgroundColor:
                                                  AppColor.primaryColor),
                                    ],
                                  )
                          ],
                        );
            },
          ),
        )),
      ),
    );
  }
}
