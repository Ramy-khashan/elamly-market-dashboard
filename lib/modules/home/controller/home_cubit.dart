import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  bool isLoading = false;
  getData() async {
    isLoading = true;
    emit(StartGetDataState());

    await Future.wait([
      getAllOrders(),
      getPendingOrders(),
      getCanceledOrders(),
      getDeliveredOrders(),
      getUsers(),
      getReports(),
      getDeliveries(),
      getProducts(),
    ]);

    isLoading = false;
    emit(GetAllDataState());
  }

  int allOrdersCount = 0;
  int allPendingOrdersCount = 0;
  int allCanceledOrdersCount = 0;
  int allDeliveredOrdersCount = 0;
  int allUsersCount = 0;
  int allReportsCount = 0;
  int allProductsCount = 0;
  int allDeliveriesCount = 0;
  Future getAllOrders() async {
    await FirebaseFirestore.instance.collection("orders").get().then((value) {
      allOrdersCount = value.docs.length;
    }).onError((error, stackTrace) {
      allOrdersCount = 0;
    });
  }

  Future getCanceledOrders() async {
    await FirebaseFirestore.instance
        .collection("orders")
        .where("is_cancelled", isEqualTo: true)
        .get()
        .then((value) {
      allCanceledOrdersCount = value.docs.length;
    }).onError((error, stackTrace) {
      allCanceledOrdersCount = 0;
    });
  }

  Future getDeliveredOrders() async {
    await FirebaseFirestore.instance
        .collection("orders")
        .where("is_paid", isEqualTo: true)
        .get()
        .then((value) {
      allDeliveredOrdersCount = value.docs.length;
    }).onError((error, stackTrace) {
      allDeliveredOrdersCount = 0;
    });
  }

  Future getPendingOrders() async {
    await FirebaseFirestore.instance
        .collection("orders")
        .where("is_paid", isEqualTo: false)
        .where("is_cancelled", isEqualTo: false)
        .get()
        .then((value) {
      allPendingOrdersCount = value.docs.length;
    }).onError((error, stackTrace) {
      allPendingOrdersCount = 0;
    });
  }

  Future getUsers() async {
    await FirebaseFirestore.instance.collection("users").get().then((value) {
      allUsersCount = value.docs.length;
    }).onError((error, stackTrace) {
      allUsersCount = 0;
    });
  }

  Future getDeliveries() async {
    await FirebaseFirestore.instance
        .collection("deliveries")
        .get()
        .then((value) {
      allDeliveriesCount = value.docs.length;
    }).onError((error, stackTrace) {
      allDeliveriesCount = 0;
    });
  }

  Future getReports() async {
    await FirebaseFirestore.instance.collection("reports").get().then((value) {
      allReportsCount = value.docs.length;
    }).onError((error, stackTrace) {
      allReportsCount = 0;
    });
  }

  Future getProducts() async {
    await FirebaseFirestore.instance.collection("products").get().then((value) {
      allProductsCount = value.docs.length;
    }).onError((error, stackTrace) {
      allProductsCount = 0;
    });
  }
  // List<Widget>items=
}
