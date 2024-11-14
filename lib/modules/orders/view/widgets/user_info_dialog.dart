import 'package:elamlymarket_dashboard/core/widgets/loading_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/responsive.dart';
import '../../controller/orders_cubit.dart';

class ShowUserInfoDialog extends StatelessWidget {
  const ShowUserInfoDialog({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<OrdersCubit>(context)..getUserData(userId),
        child: BlocBuilder<OrdersCubit, OrdersState>(builder: (context, state) {
          final controller = OrdersCubit.get(context);
          return Container(
            alignment: Alignment.center,
            child: Form(
              key: controller.formKey,
              child: SizedBox(
                height: Responsive.isDesktop(context) ? 600 : 180,
                width: 400,
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "User Info",
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
                      controller.isLoadingUserInfo
                          ? const LoadingItem()
                          : DefaultTextStyle(
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectableText("User ID : $userId"),
                                  SelectableText(
                                      "User Name :  ${controller.userData["fullname"]}"),
                                  SelectableText(
                                      "User E-mail :  ${controller.userData["email"]}"),
                                  SelectableText(
                                      "User Phone :  ${controller.userData["phone"]}"),
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
