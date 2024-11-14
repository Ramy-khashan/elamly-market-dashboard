import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket_dashboard/core/utils/send_notification.dart';
import 'package:elamlymarket_dashboard/core/widgets/toast_app.dart';
import 'package:elamlymarket_dashboard/modules/orders/model/delivery_address_model.dart';
import 'package:elamlymarket_dashboard/modules/orders/view/order_screen.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';
import '../../deliveries/model/delivery_model.dart';
import '../model/order_model.dart';
import '../view/widgets/cancel_delivery_dialog.dart';
import '../view/widgets/deliveries_list_dialog.dart';
import '../view/widgets/delivery_address_dialog.dart';
import '../view/widgets/products_dialog.dart';
import '../view/widgets/send_notification_dialog.dart';
import '../view/widgets/user_info_dialog.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial()) {
    selectedDelivery = null;
    selectedDeliveryModel = null;
  }
  static OrdersCubit get(context) => BlocProvider.of(context);
  List<OrdersModel> orderstems = [];
  final formKey = GlobalKey<FormState>();
  final notificationTitleController = TextEditingController();
  final notificationController = TextEditingController();
  final cancelResponseController = TextEditingController();
  late List<ExpandableColumn<dynamic>> headers;
  late List<ExpandableRow> rows;
  String? selectedDelivery;
  DeliveryModel? selectedDeliveryModel;
  bool isLoading = false;
  bool isLoadingCancelDelivery = false;
  Future getOrders() async {
    isLoading = true;
    orderstems = [];
    emit(LoadingGetOrdersState());

    FirebaseFirestore.instance.collection("orders").get().then((value) {
      for (var element in value.docs) {
        OrdersModel order = OrdersModel.fromJson(element.data());
        order.orderId = element.id;
        orderstems.add(order);
      }
      createDataSource();
      isLoading = false;
      emit(GetOrdersState());
    }).onError((error, stackTrace) {
      showDialog(
          context: MarketDashboard.navigatorKey.currentContext!,
          builder: (context) => AlertDialog(
                title: const Text(
                  "Failed",
                  style: TextStyle(fontSize: 23),
                ),
                content: SelectableText(error.toString()),
              ));
      isLoading = false;
      emit(FailedGetOrdersState());
    });
  }

  void createDataSource() {
    headers = [
      ExpandableColumn<int>(columnTitle: "ID", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Delivery Fees", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Total Price", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Products", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Delivery Address", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Created At", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "User Info", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Send Notification", columnFlex: 4),
      ExpandableColumn<String>(columnTitle: "Delivery ID", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Delivery Code", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Deliveries List", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Delivered", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Cancel Order", columnFlex: 3),
    ];

    rows = orderstems.map<ExpandableRow>((e) {
      return ExpandableRow(cells: [
        ExpandableCell<Widget>(
            columnTitle: "ID",
            value: Center(child: SelectableText(e.orderId.toString()))),
        ExpandableCell<Widget>(
            columnTitle: "Delivery Fees",
            value: SelectableText("${e.deliveryFees} L.E")),
        ExpandableCell<Widget>(
            columnTitle: "Total Price",
            value: SelectableText("${e.totalPrice} L.E")),
        ExpandableCell<Widget>(
            columnTitle: "Products",
            value: ElevatedButton(
              child: const Text("Show"),
              onPressed: () {
                showDialog(
                    context: MarketDashboard.navigatorKey.currentContext!,
                    builder: (context) => ShowProductDialog(
                          deliveryFees: e.deliveryFees ?? "",
                          totalPrice: e.totalPrice ?? "",
                          products: e.products ?? [],
                        ));
              },
            )),
        ExpandableCell<Widget>(
            columnTitle: "Delivery Address",
            value: ElevatedButton(
              child: const Text("Show"),
              onPressed: () {
                showDialog(
                    context: MarketDashboard.navigatorKey.currentContext!,
                    builder: (context) => ShowUserDeliveryAddressDialog(
                          deliveryAddress: e.deliveryAddressId!,
                          userID: e.userId!,
                        ));
              },
            )),
        ExpandableCell<Widget>(
            columnTitle: "Created At",
            value: Text(DateFormat("dd-EEEE  MM, yyyy - hh:mm a")
                .format(DateTime.parse(e.createdAt.toString())))),
        ExpandableCell<Widget>(
            columnTitle: "User Info",
            value: ElevatedButton(
              child: const Text("Show"),
              onPressed: () {
                showDialog(
                    context: MarketDashboard.navigatorKey.currentContext!,
                    builder: (context) => ShowUserInfoDialog(
                          userId: e.userId!,
                        ));
              },
            )),
        ExpandableCell<Widget>(
            columnTitle: "Send Notification",
            value: ElevatedButton(
              child: const Text("Send"),
              onPressed: () {
                showDialog(
                    context: MarketDashboard.navigatorKey.currentContext!,
                    builder: (context) => SendNotificationDialog(
                          token: e.notificationToken!,
                        ));
              },
            )),
        ExpandableCell<Widget>(
            columnTitle: "Delivery ID",
            value: SelectableText("${e.deliveryId} ")),
        ExpandableCell<Widget>(
            columnTitle: "Delivery Code", value: SelectableText("${e.code} ")),
        ExpandableCell<Widget>(
            columnTitle: "Deliveries List",
            value: ElevatedButton(
              child: const Text("Show"),
              onPressed: () {
                showDialog(
                    context: MarketDashboard.navigatorKey.currentContext!,
                    builder: (context) => DeliveriesListDialog(
                          order: e,
                        ));
                // showDialog(
                //     context: MarketDashboard.navigatorKey.currentContext!,
                //     builder: (context) => const SendNotificationDialog());
              },
            )),
        ExpandableCell<Widget>(
            columnTitle: "Delivered",
            value: e.isCancelled!
                ? const SizedBox()
                : e.isPaid!
                    ? const Text(
                        "Order Delivered",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      )
                    : ElevatedButton(
                        child: const Text("Delivery"),
                        onPressed: () {
                          showDialog(
                              context:
                                  MarketDashboard.navigatorKey.currentContext!,
                              builder: (context) => DeliveryCancelDialog(
                                  onTapConfirm: () {
                                    deliveredOrder(order: e);
                                  },
                                  msg:
                                      "Are you sure you want to confirm delivery this order?"));
                        },
                      )),
        ExpandableCell<Widget>(
            columnTitle: "Cancelled",
            value: e.isPaid!
                ? const SizedBox()
                : e.isCancelled!
                    ? const Text(
                        "Order Cancelled",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      )
                    : ElevatedButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          showDialog(
                              context:
                                  MarketDashboard.navigatorKey.currentContext!,
                              builder: (context) => DeliveryCancelDialog(
                                  isCancel: true,
                                  textController: cancelResponseController,
                                  onTapConfirm: () {
                                    cancelOrder(order: e);
                                  },
                                  msg:
                                      "Are you sure you want to cancel this order?"));
                        },
                      )),
      ]);
    }).toList();
  }

  Map<String, dynamic> userData = {};
  bool isLoadingUserInfo = false;
  getUserData(String getUserData) {
    userData = {};
    isLoadingUserInfo = true;
    emit(LoadingGetUserInfoState());

    FirebaseFirestore.instance
        .collection("users")
        .doc(getUserData)
        .get()
        .then((value) {
      userData = value.data()!;
      isLoadingUserInfo = false;
      emit(GetUserInfoState());
    }).onError((error, stackTrace) {
      AwesomeDialog(
              context: MarketDashboard.navigatorKey.currentContext!,
              desc: error.toString(),
              title: "Failed get user info")
          .show();
      isLoadingUserInfo = false;
      emit(FailedGetUserInfoState());
    });
  }

  DeliveryAddressModel? deliveryAddress;
  bool isLoadingDeliveryAddress = false;
  getDeliveryAddress(String deliveryAddressId, String userID) {
    deliveryAddress = null;
    isLoadingDeliveryAddress = true;
    emit(LoadingGetUserInfoState());

    FirebaseFirestore.instance
        .collection("delivery_address")
        .doc(userID)
        .collection("user_delivery_address")
        .doc(deliveryAddressId)
        .get()
        .then((value) {
      deliveryAddress = DeliveryAddressModel.fromJson(value.data()!);
      isLoadingDeliveryAddress = false;
      emit(GetUserInfoState());
    }).onError((error, stackTrace) {
      AwesomeDialog(
              context: MarketDashboard.navigatorKey.currentContext!,
              desc: error.toString(),
              title: "Failed get delivery address ")
          .show();
      isLoadingDeliveryAddress = false;
      emit(FailedGetUserInfoState());
    });
  }

  cancelOrder({OrdersModel? order}) {
    if (formKey.currentState!.validate()) {
      if (order!.orderId != null) {
        isLoadingCancelDelivery = true;

        FirebaseFirestore.instance
            .collection('orders')
            .doc(order.orderId)
            .update({
          'is_cancelled': true,
        }).then((value) {
          isLoadingCancelDelivery = true;
          toastApp(
            message: "Order Cancelled Successfully",
          );

          sendNotificaction;
          (
            token: order.notificationToken,
            title: "تم رفض الاوردر",
            "تم رفض الاوردر رقم ${order.orderId} \n ${cancelResponseController.text}"
          );
          FirebaseFirestore.instance
              .collection("orders")
              .doc(order.orderId)
              .update({"cancelReason": cancelResponseController.text});
          Navigator.pop(MarketDashboard.navigatorKey.currentContext!);
        }).catchError((error, stackTrace) {
          isLoadingCancelDelivery = true;

          AwesomeDialog(
                  context: MarketDashboard.navigatorKey.currentContext!,
                  desc: error.toString(),
                  title: "Failed to cancel order")
              .show();
        });
      }
    }
  }

  deliveredOrder({OrdersModel? order}) {
    if (order!.orderId != null) {
      isLoadingCancelDelivery = true;

      FirebaseFirestore.instance
          .collection('orders')
          .doc(order.orderId)
          .update({
        'is_paid': true,
      }).then((value) async {
        isLoadingCancelDelivery = false;
        toastApp(
          message: "Order delivered Successfully",
        );
        sendNotificaction;
        (
          token: order.notificationToken,
          title: "تم توصيل الاوردر",
          "الأوردر ${order.orderId} لقد تم التوصيل والدفع بنجاح, شكرا لتعاملك مع العاملي ماركت."
        );

        Navigator.pop(MarketDashboard.navigatorKey.currentContext!);
      }).catchError((error, stackTrace) {
        isLoadingCancelDelivery = false;
        AwesomeDialog(
                context: MarketDashboard.navigatorKey.currentContext!,
                desc: error.toString(),
                title: "Failed to deliver order")
            .show();
      });
    }
  }

  List<DeliveryModel> deliveries = [];
  bool isLoadingDeliveries = false;
  getDeliveries() async {
    isLoadingDeliveries = true;
    deliveries = [];
    emit(LoadinDeliveriesState());

    FirebaseFirestore.instance
        .collection("deliveries")
        .where("is_active", isEqualTo: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        deliveries.add(DeliveryModel.fromJson(element.data()));
      }
      isLoadingDeliveries = false;
      emit(DeliveriesLoadedState());
    }).onError((error, stackTrace) {
      AwesomeDialog(
              context: MarketDashboard.navigatorKey.currentContext!,
              title: "Failed to get deliveries",
              desc: error.toString())
          .show();
      isLoadingDeliveries = false;

      emit(DeliveriesLoadErrorState());
    });
  }

  setSelectedDelivery({val, int? index}) {
    emit(OrdersInitial());
    selectedDelivery = val;
    selectedDeliveryModel = deliveries[index!];
    emit(SelectedDeliveryState());
  }

  bool isLoadingAssign = false;
  assignDelivery(String? orderId) async {
    isLoadingAssign = true;
    emit(LoadingAssignDeliveryState());

    await FirebaseFirestore.instance.collection("orders").doc(orderId).update(
        {"delivery_id": selectedDeliveryModel!.deliveryId}).whenComplete(() {
      isLoadingAssign = false;
      emit(SuccessAssignDeliveryState());
      Navigator.pushReplacement(MarketDashboard.navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => const OrdersScreen()));
    }).onError((error, stackTrace) {
      isLoadingAssign = false;
      emit(FailedAssignDeliveryState());
    });
  }
}
