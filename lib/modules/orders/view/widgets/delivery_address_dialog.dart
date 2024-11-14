import 'package:elamlymarket_dashboard/core/widgets/loading_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/orders_cubit.dart';

class ShowUserDeliveryAddressDialog extends StatelessWidget {
  const ShowUserDeliveryAddressDialog(
      {super.key, required this.deliveryAddress, required this.userID});
  final String deliveryAddress;
  final String userID;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<OrdersCubit>(context)
          ..getDeliveryAddress(deliveryAddress, userID),
        child: BlocBuilder<OrdersCubit, OrdersState>(builder: (context, state) {
          final controller = OrdersCubit.get(context);
          return Container(
            alignment: Alignment.center,
            child: Form(
              key: controller.formKey,
              child: SizedBox(
                // height: Responsive.isDesktop(context) ? 600 : 250,
                width: 400,
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "User Delivery Address",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ))
                        ],
                      ),
                      controller.isLoadingDeliveryAddress
                          ? const LoadingItem()
                          : controller.deliveryAddress == null
                              ? const Center(
                                  child: Text(
                                  "No Delivery Address Exists",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600),
                                ))
                              : DefaultTextStyle(
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name : ${controller.deliveryAddress!.fullName}",
                                      ),
                                      Text(
                                        "Phone : ${controller.deliveryAddress!.phone1}",
                                      ),
                                      Text(
                                        "Phone2 : ${controller.deliveryAddress!.phone2!.isEmpty ? "Not Exists" : controller.deliveryAddress!.phone2}",
                                      ),
                                      Text(
                                        "Address : ${controller.deliveryAddress!.fullAddress}",
                                      ),
                                      Text(
                                        "Land Mark : ${controller.deliveryAddress!.landmark}",
                                      ),
                                    ],
                                  ),
                                )
                    ],
                  ),
                )),
              ),
            ),
          );
        }));
  }
}
