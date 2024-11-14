import 'package:elamlymarket_dashboard/core/utils/validate.dart';
import 'package:elamlymarket_dashboard/core/widgets/text_field_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/loading_item.dart';
import '../../../../core/widgets/responsive.dart';
import '../../controller/orders_cubit.dart';

class DeliveryCancelDialog extends StatelessWidget {
  const DeliveryCancelDialog(
      {super.key,
      required this.msg,
      required this.onTapConfirm,
      this.isCancel = false,
      this.textController});
  final String msg;
  final bool isCancel;
  final TextEditingController? textController;
  final Function() onTapConfirm;
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
                    height: Responsive.isDesktop(context)
                        ? 600
                        : (isCancel ? 250 : 200),
                    width: 400,
                    child: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                  child: Text(
                                    msg,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                if (isCancel)
                                  TextFormFieldShape(
                                      hint: "Cancel Reason",
                                      controller: textController!,
                                      validate: (val) =>
                                          Validate.notEmpty(val)),
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
                                            onPressed: onTapConfirm,
                                            text: "Confirm",
                                            icon: Icons.done,
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
