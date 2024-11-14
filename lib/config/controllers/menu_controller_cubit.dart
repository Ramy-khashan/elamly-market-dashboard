 

import 'package:elamlymarket_dashboard/core/constant/storage_key.dart';
import 'package:elamlymarket_dashboard/main.dart';
import 'package:elamlymarket_dashboard/modules/login/view/login_screen.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; 

part 'menu_controller_state.dart';

class MenucontrollerCubit extends Cubit<MenucontrollerState> {
  MenucontrollerCubit() : super(MenucontrollerInitial());
  static MenucontrollerCubit get(context) => BlocProvider.of(context);
  String? name;
  String? id;
  String? email;
  String? role;
  String? isLogin;
initNotification(){
  // NotificationService().initNotification();

  //     FirebaseMessaging.onMessage.listen((event) async {
  //       String? title = event.notification?.title;
  //       String? body = event.notification?.body;

  //       await NotificationService().showNotification(
  //           Random().nextInt(10000) * Random().nextInt(10000),
  //           title ?? "",
  //           body ?? "");
  //     });

  //     FirebaseMessaging.onMessageOpenedApp.listen((event) {});
}
  getUserInfo() async {
    emit(MenucontrollerInitial());
    FlutterSecureStorage storage = const FlutterSecureStorage();
    name = await storage.read(key: StorageKey.name) ?? "Not Exsist";
    role = await storage.read(key: StorageKey.role) ?? "Not Exsist";
    email = await storage.read(key: StorageKey.email) ?? "Not Exsist";
    id = await storage.read(key: StorageKey.id) ?? "Not Exsist";
    isLogin = await storage.read(key: StorageKey.isLogin) ?? "false";
    emit(GetUserInfoState());
  }

  logOut() async {
    await const FlutterSecureStorage().deleteAll();
    Navigator.pushAndRemoveUntil(
        MarketDashboard.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }
}
